//
//  HJViewController.h
//  HJApp
//
//  Created by Bruce on 15/11/29.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWCommon.h"
#import "HttpEngine.h"
#import "MBProgressHUD.h"

@interface HJViewController : UIViewController
<UITabBarControllerDelegate>
{
}
@property(nonatomic,strong)UITabBarController*tabBarVC;

-(void)updateCartCount:(NSString *) number;

- (void)WeiXinPay:(NSString *)out_trade_no ;

-(void)alipay:(NSString *)out_trade_no amount:(NSString *) amount completion:(void(^)(BOOL success))complete;

- (void)alert:(NSString *)title msg:(NSString *)msg;
-(BOOL) isLogin:(UIViewController*)VC withTitle:(NSString*)tilestr with:(int)height;
+(BOOL)needShowPage;
- (void)saveData;
//判断网络
- (NSString *)networkTypeName:(MSCNetworkType)networkType;
@end
