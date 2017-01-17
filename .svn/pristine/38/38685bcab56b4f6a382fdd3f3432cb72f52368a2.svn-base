//
//  MyHJTableViewCell.m
//  HJApp
//
//  Created by Bruce on 15/12/1.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "MyHJTableViewCell.h"

#define LBVIEW_WIDTH1 [UIScreen mainScreen].bounds.size.width
#define LBVIEW_HEIGHT1 [UIScreen mainScreen].bounds.size.height
@implementation MyHJTableViewCell

-(void) layoutSubviews{
    [super layoutSubviews];
    
    /*self.imageView.bounds = CGRectMake(10, 10, 30, 30);
     self.imageView.frame = CGRectMake(10, 10, 30, 30);
     self.imageView.contentMode = UIViewContentModeScaleAspectFill;
     */
    
    CGRect tmpFrame = self.textLabel.frame;
    tmpFrame.origin.x = 40;
    self.textLabel.frame = tmpFrame;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *identifier = @"cell12";
    MyHJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[MyHJTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 20, 20)];
        self.iconImage = iconImage;
        [self.contentView addSubview:iconImage];
        [self.textLabel setFont:[UIFont systemFontOfSize:16]];
        [self.textLabel setTextColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1]];
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(LBVIEW_WIDTH1-155, 14, 120, 20)];
        self.rightLabel=rightLabel;
        //rightLabel.backgroundColor=[UIColor redColor];
        [rightLabel setFont:[UIFont systemFontOfSize:14]];
        [rightLabel setTextAlignment:NSTextAlignmentRight];
        [rightLabel setTextColor:[UIColor grayColor]];
        
        [self.contentView addSubview:rightLabel];
    }
    
    return self;
}

@end
