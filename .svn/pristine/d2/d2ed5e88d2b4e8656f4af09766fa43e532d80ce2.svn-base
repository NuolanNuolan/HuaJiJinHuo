//
//  TodayShopViewController.m
//  HJApp
//
//  Created by Bruce He on 15/11/17.
//

#import "TodayShopViewController.h"
#import "HttpEngine.h"

@interface TodayShopViewController ()
{

    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
@property(nonatomic,strong)NSArray*dataArray;
@property(nonatomic,retain) UIWebView *webView;
@end

#define LBVIEW_WIDTH1 [UIScreen mainScreen].bounds.size.width
#define LBVIEW_HEIGHT1 [UIScreen mainScreen].bounds.size.height

@implementation TodayShopViewController

CGSize size;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self CreateUI];
    //仿进度条
    [self progressPro];
    

    
}
-(void)CreateUI{

    self.title=@"花集公告";
    CGRect rect = [[UIScreen mainScreen] bounds];
    size = rect.size;
    
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor = RGB(42, 125, 227);
    
    
    self.view.backgroundColor = RGB(230, 233, 236);
    self.navigationController.navigationBar.translucent =NO;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.view addSubview:self.webView];
}
-(void)progressPro
{

    // 仿微信进度条

    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    // 请求网络
    [self LoadData];
}
-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
     [self.navigationController.navigationBar addSubview:_progressView];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [_progressView removeFromSuperview];

    
}
#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];

}
-(void)LoadData{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
         NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"http://jinhuo.huaji.com/index.php/article/%d.html?from=app",self.tag]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            [self.webView loadRequest:request];
        });
    });
   
}
//采用懒加载
-(UIWebView *)webView
{

    if (!_webView) {
        UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, size.width,size.height-64)];
        webview.scalesPageToFit = YES;
        webview.delegate=self;
        [self.view addSubview:webview];
        _webView =webview;
    }
    
    return _webView;
}
//-(void)showPage
//{
//    HJNotifiton*hjn=_dataArray[_tag];
//    UILabel*titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, LBVIEW_WIDTH1, LBVIEW_HEIGHT1/15)];
//    titleLabel.text=hjn.title;
//    titleLabel.textAlignment=NSTextAlignmentCenter;
//    titleLabel.font=[UIFont boldSystemFontOfSize:20];
//    [self.view addSubview:titleLabel];
//    
//    UILabel*detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,LBVIEW_HEIGHT1/15, LBVIEW_WIDTH1-20, LBVIEW_HEIGHT1/20)];
//    detailLabel.text=[NSString stringWithFormat:@"作者: %@   发布日期: %@",hjn.author,hjn.dateCreated];
//    detailLabel.font=[UIFont systemFontOfSize:15];
//    detailLabel.textAlignment=NSTextAlignmentCenter;
//    [self.view addSubview:detailLabel];
//    
//    
//    UILabel*lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, LBVIEW_HEIGHT1/15+LBVIEW_HEIGHT1/20,  LBVIEW_WIDTH1-20, 1)];
//    lineLabel.backgroundColor=[UIColor grayColor];
//    [self.view addSubview:lineLabel];
//
//    UIFont*font=[UIFont systemFontOfSize:15];
//    CGSize size = [hjn.content boundingRectWithSize:CGSizeMake(LBVIEW_WIDTH1-40, LONG_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
//    
//    
//    UILabel*contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, LBVIEW_HEIGHT1/15+6+LBVIEW_HEIGHT1/20, LBVIEW_WIDTH1-40, size.height+30)];
//    contentLabel.text=hjn.content;
//    contentLabel.font=font;
//    contentLabel.numberOfLines=0;
//    [self.view addSubview:contentLabel];
//    
//}

@end
