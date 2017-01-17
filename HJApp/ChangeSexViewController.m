//
//  ChangeSexViewController.m
//  HJApp
//
//  Created by Bruce He on 15/11/29.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "ChangeSexViewController.h"

@interface ChangeSexViewController ()

@end

@implementation ChangeSexViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"选择性别";
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    NSArray*sexArray=[[NSArray alloc]initWithObjects:@"男",@"女", nil];
    
    for (int i=0; i<2; i++)
    {
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, i*50, self.view.frame.size.width, 50)];
        view.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:view];
        
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 40, 30)];
        label.text=sexArray[i];
        label.font=[UIFont systemFontOfSize:14];
        [view addSubview:label];
        
        UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        [btn addTarget:self action:@selector(chooseSex:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i;
        [view addSubview:btn];
    }
    UILabel*line=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, self.view.frame.size.width-10, 1)];
    line.backgroundColor=[UIColor grayColor];
    [self.view addSubview:line];
    
}

-(void)chooseSex:(UIButton*)sender
{
    
    AboutMeViewController*aboutMeVC=_aboutMeVC;
    aboutMeVC.isTag=(int)sender.tag+10;
    [self.navigationController popViewControllerAnimated:NO];
    
}

@end
