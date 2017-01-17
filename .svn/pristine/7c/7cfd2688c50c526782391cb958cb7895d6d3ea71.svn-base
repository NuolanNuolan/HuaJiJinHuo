//
//  OderTableViewCell.m
//  HJApp
//
//  Created by Bruce He on 15/11/4.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "OderTableViewCell.h"

@implementation OderTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.leftImageV = [[UIImageView alloc] init];
        [self.contentView addSubview:self.leftImageV];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = [UIColor blackColor];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        //    self.nameLabel.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.nameLabel];
        
        self.suryouLabel = [[UILabel alloc] init];
        self.suryouLabel.textColor = [UIColor grayColor];
        self.suryouLabel.font = [UIFont systemFontOfSize:12];
        //     self.suryouLabel.backgroundColor = [UIColor yellowColor];
        self.suryouLabel.alpha = 0.7;
        [self.contentView addSubview:self.suryouLabel];
        
        self.moneyLabel = [[UILabel alloc] init];
        //self.moneyLabel.text = @"¥100";
        self.moneyLabel.textColor = [UIColor redColor];
        //        self.moneyLabel.backgroundColor = [UIColor cyanColor];
        self.moneyLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.moneyLabel];
        
        self.X2Label = [[UILabel alloc] init];
        self.X2Label.textColor = [UIColor grayColor];
        self.X2Label.textAlignment=NSTextAlignmentCenter;
        self.X2Label.font = [UIFont systemFontOfSize:14];
        self.X2Label.alpha = 0.5;
        [self.contentView addSubview:self.X2Label];
        
    }
    
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.contentView.frame.size.width / 5;
    CGFloat height = self.contentView.frame.size.height;
    
    self.leftImageV.frame = CGRectMake(width * 0.2, height * 0.1, width * 0.85, height * 0.8);
    self.nameLabel.frame = CGRectMake(width * 1.2, height * 0.2, width * 2.4, 20);
    self.suryouLabel.frame = CGRectMake(width * 1.2, height * 0.7, width * 3, 15);
    self.moneyLabel.frame = CGRectMake(width * 4.2, height * 0.15, width * 0.75+5, 25);
    self.X2Label.frame = CGRectMake(width * 4.2, height * 0.65, width * 0.75, 20);
    
}
- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
