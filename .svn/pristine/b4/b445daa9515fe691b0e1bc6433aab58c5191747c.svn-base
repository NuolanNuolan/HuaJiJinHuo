//
//  MessageDetailViewController.m
//  HJApp
//
//  Created by Bruce He on 15/11/18.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "HttpEngine.h"

@interface MessageDetailViewController ()
@property(nonatomic,strong)NSArray*dataArray;
@end
#define LBVIEW_WIDTH1 [UIScreen mainScreen].bounds.size.width
#define LBVIEW_HEIGHT1 [UIScreen mainScreen].bounds.size.height
@implementation MessageDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"我的消息";
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [HttpEngine messageCentercompletion:^(NSArray *dataArray) {
        _dataArray=dataArray;
        [self showPage];
    }];
}

-(void)showPage
{
    NSDictionary*dic=_dataArray[_row];
    UIFont*font=[UIFont systemFontOfSize:14];
    CGSize size=[dic[@"title"] boundingRectWithSize:CGSizeMake(LBVIEW_WIDTH1, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    UILabel*titleLabel=[[UILabel alloc]initWithFrame:CGRectMake((LBVIEW_WIDTH1-size.width)/2, 10, size.width, 30)];
    titleLabel.text=dic[@"title"];
    titleLabel.font=font;
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    
    UIFont*font1=[UIFont systemFontOfSize:12];
    CGSize size1=[dic[@"content"] boundingRectWithSize:CGSizeMake(LBVIEW_WIDTH1-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font1} context:nil].size;
    UILabel*contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 54, LBVIEW_WIDTH1-40, size1.height)];
    contentLabel.text=dic[@"content"];
    contentLabel.font=font1;
    contentLabel.textColor=[UIColor blackColor];
    [self.view addSubview:contentLabel];
    

}
@end
