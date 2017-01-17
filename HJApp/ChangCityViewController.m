//
//  ChangCityViewController.m
//  HJApp
//
//  Created by Bruce He on 15/11/6.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "ChangCityViewController.h"
#import "HttpEngine.h"

@interface ChangCityViewController ()

@property(nonatomic,strong)NSArray*dataArray;
@end

#define LBVIEW_WIDTH1 [UIScreen mainScreen].bounds.size.width
#define LBVIEW_HEIGHT1 [UIScreen mainScreen].bounds.size.height

@implementation ChangCityViewController
- (void)viewWillDisappear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillDisappear:animated];
}
-(void)viewWillAppear:(BOOL)animated
{

    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor =RGB(42, 125, 227);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent =NO;
    //self.view.frame=CGRectMake(0, 0, LBVIEW_WIDTH1, LBVIEW_HEIGHT1);
    self.title=@"城市选择";
    //[self.navigationController navigationBar]
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    [HttpEngine getCityNameBackcompletion:^(NSArray*array)
     {
         _dataArray=array;
         [self showPage];
    }];
    
    
}
-(void)showPage
{
    UIScrollView*scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, LBVIEW_WIDTH1, LBVIEW_HEIGHT1)];
    scrollView.contentSize=CGSizeMake(LBVIEW_WIDTH1, 200+_dataArray.count*20);
    [self.view addSubview:scrollView];
    
    UILabel*chooseCityLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, LBVIEW_WIDTH1, 60)];
    chooseCityLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"CITYNAME"];
    chooseCityLabel.textAlignment=NSTextAlignmentCenter;
    chooseCityLabel.textColor=[UIColor redColor];
    chooseCityLabel.font=[UIFont systemFontOfSize:14];
    chooseCityLabel.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:chooseCityLabel];
    
    UILabel*titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 60, LBVIEW_WIDTH1, 40)];
    titleLabel.textAlignment=NSTextAlignmentLeft;
    titleLabel.text=@"热门城市";
    titleLabel.font=[UIFont systemFontOfSize:14];
    [scrollView addSubview:titleLabel];
    
    int height=(int)_dataArray.count/3;
    
    UIView*btnView=[[UIView alloc]initWithFrame:CGRectMake(0, 100, LBVIEW_WIDTH1, (height+1)*60)];
    btnView.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:btnView];
    
    for (int i=0; i<_dataArray.count; i++)
    {
        int X=i%3;
        int Y=i/3;
        
        NSDictionary*dic=_dataArray[i];
        UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake((LBVIEW_WIDTH1-180)/4+X*((LBVIEW_WIDTH1-180)/4+60), Y*40, 60, 30)];
        
        [btn setTitle:dic[@"name"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.tag=i;
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(chooseCity:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:btn];
    }


}
-(void)chooseCity:(UIButton*)sender
{

    NSDictionary*dic=_dataArray[sender.tag];
    
    //homeVC.cityNameStr=dic[@"name"];
    //MYLOG(@"%@",homeVC.cityNameStr);
    [[NSUserDefaults standardUserDefaults]setObject:dic[@"code"] forKey:@"CODE"];
    [[NSUserDefaults standardUserDefaults]setObject:dic[@"name"] forKey:@"CITYNAME"];
    [[NSUserDefaults standardUserDefaults]setObject:dic[@"allowed_regions"] forKey:@"ALLOWED_REGIONS"];
    [[NSUserDefaults standardUserDefaults]setObject:dic[@"allowed_regions_name"] forKey:@"ALLOWED_REGIONS_NAME"];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


@end
