//
//  AnswerKeyModel.m
//  SinkOrSwim
//
//  Created by Ethan Olree on 9/13/22.
//

#import "AnswerKeyModel.h"

@interface AnswerKeyModel()

@property (strong, nonatomic) NSDictionary* answerKeyDict;
@property (strong, nonatomic) NSMutableDictionary* guessesDict;

@end

@implementation AnswerKeyModel
@synthesize answerKeyDict = _answerKeyDict;
@synthesize guessesDict = _guessesDict;

-(NSDictionary*) answerKeyDict {
    if (!_answerKeyDict)
        _answerKeyDict = @{
            @"Movie 1" : @"BREAKFAST CLUB",
            @"Movie 2": @"GONE GIRL",
            @"Movie 3": @"BABY DRIVER",
            @"Movie 4": @"THE SOCIAL NETWORK"
        };
    
    return _answerKeyDict;
}

-(NSMutableDictionary*) guessesDict {
    if (!_guessesDict) {
        NSFileManager* manager = [NSFileManager defaultManager];
        NSString* filepath = [NSHomeDirectory() stringByAppendingString:@"/myBin.bin"];
        NSURL* currentPathURL = [NSURL fileURLWithPath: filepath];
        
        if ([manager fileExistsAtPath:filepath]) {
            NSData* readData = [NSData dataWithContentsOfURL:currentPathURL];
            _guessesDict = [[NSJSONSerialization JSONObjectWithData:readData options:0 error:nil] mutableCopy];
        } else {
            _guessesDict = [@{
                @"Movie 1": @{@"correct": @0, @"incorrect": @0},
                @"Movie 2": @{@"correct": @0, @"incorrect": @0},
                @"Movie 3": @{@"correct": @0, @"incorrect": @0},
                @"Movie 4": @{@"correct": @0, @"incorrect": @0}
            } mutableCopy];
        }
    }
    
    return _guessesDict;
}

-(void) setGuessesDict:(NSMutableDictionary*)value {
    _guessesDict = value;
}

+(AnswerKeyModel*)sharedInstance {
    static AnswerKeyModel* _sharedInstance = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _sharedInstance = [[AnswerKeyModel alloc] init];
    });
    
    return _sharedInstance;
}

-(NSString*)getCorrectAnswer:(NSString*)key {
    NSString* val = @"";
    
    if ([[[self guessesDict] valueForKey:key] valueForKey:@"correct"] > 0) {
        val = [[[self answerKeyDict] valueForKey:key] capitalizedString];
    }
    
    return val;
}

-(NSInteger)getCorrectGuessCount:(NSString*)key {
    return [[[[self guessesDict] valueForKey:key] valueForKey:@"correct"] integerValue];
}

-(NSInteger)getIncorrectGuessCount:(NSString*)key {
    return [[[[self guessesDict] valueForKey:key] valueForKey:@"incorrect"] integerValue];
}

-(NSInteger)getTotalCorrectGuessCount {
    NSInteger count = 0;
    
    for (id movie in [self guessesDict]) {
        count += [[[[self guessesDict] valueForKey:movie] valueForKey:@"correct"] integerValue];
    }
    
    return count;
}

-(NSInteger)getTotalIncorrectGuessCount {
    NSInteger count = 0;
    
    for (id movie in [self guessesDict]) {
        count += [[[[self guessesDict] valueForKey:movie] valueForKey:@"incorrect"] integerValue];
    }
    
    return count;
}

-(BOOL)checkAnswer:(NSString*)key withValue:(NSString*)guess {
    BOOL correct = [[[self answerKeyDict] valueForKey:key] caseInsensitiveCompare:guess] == NSOrderedSame;

    NSMutableDictionary* correctAnswers = [self guessesDict];
    
    NSDictionary* valueForKey = [correctAnswers valueForKey:key];
    
    if (valueForKey) {
        if (correct) {
            NSNumber* number = [valueForKey objectForKey:@"correct"];
            NSInteger quantity = [number integerValue];
            [correctAnswers setValue: @{
                @"correct": @(quantity + 1),
                @"incorrect": [valueForKey valueForKey:@"incorrect"]
            } forKey:key];
        } else {
            NSNumber* number = [valueForKey objectForKey:@"incorrect"];
            NSInteger quantity = [number integerValue];
            [correctAnswers setObject: @{
                @"correct": [valueForKey valueForKey:@"correct"],
                @"incorrect": @(quantity + 1)
            } forKey:key];
        }
    } else {
        if (correct) {
            [correctAnswers setObject:@{@"correct": @1, @"incorrect": @0} forKey:key];
        } else {
            [correctAnswers setObject:@{@"correct": @0, @"incorrect": @1} forKey:key];
        }
        
    }
    
    
    NSFileManager* manager = [NSFileManager defaultManager];
    NSString* filepath = [NSHomeDirectory() stringByAppendingString:@"/myBin.bin"];
    NSURL* currentPathURL = [NSURL fileURLWithPath: filepath];
    
    [manager removeItemAtPath:filepath error:nil];
    NSData* data2 = [NSJSONSerialization dataWithJSONObject:correctAnswers options:0 error:nil];
    [data2 writeToURL:currentPathURL atomically:true];
    [manager createFileAtPath:filepath contents:data2 attributes:nil];
    
    return correct;
}

-(void)resetAnswers {
    NSFileManager* manager = [NSFileManager defaultManager];
    
    NSString* filepath = [NSHomeDirectory() stringByAppendingString:@"/myBin.bin"];
    
    NSURL* currentPathURL = [NSURL fileURLWithPath: filepath];
    NSMutableDictionary* correctAnswers = [[self guessesDict] mutableCopy];
    
    for (id movie in [self guessesDict]) {
        [correctAnswers setObject:@{@"correct": @0, @"incorrect": @0} forKey:movie];
    }
    [self setGuessesDict:correctAnswers];
    
    
    [manager removeItemAtPath:filepath error:nil];
    NSData* data2 = [NSJSONSerialization dataWithJSONObject:correctAnswers options:0 error:nil];
    [data2 writeToURL:currentPathURL atomically:true];
    [manager createFileAtPath:filepath contents:data2 attributes:nil];
}
@end
