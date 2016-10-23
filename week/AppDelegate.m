//
//  AppDelegate.m
//  week
//
//  Created by mac on 16/8/28.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "MMDrawerController.h"
#import "GuideViewController.h"
//#import "BaseNavigationController.m"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *pathstr = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/covers"];
    NSLog(@"%@",NSHomeDirectory());
    if (![fileManager fileExistsAtPath:pathstr]) {
        GuideViewController *viewController = [[GuideViewController alloc]init];
        //    UINavigationController *nav = [[UINavigationController  alloc]initWithRootViewController:viewController];
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.window.rootViewController = viewController;
        [self.window makeKeyAndVisible];
    }else {
        ViewController *viewCT = [[ViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewCT];
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        [self.window makeKeyAndVisible];
        self.window.backgroundColor = [UIColor whiteColor];
        
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
        
        //    [mmd setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        //        MMExampleDrawerVisualStateManager *manger = [MMExampleDrawerVisualStateManager sharedManager];
        //        MMDrawerControllerDrawerVisualStateBlock block = [manger drawerVisualStateBlockForDrawerSide:drawerSide];
        //
        //        if (block) {
        //            block(drawerController,drawerSide,percentVisible);
        //        }
        //    
        //    
        //    }];
        //    
        self.window.rootViewController = mmd;
    }
    
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
