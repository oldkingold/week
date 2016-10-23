//
//  AskViewController.m
//  week
//
//  Created by mac16 on 16/9/21.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "AskViewController.h"
#import "AskCell.h"
#import "AFNetworking.h"
#import "AskModel.h"
#import "YYModel.h"
@interface AskViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITextView *_textView;
    UILabel *hidlabel;
    NSArray *_askArray;
    UITableView *table;
}

@end

@implementation AskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"在线咨询";
    [self createBackButton];
    [self createTable];
    [self loadData];
    self.navigationController.navigationBar.translucent = NO;
    
//    [self.navigationController.navigationBar cnSetBackgroundColor:[[UIColor colorWithRed:1 green:1 blue:1 alpha:1] colorWithAlphaComponent:1]];
}

-(void)createBackButton{
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [back setImage:[UIImage imageNamed:@"ic_nav_left@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem *it = [[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = it;
    [back addTarget:self action:@selector(BackAction) forControlEvents:UIControlEventTouchUpInside];
}
-(void)BackAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


-(void)createTable{
   table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    [self.view addSubview:table];
    table.delegate = self;
    table.dataSource = self;
    
    UIView *top = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 125)];
//    top.backgroundColor = [UIColor redColor];
    table.tableHeaderView = top;
    UINib *nib = [UINib nibWithNibName:@"AskCell" bundle:[NSBundle mainBundle]];
    [table registerNib:nib forCellReuseIdentifier:@"AskCell"];

    
    
    _textView= [[UITextView alloc]initWithFrame:CGRectMake(40, 5, kScreenWidth-50, 100)];
    _textView.delegate = self;
    _textView.layer.borderColor = [UIColor grayColor].CGColor;
    _textView.layer.borderWidth = 0.5;
    
    [top addSubview:_textView];
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    icon.image = [UIImage imageNamed:@"cat_me@2x.png"];
    [top addSubview:icon];
    
    UIButton *ask = [[UIButton alloc]initWithFrame:CGRectMake(40, 5+102+2, 50, 20)];
    [ask setTitle:@"提交问题" forState:UIControlStateNormal];
    ask.titleLabel.font = [UIFont systemFontOfSize:12];
    ask.backgroundColor = [UIColor blackColor];
    ask.layer.cornerRadius = 5;
    [top addSubview:ask];
    
    
    hidlabel = [[UILabel alloc]initWithFrame:CGRectMake(3, 3, 200, 20)];
    hidlabel.hidden = NO;
    hidlabel.text = @"在这里提问您的问题";
    hidlabel.font = [UIFont systemFontOfSize:15];
    hidlabel.textColor = [UIColor lightGrayColor];
    [_textView addSubview:hidlabel];
    
}

-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        hidlabel.hidden = NO;
    }else{
        hidlabel.hidden = YES;
    }
}


//代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _askArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AskCell"];
    AskModel *am = _askArray[indexPath.row];
    [cell setAsk:am];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 96;
}

-(void)loadData{
    

    NSString *urlString =[NSString stringWithFormat:@"http://api.lanrenzhoumo.com/faq/topic/list/?leo_id=%@&page=1&session_id=000042c92ae3e923ecbd2cefa5daaef49b42fd",_leoID1];
    
        
        AFHTTPSessionManager *man = [AFHTTPSessionManager manager];
        man.requestSerializer = [AFHTTPRequestSerializer serializer];
        [man GET:urlString
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             NSLog(@"请求成功3");
             NSArray *array = responseObject[@"result"];
             NSMutableArray *mArray = [[NSMutableArray alloc]init];
             for (NSDictionary *dic in array) {
                 AskModel *askModel = [AskModel yy_modelWithJSON:dic];
                 [mArray addObject:askModel];
             }
             
             _askArray = [mArray mutableCopy];
             [table reloadData];

         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"请求失败3");
         }];
   

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
