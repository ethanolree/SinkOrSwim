//
//  ImageModel.m
//  SinkOrSwim
//
//  Created by Ethan Olree on 9/11/22.
//

#import "ImageModel.h"
#import "UIKit/UIKit.h"

@interface ImageModel();

@property (strong, nonatomic) NSDictionary* imageNameDict;

@end

@implementation ImageModel
@synthesize imageNameDict = _imageNameDict;

+(ImageModel*)sharedInstance {
    static ImageModel* _sharedInstance = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _sharedInstance = [[ImageModel alloc] init];
    });
    
    return _sharedInstance;
}

-(NSDictionary*) imageNameDict {
    if (!_imageNameDict)
        _imageNameDict = @{
            @"Movie 1" : @[@"breakfastClub1", @"breakfastClub2", @"breakfastClub3"],
            @"Movie 2": @[@"goneGirl3", @"goneGirl2", @"goneGirl1"],
            @"Movie 3": @[@"babyDriver3", @"babyDriver2", @"babyDriver1"],
            @"Movie 4": @[@"socialNetwork2", @"socialNetwork1", @"socialNetwork3"],
            @"Movie 5": @[@"whiplash1", @"whiplash2", @"whiplash3"]
        };
    
    return _imageNameDict;
}

-(NSArray*)getImageNamesForValue:(NSString*)name {
    return [[self imageNameDict] valueForKey:name];
}

-(UIImage*)getImageWithName:(NSString*)name {
    UIImage* image = nil;
    
    image = [UIImage imageNamed:name];
    
    return image;
}

@end
