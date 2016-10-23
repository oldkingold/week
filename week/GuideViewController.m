//
//  GuideViewController.m
//  微信微博登入
//
//  Created by Mac on 16/9/3.
//  Copyright © 2016年 jin. All rights reserved.
//

#import "GuideViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "SettingPersonViewController.h"


//#define coverURL
#define coverPath @"Documents/covers"
#define anitime 1.5
#define changenum 0.5

@interface GuideViewController ()
{
    NSArray *array;
    UIView *view1;
    UIView *view2;
    NSTimer *timer;
    NSInteger num;
    CGPoint beginpoint;
    CGPoint lastmovepoint;
    BOOL isanyView;
    NSInteger i;
}
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor redColor];
    [self _createUI];
    [self _praseData];

    num = 0;
    i = 0;
    
    NSLog(@"%@",NSHomeDirectory());
}

-(void)_createUI {
    
    view1 = [[UIView alloc]initWithFrame:self.view.bounds];
    view1.backgroundColor = [UIColor orangeColor];
    UIImageView *bgImageView1 = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgImageView1.tag = 101;
    [view1 addSubview:bgImageView1];
    UILabel *bgtextLabel1 = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 150) / 2.0, (kScreenHeight - 60) / 2.0, 150, 60)];
    bgtextLabel1.numberOfLines = 0;
    bgtextLabel1.tag = 102;
    [view1 addSubview:bgtextLabel1];
    [self.view addSubview:view1];
    view1.alpha = 0.0;
    
    view2 = [[UIView alloc]initWithFrame:self.view.bounds];
    view2.backgroundColor = [UIColor orangeColor];
    UIImageView *bgImageView2 = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgImageView2.tag = 101;
    [view2 addSubview:bgImageView2];
    UILabel *bgtextLabel2 = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 150) / 2.0, (kScreenHeight - 60) / 2.0, 150, 60)];
    bgtextLabel2.numberOfLines = 0;
    bgtextLabel2.tag = 102;
    [view2 addSubview:bgtextLabel2];
    [self.view addSubview:view2];
    
    UIButton *bottombtn = [[UIButton alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
    bottombtn.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.2];
    [bottombtn setTitle:@"暂不登录，随便逛逛" forState:UIControlStateNormal];
    [bottombtn addTarget:self action:@selector(suibianguangguang) forControlEvents:UIControlEventTouchUpInside];
    bottombtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [self.view addSubview:bottombtn];
    
    UIButton *leftbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50 - 45, kScreenWidth / 2, 45)];
    leftbtn.backgroundColor = [UIColor colorWithRed:.0 green:.0 blue:.0 alpha:0.8];
    [leftbtn setTitle:@"微博登录" forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(weibologin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftbtn];
    
    UIButton *rightbtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - kScreenWidth / 2, kScreenHeight - 50 - 45, kScreenWidth / 2, 45)];
    rightbtn.backgroundColor = [UIColor colorWithRed:.0 green:.0 blue:.0 alpha:0.8];
    [rightbtn setTitle:@"微信登录" forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(weixinlogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightbtn];
    
//    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
//    view.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:view];
//    [UIView animateWithDuration:3.5 animations:^{
//        view.alpha = 0.0;
        timer = [NSTimer scheduledTimerWithTimeInterval:6.0 target:self selector:@selector(leftanimationforImageandText) userInfo:nil repeats:YES];
//    }];
    
}

