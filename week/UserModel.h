//
//  UserModel.h
//  week
//
//  Created by mac16 on 16/9/18.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject


@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic)NSString *city;
@property (strong, nonatomic)NSString *poi;
@property (assign, nonatomic)NSInteger min_price;
@property (copy, nonatomic)NSDictionary *category;
@property (strong, nonatomic)NSString *price_info;
@property (copy, nonatomic)NSDictionary *time;
@property (strong, nonatomic)NSString *address;
@property (copy, nonatomic)NSArray *des;

@property (copy, nonatomic)NSArray *images;

@end
