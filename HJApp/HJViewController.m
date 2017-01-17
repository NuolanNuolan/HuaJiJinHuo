//
//  HJViewController.m
//  HJApp
//
//  Created by Bruce on 15/11/29.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "HJViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
//zhifubao
#import <AlipaySDK/AlipaySDK.h>
#import "ZhiFuBaoOrder.h"
#import "DataSigner.h"

//wechat
#import "WXApi.h"

@interface HJViewController ()
{

    //网络判断lable
    UILabel *label_Network;
}

@end
#define LBVIEW_WIDTH1 [UIScreen mainScreen].bounds.size.width
#define LBVIEW_HEIGHT1 [UIScreen mainScreen].bounds.size.height
@implementation HJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tabBarVC setDelegate:self];
    //接收网络类型判断
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kMSCNetworkTypeChangedNotification
                                               object: nil];
    // 获取网络类型
    MSCNetworkType type = [MSCNetworkTypeMonitor sharedInstance].networkType;
    if ([[self networkTypeName:type] isEqualToString:@"NotReachable"]) {
        [self showNoNetWorkUI];
    }else
    {
    
        [self removeLable];
    }
    
}
//网络类型发生改变的通知
- (void)reachabilityChanged:(NSNotification *)note
{
    MSCNetworkTypeMonitor* monitor = [note object];
    MSCNetworkType status = monitor.networkType;
    NSString *name = [self networkTypeName:status];
    if ([name isEqualToString:@"NotReachable"]) {
        //无网络时弹出提示框
        [self showNoNetWorkUI];
    }else
    {
    
        //移除提示框
        [self removeLable];
    }
    
    
}
- (NSString *)networkTypeName:(MSCNetworkType)networkType
{
    NSString *string = @"*****";
    
    switch (networkType)
    {
        case kMSCNetworkTypeNone:
            MYLOG(@"当前无网络");
            string = @"NotReachable";
            break;
            
        case kMSCNetworkTypeWiFi:
            MYLOG(@"当前WiFi");
            string = @"ReachableViaWiFi";
            break;
            
        case kMSCNetworkTypeWWAN:
            MYLOG(@"当前WWAN");
            string = @"ReachableViaWWAN";
            break;
            
        case kMSCNetworkType2G:
            MYLOG(@"当前2G");
            string = @"kReachableVia2G";
            break;
            
        case kMSCNetworkType3G:
            MYLOG(@"当前3G");
            string = @"kReachableVia3G";
            break;
            
        case kMSCNetworkType4G:
            MYLOG(@"当前4G");
            string = @"kReachableVia4G";
            break;
        default:
            MYLOG(@"当前default");
            string = @"default";
            break;
    }
    
    return string;
    
}
- (void)showNoNetWorkUI{
    label_Network = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, 20)];
    label_Network.text = @"无网络连接";
    label_Network.textColor = [UIColor whiteColor];
    label_Network.backgroundColor = [UIColor blackColor];
    label_Network.textAlignment = NSTextAlignmentCenter;
    label_Network.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label_Network];
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    // 添加到窗口
    [window addSubview:label_Network];}
//移除无网络lable
-(void)removeLable
{

    [label_Network removeFromSuperview];
    label_Network = nil;
}
-(BOOL) isLogin:(UIViewController*)VC withTitle:(NSString*)tilestr with:(int)height
{
    NSString*str=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    if (!str)
    {
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(20, LBVIEW_HEIGHT1/3-64, LBVIEW_WIDTH1-20, 20)];
        if (height==1)
        {
            label.frame=CGRectMake(20, LBVIEW_HEIGHT1/3, LBVIEW_WIDTH1-20, 20);
        }
        label.text=tilestr;
        label.textColor=[UIColor grayColor];
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:12];
        [VC.view addSubview:label];
        
        NSArray*nameArray=[[NSArray alloc]initWithObjects:@"注册", @"登录",nil];
        for (int i=0; i<2; i++)
        {
            UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(40+i*(LBVIEW_WIDTH1-60)/2, LBVIEW_HEIGHT1/3+26,(LBVIEW_WIDTH1-100)/2, 40)];
            if (height==1)
            {
                btn.frame=CGRectMake(40+i*(LBVIEW_WIDTH1-60)/2, LBVIEW_HEIGHT1/3+90,(LBVIEW_WIDTH1-100)/2, 40);
            }
            btn.layer.borderColor=[UIColor colorWithRed:37/255.0 green:119/255.0 blue:188/255.0 alpha:1].CGColor;
            btn.layer.borderWidth=1;
            [btn setTitle:nameArray[i] forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:14];

            [btn setTitleColor:[UIColor colorWithRed:37/255.0 green:119/255.0 blue:188/255.0 alpha:1] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(loginRegister:) forControlEvents:UIControlEventTouchUpInside];
            btn.layer.cornerRadius=5;
            btn.clipsToBounds=YES;
            btn.tag=332+i;
            [VC.view addSubview:btn];
        }
        return YES;
    }
    return NO;
}

