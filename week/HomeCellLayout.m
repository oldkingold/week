//
//  HomeCellLayout.m
//  week
//
//  Created by mac16 on 16/9/13.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "HomeCellLayout.h"
#import <UIKit/UIKit.h>

@interface HomeCellLayout()
{
    CGFloat _cellHeight;
}
@end

@implementation HomeCellLayout

+(instancetype)layoutWithHomeModel:(HomeModel *)home{
    HomeCellLayout *layout = [[HomeCellLayout alloc]init];
    if (layout) {
        layout.home = home;
    }
    return  layout;
    
}

-(void)setHome:(HomeModel *)home{
    if (_home == home) {
        return;
    }
    _home= home;
    
    _cellHeight = 0;
    
    _HomeImageFrame = CGRectMake(0, 0, kScreenWidth, 200);
    _cellHeight += CellImageViewHeight;
    _cellHeight += SpaceHeight;
    
    CGRect rect = [_home.title boundingRectWithSize:CGSizeMake(kScreenWidth-20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];

    CGFloat homeTitleHeight = rect.size.height;
    _HomeTitleFrame = CGRectMake(10, _cellHeight, kScreenWidth-20, homeTitleHeight);
    _cellHeight += homeTitleHeight;
    _cellHeight += LabelSpaceHeight;
    
    NSString *str1 = [NSString stringWithFormat:@"%@・%@",_home.poi,_home.category];
    CGRect rect1 = [str1 boundingRectWithSize:CGSizeMake(1000, OtherLabelHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    CGFloat homeAddressWidth = rect1.size.width;
    _HomeAddressFrame = CGRectMake(10, _cellHeight, homeAddressWidth, OtherLabelHeight);
    _cellHeight += OtherLabelHeight;
    _cellHeight += LabelSpaceHeight;
    
    CGRect rect2 = [_home.time_info boundingRectWithSize:CGSizeMake(1000, OtherLabelHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    CGFloat homeTimeWidth = rect2.size.width;
    _HomeTimeFrame = CGRectMake(10, _cellHeight, homeTimeWidth+10, OtherLabelHeight);
    
    NSString *str3 = [NSString stringWithFormat:@"%@人收藏",_home.collected_num];
    CGRect rect3 = [str3 boundingRectWithSize:CGSizeMake(1000, OtherLabelHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    CGFloat homeLikeWidth = rect3.size.width;
    _HomelikeFrame = CGRectMake(10+homeTimeWidth+20, _cellHeight, homeLikeWidth+10, OtherLabelHeight);
    
    NSString *str4 = [NSString stringWithFormat:@"¥%.0f",_home.price];
    CGRect rect4 = [str4 boundingRectWithSize:CGSizeMake(1000, OtherLabelHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    CGFloat homePriceWidth = rect4.size.width;
    _HomePriceFrame = CGRectMake(kScreenWidth-10-homePriceWidth-10, _cellHeight, homePriceWidth+10, OtherLabelHeight);

    _cellHeight += OtherLabelHeight;
    _cellHeight +=10;
    
}

-(CGFloat)_cellHeiht{
    return _cellHeight;
}
@end
