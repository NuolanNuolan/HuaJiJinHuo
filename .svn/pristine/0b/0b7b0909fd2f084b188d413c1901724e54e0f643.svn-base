//
//  OrderExpressViewController.m
//  HJApp
//
//  Created by Bruce on 16/3/23.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "OrderExpressViewController.h"

@interface OrderExpressViewController ()

@end

@implementation OrderExpressViewController

CGSize size;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    size = rect.size;
    
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:0.675 blue:0.933 alpha:1];
    self.navigationController.navigationBar.translucent =NO;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, size.width,size.height)];
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    
    [self.view addSubview:self.webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"http://jinhuo.huaji.com/index.php/article/%d.html?from=app",self.tag]]];
    
    [self.webView loadRequest:request];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title=@"花集公告";
    /*[HttpEngine getNotifition:^(NSArray *dataArray)
     {
     _dataArray=dataArray;
     [self showPage];
     }];*/
}

-(void) webViewDidStartLoad:(UIWebView *)webView{
    self.hud = [BWCommon getHUD];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
    [self.hud removeFromSuperview];
}

@end
