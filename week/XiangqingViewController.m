//
//  XiangqingViewController.m
//  week
//
//  Created by mac16 on 16/9/18.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "XiangqingViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "UserModel.h"
#import "YYModel.h"
#import "XiangqingCell.h"
#import "XiangqingCellLayout.h"
#import "AskViewController.h"
#import "UINavigationBar+Background.h"
#import "UIImage+ZidingyiSize.h"

@class AFHTTPSessionManager;
@interface XiangqingViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView *scrollImgView;
    UIPageControl *pageCtrl;
    UIScrollView *headscrollview;
    
    
    NSArray *images;
    NSMutableArray *_imageArray;
    NSMutableArray *_uArray;
    NSMutableArray *_userArray;
    UserModel *Model;
   
    
    UIButton *left;
    UIButton *likeButton;
    UIButton *tellButton;
    UIButton *askButton;
    
    UIView *tellView;
    UIView *grayView;
    
    CGFloat ofy;
    CGFloat scrollImageWidth;
    
}
   

@property (strong, nonatomic)  UITableView *table;
    


@end

@implementation XiangqingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTable];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = YES;
    _table.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    scrollImgView.showsVerticalScrollIndicator = NO;
    [self loadData];
    
   }
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
      [self creatButton];
}

-(void)createTable
{
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_table];


    _table.delegate = self;
    _table.dataSource = self;
    [_table registerClass:[XiangqingCell class] forCellReuseIdentifier:@"cellID"];
}

-(void)loadData{
    NSString *urlString =[NSString stringWithFormat: @"http://api.lanrenzhoumo.com/wh/common/leo_detail?leo_id=%@&session_id=000042c92ae3e923ecbd2cefa5daaef49b42fd&v=4",_leoID];
   
   
    AFHTTPSessionManager *man = [AFHTTPSessionManager manager];
    man.requestSerializer = [AFHTTPRequestSerializer serializer];
    [man GET:urlString
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
          NSLog(@"请求成功1");
             NSDictionary *dics = responseObject[@"result"];
             UserModel *userModel = [UserModel yy_modelWithJSON:dics];
             Model = userModel;
             
            [self createHeader];
             [_table reloadData];
           
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"请求失败2");
         }];
}

-(void)createtanchu {
    
}

-(void)createHeader
{
    
    scrollImgView = [[UIScrollView alloc]initWithFrame:CGRectMake(-10, 0, kScreenWidth + 20, 360)];
    [self.view insertSubview:scrollImgView belowSubview:_table];
    scrollImgView.contentMode = UIViewContentModeScaleAspectFill;
    scrollImgView.pagingEnabled = YES;
    scrollImgView.bounces = NO;
    scrollImgView.decelerationRate = 0.1;
    scrollImgView.showsHorizontalScrollIndicator = NO;
    scrollImgView.delegate = self;
    NSInteger num = Model.images.count + 2;
    for (int i = 0; i<num; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i * (kScreenWidth + 20), 0, kScreenWidth + 20, 360)];
        if (i == 0) {
            [imgView sd_setImageWithURL:[NSURL URLWithString:Model.images[num - 3]]];
        }else if (i == num - 1) {
            [imgView sd_setImageWithURL:[NSURL URLWithString:Model.images[0]]];
        }else {
            [imgView sd_setImageWithURL:[NSURL URLWithString:Model.images[i - 1]]];
        }
        
        [scrollImgView addSubview:imgView];
    }
    scrollImageWidth = kScreenWidth + 20;
    scrollImgView.contentOffset = CGPointMake(scrollImageWidth, 0);
    scrollImgView.contentSize = CGSizeMake(num * scrollImageWidth, 360);
    CGAffineTransform trans = CGAffineTransformMakeScale(1 - 20 / 360, 1 - 20 / 360);
    trans = CGAffineTransformTranslate(trans, 0, - 20 / 3);
    scrollImgView.transform = trans;
    
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 320)];
    headview.backgroundColor = [UIColor clearColor];
    _table.tableHeaderView = headview;
    _table.tableHeaderView.backgroundColor = [UIColor clearColor];
    
    pageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake((kScreenWidth-250)/2, 320-30, 250, 20)];
    pageCtrl.numberOfPages = num - 2;
    [pageCtrl addTarget:self action:@selector(pageAction) forControlEvents:UIControlEventValueChanged];
    
    headscrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(-10, 0, kScreenWidth + 20, 320)];
    headscrollview.contentSize = CGSizeMake(scrollImgView.contentSize.width, 320);
    headscrollview.bounces = NO;
    headscrollview.decelerationRate = 0.1;
    headscrollview.showsHorizontalScrollIndicator = NO;
    headscrollview.delegate = self;
    headscrollview.pagingEnabled = YES;
    headscrollview.contentOffset = CGPointMake(scrollImageWidth, 0);
    
    [headview addSubview:headscrollview];
    [headview addSubview:pageCtrl];
}

