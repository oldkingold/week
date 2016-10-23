//
//  AskCell.m
//  week
//
//  Created by mac16 on 16/9/21.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "AskCell.h"
@interface AskCell(){
    
}
@property (weak, nonatomic) IBOutlet UIImageView *touxiangImage;
@property (weak, nonatomic) IBOutlet UILabel *xinxiLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhutiLabel;
@property (weak, nonatomic) IBOutlet UILabel *huifuLabel;

@property (weak, nonatomic) IBOutlet UILabel *HFLabel;

@end
@implementation AskCell

-(void)setAsk:(AskModel *)ask{
    _ask = ask;
    [_touxiangImage sd_setImageWithURL:[NSURL URLWithString:_ask.user_info[@"avatar_url"]]];
    _zhutiLabel.text = _ask.title;
    _xinxiLabel.text = _ask.user_info[@"user_name"];
    _huifuLabel.text = _ask.answer[@"comment_content"];
  }

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
