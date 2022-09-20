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
-(void)setLanguage:(NSString *)language;
-(NSInteger)getNoOfQuestions;
-(BOOL)getHintsYesOrNo;
-(NSString*)getLanguage;

@end

NS_ASSUME_NONNULL_END
