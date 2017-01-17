//
//  FlowerTableViewCell.m
//  HJApp
//
//  Created by Bruce He on 15/11/6.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "FlowerTableViewCell.h"

@implementation FlowerTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.flowersImageV = [[UIImageView alloc] init];
        self.flowersImageV.image = [UIImage imageNamed:@"flowes.png"];
        //self.flowersImageV.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:self.flowersImageV];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.contentView.frame.size.width / 5;
    CGFloat height = self.contentView.frame.size.height;
    
    self.flowersImageV.frame = CGRectMake( 0, height * 0.1, width * 4.9, height / 1.2);
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