-(void)_praseData {
    
    NSString *pathstr = [NSHomeDirectory() stringByAppendingPathComponent:coverPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:pathstr]) {
        NSLog(@"文件不存在");
        [fileManager createDirectoryAtPath:pathstr withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *arraypath = [pathstr stringByAppendingPathComponent:@"dataArray"];
    
    if (![fileManager fileExistsAtPath:arraypath]) {
        NSString *strUrl = [NSString stringWithFormat:@"%@%@", KAPI,@"/cover/common/get_covers"];
        
        AFHTTPSessionManager *httpsesmanger = [AFHTTPSessionManager manager];
        
        [httpsesmanger GET:strUrl parameters:nil
                   success:^(NSURLSessionDataTask *task, id responseObject) {
                       NSLog(@"成功");
                       //NSLog(@"%@", responseObject);
                       array = responseObject[@"result"];
                       NSLog(@"%@",array[0]);
                       for (NSDictionary *coverdic in array) {
                           NSURL *url = [NSURL URLWithString:coverdic[@"url"]];
                           NSData *data = [NSData dataWithContentsOfURL:url];
                           [data writeToFile:[pathstr stringByAppendingPathComponent:[NSString stringWithFormat:@"%i.jpg",[coverdic[@"name"] intValue]]] atomically:YES];
                       }
                       [self changeImageandText:view2];
                       [array writeToFile:arraypath atomically:YES];
                   }
                   failure:^(NSURLSessionDataTask *task, NSError *error) {
                       NSLog(@"失败");
                   }];
    }else {
        array = [NSArray arrayWithContentsOfFile:arraypath];
        [self changeImageandText:view2];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------ 左右滑动 -----
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    beginpoint = [touch locationInView:self.view];
//    NSLog(@"%f,%f",beginpoint.x,beginpoint.y);
    if (view1.alpha == 0.0) {
        view1.transform = CGAffineTransformIdentity;
        isanyView = YES;
    }else {
        
        view2.transform = CGAffineTransformIdentity;
        isanyView = NO;
    }
    [timer invalidate];
    timer = nil;
    NSLog(@"触摸开始");
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    lastmovepoint = [touch locationInView:self.view];
    CGFloat distance = beginpoint.x - lastmovepoint.x;
    CGFloat trans = distance / kScreenWidth * 0.5;
    CGFloat alphachange = distance / kScreenWidth;
    if (alphachange < 0) {
        alphachange = - alphachange;
    }
    if (isanyView) {
        if (distance > 0) {
            if (i >= 0) {
                if (num < 3) {num++;} else {num = 0;}
                i = -1;
                [self changeImageandText: view1];
            }
            view2.transform = CGAffineTransformMakeScale(1 + trans, 1 + trans);
        }else if(distance < 0) {
            if (i <= 0) {
                if (num > 0) {num--;} else {num = 3;}
                i = 1;
                [self changeImageandText: view1];
            }
            view1.transform = CGAffineTransformMakeScale(1.5 + trans, 1.5 + trans);
        }
        view2.alpha = 1.0 - alphachange;
        view1.alpha = 0.0 + alphachange;
    }else {
        if (distance > 0) {
            if (i >= 0) {
                if (num < 3) {num++;} else {num = 0;}
                i = -1;
                [self changeImageandText: view2];
            }
            view1.transform = CGAffineTransformMakeScale(1 + trans, 1 + trans);
        }else if(distance < 0) {
            if (i <= 0) {
                if (num > 0) {num--;} else {num = 3;}
                i = 1;
                [self changeImageandText: view2];
            }
            view2.transform = CGAffineTransformMakeScale(1.5 + trans, 1.5 + trans);
        }
        view1.alpha = 1.0 - alphachange;
        view2.alpha = 0.0 + alphachange;
    }
//    NSLog(@"接触点移动");
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"触摸取消");
    i = 0;
    UITouch *touch = [touches anyObject];
    CGPoint endpoint = [touch locationInView:self.view];
    CGFloat distance = beginpoint.x - endpoint.x;
    NSLog(@"%f",distance);
    CGFloat alphachange = distance / kScreenWidth;
    CGAffineTransform scaletranfrom = CGAffineTransformMakeScale(1.5, 1.5);
    
    if (isanyView) {
        if (alphachange > changenum) {
            [UIView animateWithDuration:anitime * alphachange animations:^{
                view2.alpha = 0.0;
                view1.alpha = 1.0;
                view2.transform = scaletranfrom;
            }];
        } else if(alphachange < -changenum){
            alphachange = - alphachange;
            [UIView animateWithDuration:anitime * alphachange animations:^{
                view2.alpha = 0.0;
                view1.alpha = 1.0;
                view1.transform = CGAffineTransformIdentity;
            }];
        }else if (alphachange <= changenum && alphachange > 0){
            [UIView animateWithDuration:anitime * (1 - alphachange ) animations:^{
                if (num > 0) {num--;} else {num = 3;}
                view2.alpha = 1.0;
                view1.alpha = 0.0;
                view2.transform = CGAffineTransformIdentity;
            }];
        }else if (alphachange >= -changenum && alphachange < 0){
            if (num < 3) {num++;} else {num = 0;}
            alphachange = - alphachange;
            [UIView animateWithDuration:anitime * ( 1 - alphachange ) animations:^{
                view2.alpha = 1.0;
                view1.alpha = 0.0;
                view1.transform = scaletranfrom;
            }];
        }
    }else {
        if (alphachange > changenum) {
            [UIView animateWithDuration:anitime * alphachange animations:^{
                view1.alpha = 0.0;
                view2.alpha = 1.0;
                view1.transform = scaletranfrom;
            }];
        } else if(alphachange < -changenum){
            alphachange = - alphachange;
            [UIView animateWithDuration:anitime * alphachange animations:^{
                view1.alpha = 0.0;
                view2.alpha = 1.0;
                view2.transform = CGAffineTransformIdentity;
            }];
        }else if (alphachange <= changenum && alphachange > 0){
            [UIView animateWithDuration:anitime * ( 1 - alphachange ) animations:^{
                if (num > 0) {num--;} else {num = 3;}
                view1.alpha = 1.0;
                view2.alpha = 0.0;
                view1.transform = CGAffineTransformIdentity;
            }];
        }else if (alphachange >= -changenum && alphachange < 0){
            if (num < 3) {num++;} else {num = 0;}
            alphachange = - alphachange;
            [UIView animateWithDuration:anitime * ( 1 - alphachange ) animations:^{
                view1.alpha = 1.0;
                view2.alpha = 0.0;
                view2.transform = scaletranfrom;
            }];
        }
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:6.0 target:self selector:@selector(leftanimationforImageandText) userInfo:nil repeats:YES];
}

-(void)leftanimationforImageandText {
    
    if (num < 3) {num++;} else {num = 0;}
    CGAffineTransform scaletranfrom = CGAffineTransformMakeScale(1.5, 1.5);
    if (view1.alpha == 0.0) {
        [self changeImageandText: view1];
        view1.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:anitime animations:^{
            view2.alpha = 0.0;
            view1.alpha = 1.0;
            view2.transform = scaletranfrom;
        }];
        
    }else {
        [self changeImageandText: view2];
        view2.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:anitime animations:^{
            view1.alpha = 0.0;
            view2.alpha = 1.0;
            view1.transform = scaletranfrom;
        }];
    }
}

