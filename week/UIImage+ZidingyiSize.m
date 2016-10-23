//
//  UIImage+ZidingyiSize.m
//  week
//
//  Created by Mac on 16/9/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "UIImage+ZidingyiSize.h"

@implementation UIImage (ZidingyiSize)
- (UIImage *)rescaleImageToRect:(CGRect)rect {
    
//    CGRect _rect = rect;
    
    UIGraphicsBeginImageContext(rect.size);
    
    [self drawInRect:rect];  // scales image to rect
    
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resImage;
    
}
- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize


{
    
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}
@end