-(void)pageAction{
    float x = pageCtrl.currentPage * scrollImageWidth;
    headscrollview.contentOffset = CGPointMake(x, 0);
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
     NSLog(@"scrollViewDidEndDragging");
    int y = ((int)headscrollview.contentOffset.x) / scrollImageWidth;
    
    scrollImgView.contentOffset = headscrollview.contentOffset;
    if (y == 0) {
        pageCtrl.currentPage = Model.images.count;
        scrollImgView.contentOffset = CGPointMake(scrollImageWidth * Model.images.count, 0);
        headscrollview.contentOffset = CGPointMake(scrollImageWidth * Model.images.count, 0);
        
    }else if ( y == Model.images.count + 1) {
        pageCtrl.currentPage = 0;
        scrollImgView.contentOffset = CGPointMake(scrollImageWidth, 0);
        headscrollview.contentOffset = CGPointMake(scrollImageWidth, 0);
        
    }else {
        pageCtrl.currentPage = y - 1;
    }
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    scrollImgView.contentOffset = headscrollview.contentOffset;
    
    if (_table.contentOffset.y < 0) {
        CGAffineTransform trans = CGAffineTransformMakeScale(1 - (_table.contentOffset.y - 20) / 360, 1 - (_table.contentOffset.y - 20) / 360);
        trans = CGAffineTransformTranslate(trans, 0, - _table.contentOffset.y / 3);
        scrollImgView.transform = trans;
    }else if (_table.contentOffset.y < 20) {
        CGAffineTransform trans = CGAffineTransformMakeScale(1 - (_table.contentOffset.y - 20) / 360, 1 - (_table.contentOffset.y - 20) / 360);
        scrollImgView.transform = trans;
    }else if (_table.contentOffset.y > 20) {
        scrollImgView.transform = CGAffineTransformIdentity;
        scrollImgView.frame = CGRectMake(0, -(_table.contentOffset.y - 20), kScreenWidth, 360);
    }
    
    
    UIColor *color = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    
    ofy = _table.contentOffset.y;
    //    NSLog(@"ofy:%g",ofy);
    
    if (ofy <= 60.0 && ofy>=0) {
        
        CGFloat alpha = MIN(1, ofy/60.0);
        [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:alpha]];
        
        if (alpha >= 0.5) {
            
            [likeButton setImage:[UIImage imageNamed:@"ic_heart@2x.png"] forState:UIControlStateNormal];
            [likeButton setImage:[UIImage imageNamed:@"ic_nav_black_heart_on@2x.png"] forState:UIControlStateSelected];
            [left setImage:[UIImage imageNamed:@"ic_nav_left@2x.png"] forState:UIControlStateNormal];
            [tellButton setImage:[UIImage imageNamed:@"ic_nav_share_black@2x.png"] forState:UIControlStateNormal];
            [askButton setImage:[UIImage imageNamed:@"ic_nav_help@2x.png"] forState:UIControlStateNormal];
            
        }
        else  {
            
            [likeButton setImage:[UIImage imageNamed:@"ic_nav_heart_white_off@2x.png"] forState:UIControlStateNormal];
            [likeButton setImage:[UIImage imageNamed:@"ic_nav_white_heart_on@2x.png"] forState:UIControlStateSelected];
            
            [left setImage:[UIImage imageNamed:@"ic_nav_left_white@2x.png"] forState:UIControlStateNormal];
            [tellButton setImage:[UIImage imageNamed:@"ic_nav_share_white@2x.png"] forState:UIControlStateNormal];
            [askButton setImage:[UIImage imageNamed:@"ic_nav_help_white@2x.png"] forState:UIControlStateNormal];
        }
        
    }else if(ofy>60.0){
        [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:1]];
    }else{

    }
    
    
    
}


