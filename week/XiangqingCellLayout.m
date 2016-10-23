//
//  XiangqingCellLayout.m
//  week
//
//  Created by mac16 on 16/9/19.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "XiangqingCellLayout.h"

@interface XiangqingCellLayout (){
    CGFloat _cellHeight;
//    NSMutableArray *array;
    CGFloat _xqViewHeight;
}

@end

@implementation XiangqingCellLayout

+(instancetype)layoutWithUserModel:(UserModel *)user{
    XiangqingCellLayout *layout = [[XiangqingCellLayout alloc]init];
    if (layout) {
        layout.user = user;
    }
    return layout;
}
-(void)setUser:(UserModel *)user{
    if (_user == user) {
        return;
    }
    
    _user = user;
    
    _cellHeight = 0;
    
    CGRect rect = [_user.title boundingRectWithSize:CGSizeMake(kScreenWidth-20,1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25]} context:nil];
    CGFloat titleLabelheight = rect.size.height;
    
    _titleLabelFrame = CGRectMake(15, _cellHeight, kScreenWidth-30, titleLabelheight);
    _cellHeight += titleLabelheight;
    
    _secLabelFrame = CGRectMake(-2, _cellHeight, kScreenWidth+4, 48);
    _cellHeight += 48;
    
    _iconImageFrame = CGRectMake(20, 24-15, 30, 30);
    CGRect rect1 = [_user.category[@"cn_name"] boundingRectWithSize:CGSizeMake(1000,48) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
    CGFloat typeLabelWidth = rect1.size.width;
    _typeLabelFrame = CGRectMake(20+30+8,0, typeLabelWidth, 48);
    
    CGRect rect2 = [_user.price_info boundingRectWithSize:CGSizeMake(1000,48) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
    CGFloat priceLabelWidth = rect2.size.width;
    _priceLabelFrame = CGRectMake(kScreenWidth-20-priceLabelWidth, 0, priceLabelWidth+20, 48);
    
    _timeInfoFrame = CGRectMake(15, _cellHeight, kScreenWidth-15, 48);
    _cellHeight += 48;
    
    NSString *str = [NSString stringWithFormat:@"%@ · %@",_user.address,_user.poi];
    CGRect rect3 = [str boundingRectWithSize:CGSizeMake(kScreenWidth-15-20,1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
    CGFloat addressButtonHeight = rect3.size.height;
    _addressButtonFrame = CGRectMake(5, _cellHeight, kScreenWidth-15-20, addressButtonHeight);
    _cellHeight += addressButtonHeight;
  
    
    _kongFrame = CGRectMake(-2, _cellHeight, kScreenWidth+4, 30);
    _cellHeight += 30;
    _huodongLabelFrame = CGRectMake((kScreenWidth-74)/2, _cellHeight, 74, 20);
    _cellHeight += 20;
    _xqViewHeight = 0;
    NSMutableArray *fArray = [[NSMutableArray alloc]init];
    for (int i= 0; i<_user.des.count; i++) {
        if ([_user.des[i][@"type"]isEqualToString:@"text"]) {
             CGRect rect4 = [_user.des[i][@"content"] boundingRectWithSize:CGSizeMake(kScreenWidth-15-20,1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
            CGFloat typeTextLabelHeight = rect4.size.height;
            CGRect typeTextLabelFrame = CGRectMake(10, _xqViewHeight, kScreenWidth-20, typeTextLabelHeight);
            _xqViewHeight += typeTextLabelHeight;
            [fArray addObject:[NSValue valueWithCGRect:typeTextLabelFrame]];
        }else{
            NSArray *size = _user.des[i][@"size"];
//            NSLog(@"size = %@",size);
            float height = [size[1] floatValue]*kScreenWidth/[size[0] floatValue];
            CGRect typeImageFrame = CGRectMake(0, _xqViewHeight+5, kScreenWidth, height);
            _xqViewHeight +=height +5 ;
            [fArray addObject:[NSValue valueWithCGRect:typeImageFrame]];
        }
        
        
    }
    _array = [fArray mutableCopy];
    _xqViewFrame = CGRectMake(0, _cellHeight, kScreenWidth, _xqViewHeight);

    _cellHeight += _xqViewHeight;
    
       
    }

-(CGFloat)_cellHeight{
    return _cellHeight;
}


@end
