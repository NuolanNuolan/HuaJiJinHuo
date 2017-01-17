//
//  ShopV.h
//  HJApp
//
//  Created by Bruce He on 16/2/24.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopV : UIView

@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic,strong)UITabBarController *tabBarVC;
- (void)viewWithSuperSize:(CGSize)size withTabVC:(UITabBarController *)tabVC;
@end
