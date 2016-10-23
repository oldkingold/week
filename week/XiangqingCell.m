//
//  XiangqingCell.m
//  week
//
//  Created by mac16 on 16/9/18.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "XiangqingCell.h"
#import "XiangqingCellLayout.h"

@interface  XiangqingCell(){

    BOOL isOrNotLike;
}

@property (strong, nonatomic)UILabel *titleLabel;
@property (strong, nonatomic)UILabel *secLabel;
@property (strong, nonatomic)UIImageView *iconImage;
@property (strong, nonatomic)UILabel *typeLabel;
@property (strong, nonatomic)UILabel *priceLabel;
@property (strong, nonatomic)UILabel *timeInfoLabel;
@property (strong, nonatomic)UIButton *addressButton;
@property (strong, nonatomic)UILabel *huodongLabel;
@property (strong, nonatomic)UIView *xqView;
@property (strong, nonatomic)UIButton *tellButton;
@property (strong, nonatomic)UIButton *likeButton;
@property (strong, nonatomic)UIButton *askButton;

@property (strong, nonatomic)UILabel *kongLabel;

@end
@implementation XiangqingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
    
}


-(void)createCell{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
//    _titleLabel.backgroundColor = [UIColor redColor];
    _titleLabel.font = [UIFont systemFontOfSize:21];
    _titleLabel.numberOfLines = 0;
    [self addSubview:_titleLabel];
    
    _secLabel = [[UILabel alloc]initWithFrame:CGRectZero];
//    _secLabel.backgroundColor = [UIColor redColor];
    [self addSubview:_secLabel];
    _secLabel.layer.borderWidth = 1;
    _secLabel.layer.borderColor = [UIColor grayColor].CGColor;
    
    _iconImage = [[UIImageView alloc]initWithFrame:CGRectZero];
//    _iconImage.backgroundColor = [UIColor greenColor];
    [_secLabel addSubview:_iconImage];
    
    _typeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [_secLabel addSubview:_typeLabel];
    
    _priceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [_secLabel addSubview:_priceLabel];
    
    _timeInfoLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_timeInfoLabel];
    
    _addressButton = [[UIButton alloc]initWithFrame:CGRectZero];
    [self addSubview:_addressButton];
    _addressButton.titleLabel.numberOfLines = 0;
    [_addressButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _addressButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_addressButton addTarget:self action:@selector(locAction) forControlEvents:UIControlEventTouchUpInside];
    
    _kongLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_kongLabel];
    _kongLabel.layer.borderWidth = 1;
    _kongLabel.layer.borderColor = [UIColor grayColor].CGColor;
    
    _huodongLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_huodongLabel];
    
    _xqView = [[UIView alloc]init];
    [self addSubview:_xqView];
    
}

-(void)likeAction{
    if (isOrNotLike == YES) {
        [_likeButton setImage:[UIImage imageNamed:@"ic_nav_black_heart_on@2x.png"] forState:UIControlStateNormal];
        
            [UIView animateWithDuration:0.15 animations:^{
                _likeButton.imageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
            }];
            [UIView animateWithDuration:0.15 animations:^{
                _likeButton.imageView.transform = CGAffineTransformIdentity;
            }];
        [UIView animateWithDuration:0.15 animations:^{
            _likeButton.imageView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        }];
        [UIView animateWithDuration:0.15 animations:^{
            _likeButton.imageView.transform = CGAffineTransformIdentity;
        }];
//            [NSThread sleepForTimeInterval:0.2];
        
        
        isOrNotLike = NO;
    }else{
        [_likeButton setImage:[UIImage imageNamed:@"ic_heart@2x.png"] forState:UIControlStateNormal];
        isOrNotLike = YES;
    }
    
    
}
//定位
-(void)locAction{
    
}

-(void)setUser:(UserModel *)user{
    _user = user;
    _titleLabel.text = _user.title;
    XiangqingCellLayout *lay = [[XiangqingCellLayout alloc]init];
    lay.user = user;
    _titleLabel.frame = lay.titleLabelFrame;
    _secLabel.frame = lay.secLabelFrame;
    NSURL *url = [NSURL URLWithString:_user.category[@"icon_view"]];
    [_iconImage sd_setImageWithURL:url];
    _iconImage.frame = lay.iconImageFrame;
    _typeLabel.text = _user.category[@"cn_name"];
    _typeLabel.frame = lay.typeLabelFrame;

    _priceLabel.text = [NSString stringWithFormat:@"¥%@",_user.price_info];
    _priceLabel.frame = lay.priceLabelFrame;
    
    _timeInfoLabel.text = _user.time[@"info"];
    _timeInfoLabel.frame = lay.timeInfoFrame;
    
    [_addressButton setTitle:[NSString stringWithFormat:@"%@ · %@",_user.address,_user.poi] forState:UIControlStateNormal];
    _addressButton.frame = lay.addressButtonFrame;
    

    _huodongLabel.text = @"活动详情";
    _huodongLabel.frame = lay.huodongLabelFrame;
    
    _kongLabel.frame = lay.kongFrame;
    
    NSInteger nu;
    if (_user.des == nil) {
        nu = 0;
    }else{
        nu = _user.des.count;
    }
   
    for (int i= 0; i<nu; i++) {
        if ([_user.des[i][@"type"]isEqualToString:@"text"]) {
            UILabel *_TextLabel = [[UILabel alloc]initWithFrame:CGRectZero];
            [_xqView addSubview:_TextLabel];
            _TextLabel.numberOfLines = 0;
            _TextLabel.font = [UIFont systemFontOfSize:15];
//            _TextLabel.backgroundColor = [UIColor greenColor];
//            UILabel *_TextLabel = (UILabel *)[_xqView viewWithTag:i+100];
            _TextLabel.text = _user.des[i][@"content"];
            _TextLabel.frame = [lay.array[i] CGRectValue] ;
//            NSLog(@"%@",NSStringFromCGRect(_TextLabel.frame));
            
        }else{
            
            UIImageView *_ImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
//            (UIImageView *)[_xqView viewWithTag:i+100];
            [_xqView addSubview:_ImageView];
            [_ImageView sd_setImageWithURL:[NSURL URLWithString:_user.des[i][@"content"]]];
            _ImageView.frame = [lay.array[i] CGRectValue];
        }
    
    }
    _xqView.frame = lay.xqViewFrame;
    
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