-(void)creatButton{
    NSArray *buArray = [[NSArray alloc]init];
    left = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [left setImage:[UIImage imageNamed:@"ic_nav_left_white@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:left];
    self.navigationItem.leftBarButtonItem = leftItem;
    [left addTarget:self action:@selector(BAction) forControlEvents:UIControlEventTouchUpInside];
    
    tellButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 30, 30)];
    [tellButton setImage:[UIImage imageNamed:@"ic_nav_share_white@2x.png"] forState:UIControlStateNormal];
    [tellButton addTarget:self action:@selector(tellAction) forControlEvents:UIControlEventTouchUpInside];
    
    likeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 30, 30)];
    [likeButton setImage:[UIImage imageNamed:@"ic_nav_heart_white_off@2x.png"] forState:UIControlStateNormal];
    [likeButton setImage:[UIImage imageNamed:@"ic_nav_white_heart_on@2x.png"] forState:UIControlStateSelected];
    [self.navigationController.navigationBar addSubview:likeButton];
    [likeButton addTarget:self action:@selector(likeAction) forControlEvents:UIControlEventTouchUpInside];
    
  
    askButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 30, 30)];
    [askButton setImage:[UIImage imageNamed:@"ic_nav_help_white@2x.png"] forState:UIControlStateNormal];
    [askButton addTarget:self action:@selector(askAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *tell = [[UIBarButtonItem alloc]initWithCustomView:tellButton];
    UIBarButtonItem *like = [[UIBarButtonItem alloc]initWithCustomView:likeButton];
    UIBarButtonItem *ask = [[UIBarButtonItem alloc]initWithCustomView:askButton];
    buArray = @[ask,like,tell];
    
    self.navigationItem.rightBarButtonItems = buArray;
    
}

-(void)BAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)likeAction{
    if (likeButton.selected == YES) {
        likeButton.selected = NO;
        [UIView animateWithDuration:0.15 animations:^{
        likeButton.imageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
        }];
        [UIView animateWithDuration:0.15 animations:^{
            likeButton.imageView.transform = CGAffineTransformIdentity;
        }];
        [UIView animateWithDuration:0.15 animations:^{
            likeButton.imageView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        }];
        [UIView animateWithDuration:0.15 animations:^{
            likeButton.imageView.transform = CGAffineTransformIdentity;
        }];
        //            [NSThread sleepForTimeInterval:0.2];
        
        
       
    }else{
        likeButton.selected = YES;

}
}
-(void)tellAction{
    [self createTellView];
    
}

-(void)createTellView{
    
    tellView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-120, kScreenWidth, 120)];
    tellView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tellView];
    NSArray *name = @[@"朋友圈",@"微信好友",@"QQ好友",@"QQ空间"];
    NSArray *Images = @[@"logo_Wefriend@2x.png",@"logo_Wechat@2x.png",@"logo_QQ@2x.png",@"logo_Qzone@2x.png"];
    for (int i = 0; i<4; i++) {
        UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(i*(kScreenWidth/4), 5, kScreenWidth/4, 100)];
        [tellView addSubview:but];
        [but setImage:[UIImage imageNamed:Images[i]] forState:UIControlStateNormal];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(i*(kScreenWidth/4), 85, kScreenWidth/4, 20)];
        lab.text = name[i];
//        lab.backgroundColor = [UIColor redColor];
        [tellView addSubview:lab];
        lab.textColor = [UIColor blackColor];
        lab.textAlignment = NSTextAlignmentCenter;
        
    }
    
    grayView = [[UIView alloc]initWithFrame:CGRectMake(-10, 0, kScreenWidth + 10, kScreenHeight-120)];
    grayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.navigationController.view addSubview:grayView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidAction)];
    [grayView addGestureRecognizer:tap];
}

-(void)hidAction{
    
    tellView.hidden = YES;
    grayView.hidden = YES;
}


-(void)askAction{
    _table.contentOffset = CGPointMake(0, 0);
    scrollImgView.frame = CGRectMake(-10, 0, kScreenWidth + 20, 360);
    AskViewController *askCtrl = [[AskViewController alloc]init];
    askCtrl.leoID1 = _leoID;
    [self.navigationController pushViewController:askCtrl animated:YES];
}

//TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    XiangqingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    XiangqingCell *cell = [[XiangqingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    [cell setUser:Model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XiangqingCellLayout *lay = [XiangqingCellLayout layoutWithUserModel:Model];
    lay.user = Model;
    return [lay _cellHeight];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
