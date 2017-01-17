//
//  AppDelegate.m
//  HJApp
//
//  Created by Bruce He on 15/10/30.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "AppDelegate.h"
#import "FlashViewController.h"
#import <AlipaySDK/AlipaySDK.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


//拷贝资源路径
-(void)copyDataBase
{
    //获取应用程序资源的路径
    NSString * path=[[NSBundle mainBundle]pathForResource:@"mydatabasehuajia" ofType:@"sqlite"];
    
    // NSuserDefaults 对象序列化 数据库 coreData
    NSString * destionPath=[NSHomeDirectory() stringByAppendingString:@"/Documents/mydatabasehuajia.sqlite"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:destionPath])
    {
        [[NSFileManager defaultManager]copyItemAtPath:path toPath:destionPath error:nil];
    }
    else
    {
       // MYLOG(@"文件已经存在");
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch....
    
    self.window.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:1 alpha:1];
    [self.window makeKeyAndVisible];

    [self copyDataBase];
    
    FlashViewController*flashVC=[[FlashViewController alloc]init];
    self.window.rootViewController=flashVC;
    
    //微信
    [WXApi registerApp:@"wxf454e1c4757a9d2b" withDescription:@"微信支付"];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    return YES;
}


-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:{
                strMsg = @"支付结果：成功！";
                MYLOG(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                NSNotification *notification = [NSNotification notificationWithName:@"order_pay_notification" object:@"success"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
            default:{
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                MYLOG(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                NSNotification *notification = [NSNotification notificationWithName:@"order_pay_notification" object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
        }
    }
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //    [alert show];
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            MYLOG(@"application result = %@",resultDic);
        }];
    }
    else if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            MYLOG(@"application result = %@",resultDic);
        }];
    }
    else {
        return [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
