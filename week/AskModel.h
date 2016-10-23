//
//  AskModel.h
//  week
//
//  Created by mac16 on 16/9/21.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AskModel : NSObject
//{
//    answer =         {
//        "comment_content" = "\U4e0d\U597d\U610f\U601d\U554a\Uff01\U4e0d\U662f\U94f6\U9ecf\U571f\Uff0c\U7528\U7684\U662f\U94f6\U6761\U94f6\U7c92";
//        "comment_id" = 4741773788366690;
//        "comment_time" = "2016-09-18 13:42:58";
//        "image_info" = "<null>";
//        "image_info_list" =             (
//        );
//        "image_list" =             (
//        );
//        "image_url" = "<null>";
//        "reply_comment_id" = "<null>";
//        "reply_content" = "";
//        "reply_floor" = "<null>";
//        "reply_time" = "<null>";
//        "reply_user_info" =             {
//            "avatar_url" = "";
//            "user_id" = "<null>";
//            "user_name" = "";
//        };
//        "site_title" = "";
//        "site_url" = "";
//        "user_floor" = 1;
//        "user_info" =             {
//            "avatar_url" = "http://image.lanrenzhoumo.com/leo/img/20160511174852_a810c3eb59113f4346a62ffe986fafa0.jpg";
//            "card_number" = "";
//            "contacts_phone" = 13065701520;
//            name = "89\U53f7\U624b\U5de5\U6212\U6307\U5de5\U574a";
//            phone = 13065701520;
//            "user_id" = 100008726;
//            "user_name" = "89\U53f7\U624b\U5de5\U6212\U6307\U5de5\U574a";
//        };
//    };

//    "answer_id" = 4741773788366690;
//    "comment_number" = 1;
//    content = "\U662f\U7528\U94f6\U9ecf\U571f\U5236\U4f5c\U5417\Uff1f";
//    "create_time" = "2016-09-18 13:38:37";
//    "faq_id" = 4741771170786780;
//    "group_id" = 30146;
//    "image_info_list" =         (
//    );
//    "image_list" =         (
//    );
//    "leo_id" = 1351237203;
//    "post_time" = "2016-09-18 13:42:58";
//    title = "\U662f\U7528\U94f6\U9ecf\U571f\U5236\U4f5c\U5417\Uff1f";
//    "user_id" = 988119;
//    "user_info" =         {
//        "avatar_url" = "http://image.lanrenzhoumo.com/leo/avatar/20160918111128_0.png";
//        "card_number" = "";
//        "contacts_phone" = "";
//        name = "";
//        phone = "oBVCEv8HAIiMtFnNkPslW3UBa_C0";
//        "user_id" = 988119;
//        "user_name" = "\U756a\U8304\U8ff7\U9b42\U6c64";
//    };
//},
@property (copy, nonatomic)NSString *title;//用户发的主题
@property (copy, nonatomic)NSString *post_time;//用户发送时间
@property (copy, nonatomic)NSDictionary *user_info;//用户信息
@property (copy, nonatomic)NSDictionary *answer;//回复


@end
