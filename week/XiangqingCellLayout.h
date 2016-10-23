//
//  XiangqingCellLayout.h
//  week
//
//  Created by mac16 on 16/9/19.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import <UIKit/UIKit.h>
@interface XiangqingCellLayout : NSObject

@property (nonatomic, strong)UserModel *user;
+(instancetype)layoutWithUserModel:(UserModel *)user;

@property (nonatomic, assign)CGRect titleLabelFrame;
@property (nonatomic, assign)CGRect secLabelFrame;
@property (nonatomic, assign)CGRect iconImageFrame;
@property (nonatomic, assign)CGRect typeLabelFrame;
@property (nonatomic, assign)CGRect priceLabelFrame;
@property (nonatomic, assign)CGRect timeInfoFrame;
@property (nonatomic, assign)CGRect addressButtonFrame;
@property (nonatomic, assign)CGRect huodongLabelFrame;
//@property (nonatomic, assign)CGRect typeTextLabelFrame;
@property (nonatomic, assign)CGRect kongFrame;

@property (nonatomic, assign)CGRect xqViewFrame;
@property (nonatomic, copy)NSMutableArray *array;

-(CGFloat)_cellHeight;

@end

