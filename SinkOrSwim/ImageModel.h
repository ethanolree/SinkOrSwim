//
//  ImageModel.h
//  SinkOrSwim
//
//  Created by Ethan Olree on 9/11/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKey.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageModel : NSObject


+(ImageModel*)sharedInstance;
-(NSArray*)imageNames;
-(NSDictionary*)imageNameDict;
-(NSArray*)getImageNamesForValue:(NSString*)name;
-(NSString*)getImageNameForIndex:(NSInteger)index;
-(UIImage*)getImageWithName:(NSString*)name;

@end

NS_ASSUME_NONNULL_END
