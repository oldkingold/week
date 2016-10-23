//
//  LeftViewController.m
//  week
//
//  Created by mac16 on 16/9/16.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LeftViewController.h"
#import "YingyongViewController.h"
#import "DenglvViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "ViewController.h"
//#import "BaseNavigationController.m"
@interface LeftViewController ()


@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    [self createLeftButtons];
    
}

-(void)createLeftButtons{
    CGFloat buttonHeight = 50;
    CGFloat space = 30;
    for (int i = 0; i<3; i++) {
        CGRect rect = CGRectMake(0, space+i*buttonHeight, kScreenWidth-200, buttonHeight);
        UIButton *button = [[UIButton alloc]initWithFrame:rect];
        [self.view addSubview:button];
        [button setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateNormal];
        button.tag = i;
        NSArray *_data = @[
                           @"首页",
                           @"应用设置",
                           @"登录"
                           ];
        [button setTitle:_data[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:20];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        button.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self action:@selector(buttonsAction:) forControlEvents:UIControlEventTouchUpInside ];
        
    }
    
}
-(void)buttonsAction:(UIButton *)button{
    [button setTitleColor:[UIColor colorWithWhite:1 alpha:1] forState:UIControlStateHighlighted];
    if (button.tag == 1) {
        NSString *sd = @"Yingyong";
        UIStoryboard *story = [UIStoryboard storyboardWithName:sd bundle:[NSBundle mainBundle]];
//        YingyongViewController *yingyongVC = [story instantiateInitialViewController];
        YingyongViewController *yingyongVC = [story instantiateViewControllerWithIdentifier:@"YingyongViewControllerID"];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:yingyongVC];
        [yingyongVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//        [self presentViewController:navi animated:YES completion:^{
////            MMDrawerController *mmd = self.mm_drawerController;
////            [mmd closeDrawerAnimated:YES completion:nil];
//            
//        }];
        UIResponder *responder = self.nextResponder;
        NSInteger i = 0;
        while ( ![responder isKindOfClass:[MMDrawerController class]] ) {
            i++;
            responder = responder.nextResponder;
        }
        
        MMDrawerController *mmd = (MMDrawerController *)responder;
//        mmd.centerViewController = navi;
        [mmd setCenterViewController:navi
         withCloseAnimation:YES
         completion:nil];

    }else if (button.tag == 2){
        NSString *sd = @"Denglv";
        UIStoryboard *story = [UIStoryboard storyboardWithName:sd bundle:[NSBundle mainBundle]];
        DenglvViewController *denglvVC = [story instantiateViewControllerWithIdentifier:@"DenglvViewControllerID"];
        UINavigationController *navi1 = [[UINavigationController alloc]initWithRootViewController:denglvVC];
        [denglvVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//        [self presentViewController:navi1 animated:YES completion:^{
//                    
//        }];
        
        UIResponder *responder = self.nextResponder;
        NSInteger i = 0;
        while ( ![responder isKindOfClass:[MMDrawerController class]] ) {
            i++;
            responder = responder.nextResponder;
        }
        
        MMDrawerController *mmd = (MMDrawerController *)responder;
        //        mmd.centerViewController = navi;
        [mmd setCenterViewController:navi1
                  withCloseAnimation:YES
                          completion:nil];
        
    }else{
        ViewController *viewCT = [[ViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewCT];
        UIResponder *responder = self.nextResponder;
        NSInteger i = 0;
        while ( ![responder isKindOfClass:[MMDrawerController class]] ) {
            i++;
            responder = responder.nextResponder;
        }
        
        MMDrawerController *mmd = (MMDrawerController *)responder;
        //        mmd.centerViewController = navi;
        [mmd setCenterViewController:nav
                  withCloseAnimation:YES
                          completion:nil];
        
        

        
    }
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
