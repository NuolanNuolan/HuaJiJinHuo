//
//  PayTableViewCell.h
//  HJApp
//
//  Created by Bruce on 15/11/30.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayTableViewCell : UITableViewCell

@property (nonatomic,retain) UIImageView *iconImage;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
