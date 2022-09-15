//
//  AnswerKeyModel.m
//  SinkOrSwim
//
//  Created by Ethan Olree on 9/13/22.
//

#import "AnswerKeyModel.h"

@interface AnswerKeyModel()

@property (strong, nonatomic) NSDictionary* answerKeyDict;

@end

@implementation AnswerKeyModel
@synthesize answerKeyDict = _answerKeyDict;

-(NSDictionary*) answerKeyDict {
    if (!_answerKeyDict)
        _answerKeyDict = @{
            @"Movie 1" : @"BREAKFAST CLUB",
            @"Movie 2": @"GONE GIRL",
            @"Movie 3": @"BABY DRIVER"
        };
    
    return _answerKeyDict;
}

-(BOOL)checkAnswer:(NSString*)key withValue:(NSString*)guess {
    return [[[self answerKeyDict] valueForKey:key] caseInsensitiveCompare:guess] == NSOrderedSame;
}

@end
