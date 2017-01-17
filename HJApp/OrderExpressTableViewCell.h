//
//  OrderExpressTableViewCell.h
//  HJApp
//
//  Created by Bruce on 16/3/23.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderExpressTableViewFrame.h"

@interface OrderExpressTableViewCell : UITableViewCell

@property (nonatomic,strong) OrderExpressTableViewFrame *viewFrame;

+(instancetype) cellWithTableView: (UITableView *) tableView;

@property(nonatomic,assign) UILabel *contentLabel;
@property(nonatomic,assign) UILabel *dateLabel;
@end
