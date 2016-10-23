//
//  RightViewController.m
//  week
//
//  Created by mac16 on 16/9/16.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "RightViewController.h"
#import <UIKit/UIKit.h>
#import "CityViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface RightViewController ()<CLLocationManagerDelegate>
{
    CGFloat keyboardHeight;
    UIView *view1;
    UITextField *textFile;
    UIButton *quxiaoBu;
    UIButton *city;
    NSString *cityStr;
  
}
@property (nonatomic, strong) CLLocationManager* locationManager;


@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardWillShow:)
                                                name:UIKeyboardWillShowNotification
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardWillHide:)
                                                name:UIKeyboardWillHideNotification
                                              object:nil];
    
    if([CLLocationManager locationServicesEnabled]){
        if(!_locationManager){
            self.locationManager = [[CLLocationManager alloc] init];
            if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
                
                [self.locationManager requestWhenInUseAuthorization];
                [self.locationManager requestAlwaysAuthorization];
            }
            //设置代理
            [self.locationManager setDelegate:self];
            //设置定位精度
            [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
            //设置距离筛选
            [self.locationManager setDistanceFilter:100];
            //开始定位
            [self.locationManager startUpdatingLocation];
            //设置开始识别方向
            [self.locationManager startUpdatingHeading];
        }
    }else{
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil
                                                             message:@"您没有开启定位功能"
                                                            delegate:nil
                                                   cancelButtonTitle:@"确定"
                                                   otherButtonTitles:nil, nil];
        [alertView show];
    }

}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UIKeyboardWillShowNotification
                                                 object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UIKeyboardWillHideNotification
                                                 object:nil];
}
-(void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *avalue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [avalue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    keyboardHeight = keyboardRect.size.height;
    quxiaoBu.hidden = NO;
    [UIView animateWithDuration:0.1 animations:^{
        view1.frame = CGRectMake(0, kScreenHeight-keyboardHeight-40, kScreenWidth, 40);

    }];
    
}

-(void)keyboardWillHide:(NSNotification *)notification{
    keyboardHeight = 0;
    [UIView animateWithDuration:0.1 animations:^{
        view1.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 40);
        
    }];
    quxiaoBu.hidden = YES;
    
}
-(void)createUI{
    NSArray *butName = @[@"全部类目",@"户外活动",@"暂不开放",@"DIY手作",@"派对聚会",@"运动健身",@"文艺生活",@"沙龙学校",@"茶会推荐"];
  
    for (int i=0; i<9; i++) {
        UIButton *but = [[UIButton alloc]init];
        [but setTitle:butName[i] forState:UIControlStateNormal];
//        [but setImage:[UIImage imageNamed:@"ic_c_music_gray@2x.png"] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        
        if (i<3) {
            but.frame = CGRectMake(i*kScreenWidth/3, 80, kScreenWidth/3, 30);
        }else if (i<6&&i>=3){

            but.frame = CGRectMake((i-3)*kScreenWidth/3, 80+50, kScreenWidth/3, 30);
        }else{
           but.frame = CGRectMake((i-6)*kScreenWidth/3, 80+50+50, kScreenWidth/3, 30);

        }
        [self.view addSubview:but];
        
        but.titleLabel.font = [UIFont systemFontOfSize:17];
        [but addTarget:self action:@selector(buttonActions:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
        
        textFile = [[UITextField alloc]initWithFrame:CGRectMake(60+30, 30, kScreenWidth-100, 30)];
        textFile.backgroundColor = [UIColor redColor];
        [self.view addSubview:textFile];
        textFile.placeholder = @"搜索活动";
       textFile.textColor = [UIColor whiteColor];
        
        UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(60+10, 30+5, 20, 20)];
        im.image = [UIImage imageNamed:@"ic_nav_searchImageLight@2x.png"];
        [self.view addSubview:im];
        
        city = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 60, 30)];
//        city.backgroundColor = [UIColor greenColor];
        [self.view addSubview:city];
        city.titleLabel.font = [UIFont systemFontOfSize:15];
//        [city setTitle:@"当前" forState:UIControlStateNormal];
        [city addTarget:self action:@selector(cityAction) forControlEvents:UIControlEventTouchUpInside];
        

    
        
        quxiaoBu = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-40-20, 30+5, 40, 20)];
        [self.view addSubview:quxiaoBu];
        quxiaoBu.backgroundColor = [UIColor clearColor];
        [quxiaoBu setTitle:@"取消" forState:UIControlStateNormal];
        [quxiaoBu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        quxiaoBu.layer.borderWidth = 1;
        quxiaoBu.layer.borderColor = [UIColor whiteColor].CGColor;
        quxiaoBu.titleLabel.font = [UIFont systemFontOfSize:15];
        quxiaoBu.hidden = YES;
        [quxiaoBu addTarget:self action:@selector(quxiaoAction) forControlEvents:UIControlEventTouchUpInside];
        
        view1 = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 40)];
        view1.backgroundColor = [UIColor grayColor];
        [self.view addSubview:view1];
        
        UIButton *bu = [[UIButton alloc]initWithFrame:CGRectMake( kScreenWidth-60,0, 60, 40)];
        [view1 addSubview:bu];
        [bu setTitle:@"完成" forState:UIControlStateNormal];
        [bu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bu addTarget:self action:@selector(buAction) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-60, 40)];
        [view1 addSubview:la];
        la.tintColor = [UIColor lightGrayColor];
        la.text = @"搜索活动";
        la.font = [UIFont systemFontOfSize:10];
        la.textAlignment = NSTextAlignmentCenter;
        
    
}


-(void)buttonActions:(UIButton *)button{
    
}
-(void)buAction{
    [textFile resignFirstResponder];
}

-(void)quxiaoAction{
    [textFile resignFirstResponder];
    textFile.text=@"";

}

-(void)cityAction{
    
    CityViewController *cityCtrl = [[CityViewController alloc]init];
    cityCtrl.currentCityString = cityStr;

    cityCtrl.selectString = ^(NSString *string){
        [city setTitle:string forState:UIControlStateNormal];
    };
    [self presentViewController:cityCtrl animated:YES completion:nil];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [self.locationManager stopUpdatingLocation];
    CLLocation* location = locations.lastObject;
    [self reverseGeocoder:location];
}
//反地理编码
- (void)reverseGeocoder:(CLLocation *)currentLocation {
    
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if(error || placemarks.count == 0){
            NSLog(@"error = %@",error);
        }else{
            
            CLPlacemark* placemark = placemarks.firstObject;
            NSLog(@"placemark:%@",[[placemark addressDictionary] objectForKey:@"City"]);
            cityStr = placemark.locality;
            if (city.titleLabel.text == nil) {
                [city setTitle:cityStr forState:UIControlStateNormal];
            }
//
        }
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
