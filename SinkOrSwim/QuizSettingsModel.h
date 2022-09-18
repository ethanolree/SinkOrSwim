//
//  QuizSettingsModel.h
//  SinkOrSwim
//
//  Created by Alex Gregory on 9/17/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuizSettingsModel : NSObject

+(QuizSettingsModel*)sharedInstance;
-(void)setNoOfQuestions:(NSInteger)value;
-(void)setHintsYesOrNo:(BOOL)value;
-(NSInteger)getNoOfQuestions;
-(BOOL)getHintsYesOrNo;

@end

NS_ASSUME_NONNULL_END