//切换到登陆
-(void)loginRegister:(UIButton*)sender
{
    if (sender.tag==333)
    {
        LoginViewController*loginVC=[[LoginViewController alloc]init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:navigationController animated:YES completion:nil];
    }
    else
    {
        RegisterViewController*registerVC=[[RegisterViewController alloc]init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:registerVC];
        [self presentViewController:navigationController animated:YES completion:nil];
    }
    
}

+(BOOL)needShowPage
{
    NSString*str=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    if (!str)
        return YES;
    else
        return NO;
}
-(void) updateCartCount:(NSString *) number{
    
    UITabBarItem *item = [self.tabBarVC.tabBar.items objectAtIndex:3];
    
    if(number){
        item.badgeValue = number;
    }
    else
    {
        item.badgeValue = nil;
    }
}


#pragma mark - 微信支付
- (void)WeiXinPay:(NSString *)out_trade_no{
    
    MBProgressHUD *HUD = [BWCommon getHUD];
    if([WXApi isWXAppInstalled]) // 判断 用户是否安装微信
    {
        //HUD.delegate = self;
        //HUD.labelText = @"正在为您支付...";
        //[HUD show:YES];
        
        [HttpEngine wxPayRequest:out_trade_no completion:^(NSDictionary *dict) {
            
            [self WXPayRequest:dict[@"appid"] nonceStr:dict[@"nonce_str"] package:@"Sign=WXPay" partnerId:dict[@"mch_id"] prepayId:dict[@"prepay_id"] timeStamp:dict[@"timestamp"] sign:dict[@"sign"]];
            
            [HUD hide:YES];
        }];
        
    }else{
        [HUD hide:YES];
        
        [self alert:@"温馨提示" msg:@"您未安装微信客户端"];
        
    }
    
}

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    //[self alert:@"提示" msg:@"您未安装微信!"];
    
    UIAlertAction*defaultAction=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
    }];
    [alertController addAction:defaultAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 发起支付请求
- (void)WXPayRequest:(NSString *)appId nonceStr:(NSString *)nonceStr package:(NSString *)package partnerId:(NSString *)partnerId prepayId:(NSString *)prepayId timeStamp:(NSString *)timeStamp sign:(NSString *)sign{
    //调起微信支付
    PayReq* wxreq             = [[PayReq alloc] init];
    wxreq.openID              = appId;
    wxreq.partnerId           = partnerId;
    wxreq.prepayId            = prepayId;
    wxreq.nonceStr            = nonceStr;
    wxreq.timeStamp           = [timeStamp intValue];
    wxreq.package             = package;
    wxreq.sign                = sign;
    
    [WXApi sendReq:wxreq];
    
    //MYLOG(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",appId,wxreq.partnerId,wxreq.prepayId,wxreq.nonceStr,(long)wxreq.timeStamp,wxreq.package,wxreq.sign );
    //MYLOG(@"%@",wxreq);
}


//支付宝支付
-(void)alipay:(NSString *)out_trade_no amount:(NSString *) amount completion:(void(^)(BOOL success))complete
{
    
    NSArray* views = [[UIApplication sharedApplication] windows];
    UIWindow* windowtemp = views[0];
    if (windowtemp.hidden) {
        windowtemp.hidden = NO;
    }
    else
    {
        MYLOG(@"no hidden");
    }
    
    NSString *partner = @"2088501633478038";
    NSString *seller = @"hr@ourbloom.com";
    NSString *privateKey = @"MIICXgIBAAKBgQC89o2rkejk5DqF9MZ2j/wmuhzDQdYZ8c1pitg36726la1Q4ySUy0nWmibKitlLrR61ph2ZE2pKHIEV7Wi4bPzUZVqRD+z4y7HcBFeBzq+2vBjsTFtuPOVsnc9yjaqV/ncC4GfCL9YvebILxl1mLsHJbyL3cZbgB1N+bZvBAtfwwwIDAQABAoGBAJUSlRVDWM4qVxkSz/b9BFmw/bv0lmmFXx3iUU1chyNJrZ9gcp2H+sp4dh3XiDGxc8auNC9tJ68r6ZJY5wKHyLSR5UUQ0Cze1nlooE9kltLNdADeEyAlSYN+M68MQrNSXdzoo0hLq04zpqc+XdGIA2xLDlhXRDbMlpVltldzhCxxAkEA9Ssei+mWVCB1nCMiz6qr5yV+SNif1dU02Sp9Lecs8nXrNcDlAsnYPqEjiA1l21Kj4pltUSC1hbS/V4AE+VkBTQJBAMVPvu+cruSF4bj0Sg6WA5JXCBUtgu41wYJRnAU7cg2h47anN0ILWeFFrOPnU/yKlgspnPRDHcHfiozLw0bdsk8CQQDcm/xUsdBPyxWJdiRw8YbV6+sC6cqJw9xWPeF+WLMdSfZo3DY2mCI52Q378vJgtLA7ywuPIPu2YLp8pfnT1b9RAkAn94ZKjOdUPNZDG6CgobxpeR2XBJf/3n2rAxLicG8i2ccBaY+k3h2/pthldacqgXvxGOXFCI9PhRNQf7m3chK7AkEAvtCyBgfzJ9I5wMzsRA7lKO4AjVhHe8SBYWYZWHMWPOipG7adAVm5dp+8g56BZBc3q+VeTfl+SFKn0ojcm+JPLQ==";
    
    ZhiFuBaoOrder *order = [[ZhiFuBaoOrder alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = out_trade_no; //订单ID（由商家?自?行制定）
    order.productName = [NSString stringWithFormat:@"花集网支付单号：%@",out_trade_no] ; //商品标题
    order.productDescription = [NSString stringWithFormat:@"支付金额：%@",amount]; //商品描述
    order.amount = amount; //商品价格
    order.notifyURL = @"http://www.huaji.com/pay/wapalipay/notify_url.php"; //回调URL
    
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"huaji";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    MYLOG(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            //【callback处理支付结果】
            MYLOG(@"alipay reslut = %@",resultDic);
            
            if([resultDic[@"resultStatus"] isEqualToString:@"9000"]){
                [self alert:@"温馨提示" msg:@"订单支付成功"];
                complete(YES);
            
            }else if([resultDic[@"resultStatus"] isEqualToString:@"8000"]){
                [self alert:@"温馨提示" msg:@"订单正在处理中"];
                complete(NO);
            }else{
                [self alert:@"温馨提示" msg:@"订单支付失败"];
                complete(NO);
            }
        }];

        
    }
    
}
- (void)saveData {
    NSString *sendAera = [[NSUserDefaults standardUserDefaults]objectForKey:@"AREA"];
    if (sendAera) {
        AFHTTPSessionManager*manager=[AFHTTPSessionManager manager];
        NSString*idStr=[[NSUserDefaults standardUserDefaults]objectForKey:@"ID"];
        NSString*str=[NSString stringWithFormat:@"http://hjapi.baiwei.org/users/%@/",idStr];
        NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
        NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
        [manager.requestSerializer setValue:tokenStr forHTTPHeaderField:@"Authorization"];
        NSDictionary*parameters;
        if ([sendAera isEqualToString:@"本地"]) {
            parameters=@{@"default_delivery":@"local"};
        } else {
            parameters=@{@"default_delivery":@"origin"};
        }
        [manager PATCH:str parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //MYLOG(@"我的信息JSON:%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //MYLOG(@"我的信息Error:%@",error);
        }];
    }
}
@end
