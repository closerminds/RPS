//
//  UtilsObject.m
//  RPS
//
//  Created by Jeremy on 04/08/2016.
//  Copyright © 2016 Jeremy. All rights reserved.
//

#import "UtilsObject.h"

@interface UtilsObject()
@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, assign) CGFloat screenHeight;
@end

@implementation UtilsObject
@synthesize screenWidth,screenHeight;

-(id)init{
    self = [super init];
    if (self) {
        CGRect rect = [[UIScreen mainScreen] bounds];
        self.screenWidth = rect.size.width;
        self.screenHeight = rect.size.height;
    }
    return self;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
