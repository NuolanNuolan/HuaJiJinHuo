//
//  redPacketViewController.m
//  HJApp
//
//  Created by Bruce He on 15/11/29.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "redPacketViewController.h"

@interface redPacketViewController ()

@end

@implementation redPacketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"红包选择";
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    for (int i=0; i<_dataArray.count; i++)
    {
        NSDictionary*dic=_dataArray[i];

        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, i*50, self.view.frame.size.width, 49)];
        view.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:view];
        
        NSString *price = dic[@"price"];
        UIFont *priceFont = [UIFont systemFontOfSize:14];
        CGSize size = [price boundingRectWithSize:CGSizeMake(200, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:priceFont} context:nil].size;
        
        UILabel*picLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, size.width, 30)];
        picLabel.text=[NSString stringWithFormat:@"%@",dic[@"price"]];
        picLabel.textColor=[UIColor redColor];
        picLabel.font=[UIFont systemFontOfSize:14];
        [view addSubview:picLabel];
        
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(size.width+25, 10, 250, 30)];
        label.text= @"元红包";
        label.font=[UIFont systemFontOfSize:12];
        [view addSubview:label];
        
        UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 49)];
        [btn addTarget:self action:@selector(chooseSex:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i;
        [view addSubview:btn];
    }
    
}

-(void)chooseSex:(UIButton*)sender
{
    NSDictionary*dic=_dataArray[sender.tag];
    PayViewController*payVC=_payVC;
    payVC.isTagRedPacket=dic[@"price"];
    payVC.couponNo=dic[@"prefer_no"];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
