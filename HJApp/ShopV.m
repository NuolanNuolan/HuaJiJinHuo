//
//  ShopV.m
//  HJApp
//
//  Created by Bruce He on 16/2/24.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "ShopV.h"

@implementation ShopV

- (id)init {
    self = [[[NSBundle mainBundle]loadNibNamed:@"ShopView" owner:nil options:nil] firstObject];
    if (self) {
        _btn.layer.cornerRadius = 5;
        _btn.layer.borderWidth = 1;
        _btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return self;
}
- (void)viewWithSuperSize:(CGSize)size withTabVC:(UITabBarController *)tabVC
{
    _tabBarVC = tabVC;
}
- (IBAction)btnClick:(UIButton *)sender {
    _tabBarVC.selectedIndex = 1;
}

@end
