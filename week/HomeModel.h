//
//  HomeModel.h
//  week
//
//  Created by mac on 16/9/2.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>
@class userModel;

@interface HomeModel : NSObject

@property (assign, nonatomic)NSInteger distance;
@property (copy, nonatomic)NSString *title;
@property (assign, nonatomic)BOOL show_free;
@property (assign, nonatomic)NSInteger leo_id;
@property (copy, nonatomic)NSString *address;
@property (copy, nonatomic)NSString *time_desc;
@property (copy, nonatomic)NSString *collected_num;
@property (copy, nonatomic)NSString *time_info;
@property (strong, nonatomic)NSArray *front_cover_image_list;
@property (copy, nonatomic)NSString *poi;
@property (copy, nonatomic)NSString *category;

@property (assign,nonatomic)double price;

@end
