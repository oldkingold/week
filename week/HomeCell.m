//
//  HomeCell.m
//  week
//
//  Created by mac on 16/8/28.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "HomeCell.h"
#import "UIImageView+WebCache.h"
#import "HomeCellLayout.h"
@interface HomeCell ()
{
    
}
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UILabel *addressLabel;
@property (strong, nonatomic)  UILabel *timeLabel;
@property (strong, nonatomic)  UILabel *likeLabel;
@property (strong, nonatomic)  UILabel *priceLabel;

@property (strong, nonatomic)  UIImageView *homeImageView;



@end

@implementation HomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
    
}

-(void)createCell{
    _homeImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:_homeImageView];
    
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _titleLabel.numberOfLines = 0;
    [self addSubview:_titleLabel];
    _titleLabel.textColor = [UIColor grayColor];
   
    
    _addressLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_addressLabel];
    _addressLabel.textColor = [UIColor grayColor];
    _addressLabel.font = [UIFont systemFontOfSize:15];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_timeLabel];
    _timeLabel.layer.cornerRadius = 5;
    _timeLabel.layer.borderWidth = 1;
    _timeLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textColor = [UIColor grayColor];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    
    _likeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_likeLabel];
    _likeLabel.layer.cornerRadius = 5;
    _likeLabel.layer.borderWidth = 1;
    _likeLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _likeLabel.font = [UIFont systemFontOfSize:14];
    _likeLabel.textColor = [UIColor grayColor];
    _likeLabel.textAlignment = NSTextAlignmentCenter;
    
    _priceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_priceLabel];
    _priceLabel.layer.cornerRadius = 5;
    _priceLabel.layer.borderWidth = 1;
    _priceLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _priceLabel.font = [UIFont systemFontOfSize:14];
    _priceLabel.textColor = [UIColor grayColor];
    _priceLabel.textAlignment = NSTextAlignmentCenter;

    
}

-(void)setHome:(HomeModel *)home{
    _home = home;
    
    //布局对象
    HomeCellLayout *layout = [[HomeCellLayout alloc]init];
    layout.home = home;
    //图片
    NSString *string = _home.front_cover_image_list[0];
    NSURL *url = [NSURL URLWithString:string];
    [_homeImageView sd_setImageWithURL:url];
    _homeImageView.frame = layout.HomeImageFrame;
    
    
    //标题
    _titleLabel.text = _home.title;
   _titleLabel.frame = layout.HomeTitleFrame;
    //地址
    _addressLabel.text = [NSString stringWithFormat:@"%@・%@",_home.poi,_home.category];
    _addressLabel.frame = layout.HomeAddressFrame;
    //时间
    _timeLabel.text =[NSString stringWithFormat:@"%@",_home.time_info];
    _timeLabel.frame = layout.HomeTimeFrame;
    //收藏
    _likeLabel.text = [NSString stringWithFormat:@"%@人收藏",_home.collected_num];
    _likeLabel.frame = layout.HomelikeFrame;
    //价格
    _priceLabel.text = [NSString stringWithFormat:@"¥%.0f",_home.price];
    _priceLabel.frame = layout.HomePriceFrame;

    
}




- (void)awakeFromNib {
    
 
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
