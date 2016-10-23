//
//  UserModel.m
//  week
//
//  Created by mac16 on 16/9/18.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+(nullable NSDictionary<NSString *,id>*)modelCustomPropertyMapper{
    return @{
             @"des":@"description"
             };
}

@end
