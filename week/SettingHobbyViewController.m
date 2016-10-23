//
//  SettingHobbyViewController.m
//  lanrenzhoumo
//
//  Created by Mac on 16/9/15.
//  Copyright © 2016年 jin. All rights reserved.
//

#import "SettingHobbyViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#define menuAPI @"http://api.lanrenzhoumo.com/wh/common/cats"


@interface SettingHobbyViewController ()
//<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionViewFlowLayout *flowLayout;
    NSArray *dataeArray;
    NSArray *imageArray;
    NSMutableArray *boolArray;
}

@end

@implementation SettingHobbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    imageArray = @[@"montain",@"bar",@"music",@"stage",@"pic",@"eat",@"bag",@"movie",@"persons",@"backetball",@"leaf",@"shirt"];
    [self addCesture];
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
    
//    UIWindow *window = ((AppDelegate *)[UIApplication sharedApplication].delegate).window;
    ViewController *viewCT = [[ViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewCT];
//    window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    
//    [window makeKeyAndVisible];
//    window.backgroundColor = [UIColor whiteColor];
    
    LeftViewController *leftVC = [[LeftViewController alloc]init];
    RightViewController *rightVC = [[RightViewController alloc]init];
    
    UINavigationController *leftNav = [[UINavigationController alloc]initWithRootViewController:leftVC];
    UINavigationController *rightNav = [[UINavigationController alloc]initWithRootViewController:rightVC];
    
    leftNav.navigationBar.hidden = YES;
    rightNav.navigationBar.hidden = YES;
    //创建MMDraw
    MMDrawerController *mmd = [[MMDrawerController alloc]initWithCenterViewController:nav leftDrawerViewController:leftNav rightDrawerViewController:rightNav];
    //设置侧滑宽度
    mmd.maximumLeftDrawerWidth = kScreenWidth - 150 ;
    mmd.maximumRightDrawerWidth = kScreenWidth ;
    
    //设置打开方式
    [mmd setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningNavigationBar];
    [mmd setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
//    window.rootViewController = mmd;
    [self presentViewController:mmd animated:YES completion:nil];
}
-(void)addCesture {
    boolArray = [NSMutableArray array];
    for (int i = 1; i <= 12; i++) {
        
        UIView *view = [self.view viewWithTag:100 + i];
        UIImageView *imgview = [view viewWithTag:1001];
        imgview.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_c_%@_gray",imageArray[i - 1]]];
        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedfenglei:)];
        [view addGestureRecognizer:tapges];
        [boolArray addObject:@NO];
    }
//    boolArray = [muarray copy];
//    NSLog(@"%@",boolArray);
//    
}

-(void)selectedfenglei:(UITapGestureRecognizer *)tapges {
    
    NSInteger num = tapges.view.tag - 100;
    
    UIImageView *imgview = [tapges.view viewWithTag:1001];
    UIView *childView = [tapges.view viewWithTag:1003];
    UIImageView *checkView = [childView viewWithTag:1002];
    
    bool b = [boolArray[num - 1] boolValue];
    if (b) {
        imgview.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_c_%@_gray",imageArray[num - 1]]];
        checkView.image = [UIImage imageNamed:@"ic_check_uncheck"];
        [boolArray replaceObjectAtIndex:num - 1 withObject:@NO];
    }else {
        imgview.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_c_%@",imageArray[num - 1]]];
        checkView.image = [UIImage imageNamed:@"ic_check_checked"];
        [boolArray replaceObjectAtIndex:num - 1 withObject:@YES];
    }
    
}

//-(void)createCollectionView {
//    flowLayout = [[UICollectionViewFlowLayout alloc]init];
//    _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KScreenWith, KScreenHeight - 64) collectionViewLayout:flowLayout];
//    _collectView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:_collectView];
//    
//    _collectView.delegate = self;
//    _collectView.dataSource = self;
//    
//}

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