//-(void)rightanimationforImageandText {
//    
//    if (num > 0) {num--;} else {num = 3;}
//    CGAffineTransform scaletranfrom = CGAffineTransformMakeScale(1.5, 1.5);
//    if (view1.alpha == 0.0) {
//        [self changeImageandText: view1];
//        view1.transform = scaletranfrom;
//        [UIView animateWithDuration:3.0 animations:^{
//            view2.alpha = 0.0;
//            view1.alpha = 1.0;
//            view1.transform = CGAffineTransformIdentity;
//        }];
//        
//    }else {
//        [self changeImageandText: view2];
//        view2.transform = scaletranfrom;
//        [UIView animateWithDuration:3.0 animations:^{
//            view1.alpha = 0.0;
//            view2.alpha = 1.0;
//            view2.transform = CGAffineTransformIdentity;
//        }];
//    }
//    
//}

-(void)changeImageandText:(UIView *) view{
    
    NSString *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@//%li.jpg", coverPath, (long)num + 1]];
//    NSLog(@"%@",imagePath);
    
    UIImageView *bgImageView = (UIImageView *)[view viewWithTag:101];
    bgImageView.image = [UIImage imageWithContentsOfFile:imagePath];
    
    NSDictionary *dic = array[num];
    NSString *str = dic[@"description"];
    UILabel *bgtextLabel = (UILabel *)[view viewWithTag:102];
    [bgtextLabel setAttributedText:[self changefontWithText:str]];

}

#pragma  mark---------修改文字数据---------
-(NSMutableAttributedString *)changefontWithText:(NSString *) string {
    
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowOffset = CGSizeMake(1, 1);
    shadow.shadowColor = [UIColor whiteColor];
    shadow.shadowBlurRadius = 5.0;
    
    NSString *header = [string substringToIndex:2];
    NSString *tail = [string substringWithRange:NSMakeRange(3, string.length - 4)];
    NSMutableAttributedString *attrstr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",header, tail]];
    
    [attrstr addAttributes:@{NSShadowAttributeName:shadow,NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, attrstr.length)];
    [attrstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0, 2)];
    [attrstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(3, attrstr.length - 3)];
    
    return attrstr;
}
#pragma mark --------微博登录--------
-(void)weibologin {
//    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
//    request.redirectURI = KRedirectURL;
//    request.scope = @"all";
//    request.userInfo = @{@"SSO_From": @"ViewController",
//                         @"Other_Info_1": [NSNumber numberWithInt:123],
//                         @"Other_Info_2": @[@"obj1", @"obj2"],
//                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
//    [WeiboSDK sendRequest:request];
}
#pragma mark --------微信登录--------
-(void)weixinlogin {
//    UIApplication *app = [UIApplication sharedApplication];
//    BOOL b = [app canOpenURL:[NSURL URLWithString:@"weibo_ing://"]];
//    if (b) {
//        [app openURL:[NSURL URLWithString:@"weibo_ing://"]];
//    }
//    NSLog(@"dianji");
//    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
//    MineTableViewController *mine = [story instantiateInitialViewController];
//    [self presentViewController:mine animated:YES completion:nil];
    
}
#pragma mark --------随便逛逛---------
-(void)suibianguangguang {
    
//    SettingController *setting = [[SettingController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:setting];
//    [self presentViewController:nav animated:YES completion:nil];
    UIStoryboard *settpsb = [UIStoryboard storyboardWithName:@"Setting" bundle:[NSBundle mainBundle]];
    UINavigationController *nav = [settpsb instantiateInitialViewController];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}
@end
