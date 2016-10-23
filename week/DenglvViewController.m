//
//  DenglvViewController.m
//  week
//
//  Created by mac16 on 16/9/14.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "DenglvViewController.h"
#import "ZhuceViewController.h"
#import <sqlite3.h>
#import "ViewController.h"

#define kDataBaseFilePath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/database.sqlite"]

@interface DenglvViewController ()
@property (strong, nonatomic) IBOutlet UITableView *dengTableView;
@property (weak, nonatomic) IBOutlet UITextField *number;

@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation DenglvViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _dengTableView.contentOffset = CGPointMake(0, 10);
 
    [self createBackButton];

}

-(void)denglv{
    sqlite3 *sql = NULL;
    int open = sqlite3_open([kDataBaseFilePath UTF8String], &sql);
    if (open != SQLITE_OK) {
        NSLog(@"打开失败");
        return;
    }
    NSString *string = @"SELECT count(*) FROM user WHERE username = ? AND password = ? ;";
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(sql, [string UTF8String], -1, &stmt, NULL);
    if (result != SQLITE_OK) {
        NSLog(@"编译出错");
        sqlite3_close(sql);
        return  ;
    }
    
    sqlite3_bind_text(stmt, 1, [_number.text UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 2, [_password.text UTF8String], -1, NULL);
    sqlite3_step(stmt);
    int coResult = sqlite3_column_int(stmt, 0);
    if (coResult != 1) {
        NSLog(@"登录失败");
        return ;
    }
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

- (IBAction)denglvAction:(id)sender {
    [self denglv];
}
- (IBAction)zhuceAction:(id)sender {
    NSString *sd = @"Zhuce";
    UIStoryboard *story = [UIStoryboard storyboardWithName:sd bundle:[NSBundle mainBundle]];
       ZhuceViewController *zhuce= [story instantiateViewControllerWithIdentifier:@"ZhuceID"];
    [self.navigationController pushViewController:zhuce animated:YES];
    
}

- (void)createBackButton {
    
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(20, 20, 30, 30);
        //按钮的背景图片
        [backButton setBackgroundImage:[UIImage imageNamed:@"cat_me.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        self.navigationItem.leftBarButtonItem = item;
}


- (void)backAction {
    [self.navigationController
     dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
