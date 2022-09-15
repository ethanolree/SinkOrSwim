//
//  AnswerKeyModel.h
//  SinkOrSwim
//
//  Created by Ethan Olree on 9/13/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnswerKeyModel : UITableViewCell

-(BOOL)checkAnswer:(NSString*)key withValue:(NSString*)guess;

@end

NS_ASSUME_NONNULL_END
