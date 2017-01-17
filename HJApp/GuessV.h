//
//  GuessV.h
//  HJApp
//
//  Created by Bruce He on 16/2/1.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuessV : UIView

@property (nonatomic,strong) UITabBarController *tabVC;
@property (nonatomic,strong) NSArray *dataArray;
- (void)superWidth:(float) width withArray:(NSArray *)array withTabVC:(UITabBarController *)tabVC;
@end
