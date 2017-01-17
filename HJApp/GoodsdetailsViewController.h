//
//  GoodsdetailsViewController.h
//  HJApp
//
//  Created by 袁联林 on 16/9/5.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HjSeedsGoodsDetail.h"
@interface GoodsdetailsViewController : UIViewController
@property(nonatomic,strong)HjSeedsGoodsDetail *model;
@property(nonatomic,copy)NSString*seeds;
@end
