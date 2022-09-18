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
@synthesize hints;
@synthesize noOfQuestions;


-(void)setNoOfQuestions: (NSInteger) value{
    noOfQuestions = value;
}

-(void)setHintsYesOrNo: (BOOL) value{
    hints = value;
}

-(NSInteger)getNoOfQuestions{
    return (NSInteger)[self noOfQuestions];
}

-(BOOL)getHintsYesOrNo{
    return (BOOL)[self hints];
}

@end
