//
//  ZhuceViewController.m
//  week
//
//  Created by mac16 on 16/9/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "ZhuceViewController.h"
#import <sqlite3.h>
#import "ViewController.h"


#define kDataBaseFilePath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/database.sqlite"]
@interface ZhuceViewController ()
@property (weak, nonatomic) IBOutlet UITextField *num;
@property (weak, nonatomic) IBOutlet UITextField *pass;
@property (weak, nonatomic) IBOutlet UITextField *repass;

@end

@implementation ZhuceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [back setImage:[UIImage imageNamed:@"ic_nav_left@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem *it = [[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = it;
    
    [back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
   
    [self createDataBase];
   
}

-(void)backAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)zhuce:(id)sender {
    if (_pass.text == _repass.text) {
        [self inserUser];
    }else{
        UIAlertController *al = [UIAlertController alertControllerWithTitle:@"请检查您的密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [al addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           _pass.text = @"";
           _repass.text = @"";
        }]];
        [self presentViewController:al animated:YES completion:nil];
    }
    
}
//创建数据库
-(void)createDataBase{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:kDataBaseFilePath]) {
        NSLog(@"数据库已存在");
        return;
    }
    NSLog(@"%@",kDataBaseFilePath);
    [manager createFileAtPath:kDataBaseFilePath contents:nil attributes:nil];
    
    
    sqlite3 *sql = NULL;
    
    int openResult = sqlite3_open([kDataBaseFilePath UTF8String], &sql);
    if (openResult == SQLITE_OK) {
        NSLog(@"数据库打开成功");
    }else {
        NSLog(@"数据库打开失败");
        [manager removeItemAtPath:kDataBaseFilePath error:nil];
        return;
    }
    
    NSString *sqlString = @"CREATE TABLE user (username inter NOT NULL UNIQUE,password text NOT NULL);";
    char * errmsg = NULL;
    int exeResult = sqlite3_exec(sql, [sqlString UTF8String], NULL, NULL, &errmsg);
    //判断是否执行成功
    if (exeResult == SQLITE_OK) {
        NSLog(@"表创建成功");
    } else {
        NSLog(@"创建失败 %s", errmsg);
        //关闭数据库，删除文件
        sqlite3_close(sql);
        [manager removeItemAtPath:kDataBaseFilePath error:nil];
        return;
    }
    //结束语句
    sqlite3_close(sql);

}
-(void)inserUser{
    sqlite3 *sqlite = NULL;
    int openDBResult = sqlite3_open([kDataBaseFilePath UTF8String], &sqlite);
    if (openDBResult != SQLITE_OK) {
        NSLog(@"打开失败");
        return;
    }
    NSString *string = @"INSERT INTO user(username, password) VALUES(?,?);";
    sqlite3_stmt *stmt = NULL;
    
    int result = sqlite3_prepare_v2(sqlite, [string UTF8String], -1, &stmt, NULL);
    if (result != SQLITE_OK) {
        NSLog(@"编译出错");
        //关闭数据库
        sqlite3_close(sqlite);
        return;
    }
    if (_num.text.length != 11) {
        UIAlertController *al = [UIAlertController alertControllerWithTitle:@"请检查您的手机号" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [al addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            _num.text = @"";
        }]];
        [self presentViewController:al animated:YES completion:nil];
        
    }else{
        sqlite3_bind_text(stmt, 1, [_num.text UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [_pass.text UTF8String], -1, NULL);
        
        
        //4. 执行SQL句柄
        result = sqlite3_step(stmt);
        if (result == SQLITE_DONE) {
            NSLog(@"插入数据成功");
            NSLog(@"%@",kDataBaseFilePath);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
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
                
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            
            
        } else {
            NSLog(@"插入数据失败");

    }
        }
    
    //释放句柄  关闭数据库
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
