//
//  BalanceTableViewCell.m
//  HJApp
//
//  Created by 袁联林 on 16/9/2.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "BalanceTableViewCell.h"

@implementation BalanceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)SetArr_data:(HjPaymentDetails *)Payment
{

    
    _title.text=Payment.summary;
    _balance.text = Payment.nmoney;
    _money.text = Payment.ntotal;
    if (![BWCommon DoesItInclude:Payment.ntotal withString:@"-"]) {
        [_money setTextColor:[UIColor greenColor]];
    }
   NSString *str = [BWCommon TheTimeStamp:[NSString stringWithFormat:@"%@",Payment.ict]];
    _time.text = str;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
