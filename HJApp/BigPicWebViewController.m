//
//  BigPicWebViewController.m
//  HJApp
//
//  Created by Bruce He on 15/11/18.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "BigPicWebViewController.h"
#import "HttpEngine.h"

@interface BigPicWebViewController ()
@property(nonatomic,strong)NSArray*dataArray;
@end
#define LBVIEW_WIDTH1 [UIScreen mainScreen].bounds.size.width
#define LBVIEW_HEIGHT1 [UIScreen mainScreen].bounds.size.height
@implementation BigPicWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"大图浏览";
    [HttpEngine complainServerPage:@"1" withPageSize:@"10" completion:^(NSArray *dataArray) {
        _dataArray=dataArray;
        [self showWebView];
    }];
}
-(void)showWebView
{
    ComplainServe*complain=_dataArray[_section];
    NSArray*imageArray=[complain.images componentsSeparatedByString:@"|"];
    UIWebView * view = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, LBVIEW_WIDTH1, LBVIEW_HEIGHT1)];
    [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageArray[_row]]]];
    view.opaque=NO;
    view.scalesPageToFit=YES;
    [self.view addSubview:view];
}
@end
