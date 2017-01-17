//
//  UserMoneyViewController.h
//  HJApp
//
//  Created by Bruce He on 15/11/6.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "HJViewController.h"

@interface UserMoneyViewController : HJViewController
<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}

@end
