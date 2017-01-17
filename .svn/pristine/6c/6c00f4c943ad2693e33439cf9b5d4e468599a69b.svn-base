//
//  DistributionTimeViewController.m
//  HJApp
//
//  Created by Bruce He on 15/11/29.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "DistributionTimeViewController.h"

@interface DistributionTimeViewController ()

@end

@implementation DistributionTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"配送时间";
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    for (int i=0; i<_dataArray.count; i++)
    {
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, i*50, self.view.frame.size.width, 49)];
        view.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:view];
        
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 30)];
        label.text=_dataArray[i];
        [view addSubview:label];
        
        UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 49)];
        [btn addTarget:self action:@selector(chooseSex:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i;
        [view addSubview:btn];
    }
}

-(void)chooseSex:(UIButton*)sender
{
    PayViewController*payVC=_payVC;
    payVC.isTagTime=(int)sender.tag+10;
    [self.navigationController popViewControllerAnimated:NO];
}

@end
