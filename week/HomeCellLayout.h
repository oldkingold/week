//
//  /Users/mac16/Desktop/week 2/week.xcodeprojHomeCellLayout.h
//  week
//
//  Created by mac16 on 16/9/13.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeModel.h"
#import <UIKit/UIKit.h>



@interface HomeCellLayout : NSObject

@property (nonatomic, strong)HomeModel *home;

+(instancetype)layoutWithHomeModel:(HomeModel *)home;

@property (nonatomic, assign) CGRect HomeTitleFrame;
@property (nonatomic, assign) CGRect HomeAddressFrame;
@property (nonatomic, assign) CGRect HomeTimeFrame;
@property (nonatomic, assign) CGRect HomelikeFrame;
@property (nonatomic, assign) CGRect HomePriceFrame;

@property (nonatomic, assign) CGRect HomeImageFrame;

-(CGFloat)_cellHeiht;

@end
