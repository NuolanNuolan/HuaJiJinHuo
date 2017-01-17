//
//  PayViewController.h
//  HJApp
//
//  Created by Bruce He on 15/11/6.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWCommon.h"
#import "MBProgressHUD.h"
#import "HJViewController.h"


@interface PayViewController : HJViewController<
UITableViewDataSource,
UITableViewDelegate,
UIGestureRecognizerDelegate
>

@property(nonatomic,assign)int deliveryMethod;
@property(nonatomic,assign)int isTagTime;
@property(nonatomic,copy)NSString*isTagRedPacket;
@property(nonatomic,copy)NSString*couponNo;
@end

