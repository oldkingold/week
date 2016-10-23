//
//  UIImage+ZidingyiSize.h
//  week
//
//  Created by Mac on 16/9/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZidingyiSize)
- (UIImage *)rescaleImageToRect:(CGRect)rect;
- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
@end
