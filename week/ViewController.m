//
//  ViewController.m
//  week
//
//  Created by mac on 16/8/28.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "ViewController.h"
#import "YYModel.h"
#import "AFNetworking.h"
#import "YingyongViewController.h"
#import "DenglvViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "XiangqingViewController.h"
#import "WXRefresh.h"

@class AFHTTPSessionManager;
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    BOOL _bool;
    UIImageView *_homeImageView1;
    UIImageView *_searchImageView;
    NSMutableArray *_homeArray;
    UIImageView *_topView;
    
    UIButton *setButton;
    
    NSInteger page;

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self createHomeView];
 
    [self loadHomeData];
    [self createTableView];
    [self createBu];
    page = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

//加载数据
-(void)loadHomeData{
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.lanrenzhoumo.com/main/recommend/index/?city_id=383&lat=30.25319&lon=120.2129&page=%li&session_id=000042c92ae3e923ecbd2cefa5daaef49b42fd&v=3",page];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager GET:urlString
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             NSLog(@"请求成功");
             NSArray *array = responseObject[@"result"];
             NSMutableArray *mArray = [[NSMutableArray alloc]init];
             for (NSDictionary *dic in array) {
                 HomeModel *homeModel = [HomeModel yy_modelWithJSON:dic];
                 [mArray addObject:homeModel];
             }
             
             if (_homeArray == nil) {
                 _homeArray = [mArray mutableCopy];
             }else {
                 NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(_homeArray.count, mArray.count)];
                 [_homeArray insertObjects:mArray atIndexes:set];
                 
             }
             
             page ++;
             [_tableView reloadData];
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"请求失败");
         }];
}

-(void)createTableView{
    _searchImageView.hidden = YES;
    _homeImageView1.hidden = YES;
    _bool = YES;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)style:UITableViewStylePlain];
//    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];

    //标题
    self.title = @"懒人周末";

    
    //上拉加载
    __weak ViewController *weakSelf = self;
   [_tableView addInfiniteScrollingWithActionHandler:^{
       __strong ViewController *strongSelf = weakSelf;
       [strongSelf loadMoreData];
   }];
  
    [_tableView registerClass:[HomeCell class] forCellReuseIdentifier:@"HomeCell"];
    
}
-(void)createBu{
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 30, 30)];
    [leftButton setImage:[UIImage imageNamed:@"cat_me.png"] forState:UIControlStateNormal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = left;
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-20-30,20 ,30, 30)];
    [rightButton setImage:[UIImage imageNamed:@"ic_nav_search@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;

}


-(void)loadMoreData
{
    
    [self loadHomeData];
     [_tableView.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
}



//代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _homeArray.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
    HomeModel *hm = _homeArray[indexPath.row];
    [cell setHome:hm];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeModel *hm = _homeArray[indexPath.row];
    
    HomeCellLayout *lay = [HomeCellLayout layoutWithHomeModel:hm];
    lay.home = hm;
    
    return [lay _cellHeiht];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    XiangqingViewController *xiangqingVC = [[XiangqingViewController alloc]init];
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:xiangqingVC];
    [na setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    HomeModel *hm = _homeArray[indexPath.row];
    NSInteger leoId = hm.leo_id;
    xiangqingVC.leoID = [NSString stringWithFormat:@"%li",leoId];
    
   
    [self presentViewController:na animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
