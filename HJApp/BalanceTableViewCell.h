//
//  BalanceTableViewCell.h
//  HJApp
//
//  Created by 袁联林 on 16/9/2.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HjPaymentDetails.h"

@interface BalanceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *balance;
@property (weak, nonatomic) IBOutlet UILabel *money;
-(void)SetArr_data:(HjPaymentDetails *)Payment;
@end
