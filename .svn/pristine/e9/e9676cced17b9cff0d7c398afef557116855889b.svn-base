//
//  DistributionStyleViewController.m
//  HJApp
//
//  Created by Bruce He on 15/11/29.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "DistributionStyleViewController.h"

@interface DistributionStyleViewController ()

@end

@implementation DistributionStyleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"配送方式";
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    NSArray*deliveryMethodArray=[[NSArray alloc]initWithObjects:@"送货上门",@"上门自提", nil];
    
    for (int i=0; i<2; i++)
    {
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, i*50, self.view.frame.size.width, 49)];
        view.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:view];
        
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 120, 30)];
        label.text=deliveryMethodArray[i];
        [view addSubview:label];
        
        UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 49)];
        [btn addTarget:self action:@selector(deliveryMethodTouched:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i;
        [view addSubview:btn];
    }
    
}

-(void)deliveryMethodTouched:(UIButton*)sender
{
    
    PayViewController*payVC=_payVC;
    payVC.deliveryMethod=(int)sender.tag+10;
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
