//
//  IkenV.m
//  HJApp
//
//  Created by Bruce He on 16/2/1.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "IkenV.h"
#import "IdeaBackViewController.h"
#import "CooperateViewController.h"

@implementation IkenV

#define NJTitleFont [UIFont systemFontOfSize:14]
#define NJFontColor [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]

- (id)init {
    self = [super init];
    if (self) {
       
    }
    return self;
}
- (void)layoutSubviews {


}
- (void)viewWithSuperWidth:(float)width withVC:(UIViewController *)VC {
    _superVC = VC;
    _superWidth = width;
    
    NSArray*array=[[NSArray alloc]initWithObjects:@"意见反馈",@"商务合作", nil];
    for (int i=0; i<2;i++)
    {
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(i*(_superWidth / 2+1), 0, _superWidth / 2-1, 50)];
        view.backgroundColor=[UIColor whiteColor];
        [self addSubview:view];
        
        
        UIImageView*image=[[UIImageView alloc]initWithFrame:CGRectMake(_superWidth/10, (50-16)/2, 16, 16)];
        image.image=[UIImage imageNamed:[NSString stringWithFormat:@"other_service_%d.png",i+1]];
        [view addSubview:image];
        
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(_superWidth/10+25, 10, _superWidth / 4,30)];
        label.text=array[i];
        [label setFont:NJTitleFont];
        [label setTextColor:NJFontColor];
        [view addSubview:label];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*(_superWidth / 2+3), 0,  _superWidth / 2, 50)];
        [btn addTarget:self action:@selector(ikenAndBessButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000+i;
        [self addSubview:btn];
        
    }
}
- (void)ikenAndBessButton:(UIButton *)sender {
    
    UIViewController *VC = [[UIViewController alloc] init];
    if (sender.tag == 1000) {
        IdeaBackViewController*ideaVC=[[IdeaBackViewController alloc]init];
        VC = ideaVC;
    } else {
        CooperateViewController*cooperateVC=[[CooperateViewController alloc]init];
        VC = cooperateVC;
    }
    VC.hidesBottomBarWhenPushed = YES;
    [self.superVC.navigationController pushViewController:VC animated:YES];
}

@end
