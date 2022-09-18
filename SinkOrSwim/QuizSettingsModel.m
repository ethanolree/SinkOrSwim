//
//  QuizSettingsModel.m
//  SinkOrSwim
//
//  Created by Alex Gregory on 9/17/22.
//

#import "QuizSettingsModel.h"

@interface QuizSettingsModel()
@property (readwrite, nonatomic) BOOL hints;
@property (readwrite, nonatomic) NSInteger noOfQuestions;

@end

@implementation QuizSettingsModel
@synthesize hints = _hints;
@synthesize noOfQuestions = _noOfQuestions;

+(QuizSettingsModel*)sharedInstance {
    static QuizSettingsModel* _sharedInstance = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _sharedInstance = [[QuizSettingsModel alloc] init];
    });
    
    return _sharedInstance;
}

-(void)setNoOfQuestions: (NSInteger) value{
    _noOfQuestions = value;
}

-(void)setHintsYesOrNo: (BOOL) value{
    _hints = value;
}

-(NSInteger)getNoOfQuestions{
    return (NSInteger)[self noOfQuestions];
}

-(BOOL)getHintsYesOrNo{
    return (BOOL)[self hints];
}

@end
