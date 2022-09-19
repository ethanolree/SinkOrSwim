//
//  AnswerKeyModel.h
//  SinkOrSwim
//
//  Created by Ethan Olree on 9/13/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnswerKeyModel : UITableViewCell

+(AnswerKeyModel*)sharedInstance;
-(BOOL)checkAnswer:(NSString*)key withValue:(NSString*)guess;
-(NSString*)getCorrectAnswer:(NSString*)key;
-(void)resetAnswers;
-(NSInteger)getCorrectGuessCount:(NSString*)key;
-(NSInteger)getIncorrectGuessCount:(NSString*)key;
-(NSInteger)getTotalCorrectGuessCount;
-(NSInteger)getTotalIncorrectGuessCount;

@end

NS_ASSUME_NONNULL_END
