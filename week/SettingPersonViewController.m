//
//  SettingPersonViewController.m
//  lanrenzhoumo
//
//  Created by Mac on 16/9/15.
//  Copyright © 2016年 jin. All rights reserved.
//

#import "SettingPersonViewController.h"

@interface SettingPersonViewController ()

@end

@implementation SettingPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置个人资料";
    [self createNavBarBtn];
}

-(void)createNavBarBtn {
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"ic_nav_left"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"ic_nav_left_white"] forState:UIControlStateSelected];
    [leftBtn addTarget:self action:@selector(leftBarAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"ic_nav_right"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBarAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBar;
}

-(void)leftBarAction :(UIButton *) btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)rightBarAction :(UIButton *) btn{
    [self performSegueWithIdentifier:@"GotoHobby" sender:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
