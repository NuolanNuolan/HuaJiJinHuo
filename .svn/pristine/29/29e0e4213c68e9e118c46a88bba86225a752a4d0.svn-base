//
//  OrderExpressTableViewCell.m
//  HJApp
//
//  Created by Bruce on 16/3/23.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "OrderExpressTableViewCell.h"

#define NJDateFont [UIFont systemFontOfSize:12]
#define NJTextFont [UIFont systemFontOfSize:14]

@implementation OrderExpressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *identifier = @"cell0";
    OrderExpressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[OrderExpressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 让自定义Cell和系统的cell一样, 一创建出来就拥有一些子控件提供给我们使用
        
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = NJTextFont;
        contentLabel.numberOfLines = 0;
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        UILabel *dateLabel = [[UILabel alloc] init];
        dateLabel.font = NJDateFont;
        [dateLabel setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:dateLabel];
        self.dateLabel = dateLabel;
        
    }
    return self;
}



- (void)setViewFrame:(OrderExpressTableViewFrame *)viewFrame
{
    _viewFrame = viewFrame;
    
    // 1.给子控件赋值数据
    [self settingData];
    // 2.设置frame
    [self settingFrame];
}

/**
 *  设置子控件的数据
 */
- (void)settingData
{
    
    NSDictionary *data = self.viewFrame.data;
    self.contentLabel.text = [data objectForKey:@"AcceptStation"];
    
    self.dateLabel.text = [data objectForKey:@"AcceptTime"];
}

/**
 *  设置子控件的frame
 */
- (void)settingFrame
{
    
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    self.contentLabel.frame = self.viewFrame.contentF;
    self.dateLabel.frame = self.viewFrame.dateF;
    
}


@end
