//
//  PayTableViewCell.m
//  HJApp
//
//  Created by Bruce on 15/11/30.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "PayTableViewCell.h"

@implementation PayTableViewCell

-(void) layoutSubviews{
    [super layoutSubviews];
    
    /*self.imageView.bounds = CGRectMake(10, 10, 30, 30);
     self.imageView.frame = CGRectMake(10, 10, 30, 30);
     self.imageView.contentMode = UIViewContentModeScaleAspectFill;
     */
    
    CGRect tmpFrame = self.textLabel.frame;
    tmpFrame.origin.x = 55;
    self.textLabel.frame = tmpFrame;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //self.accessoryType = UITableViewCellAccessoryNone;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *identifier = @"cell11";
    PayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[PayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 24, 24)];
        self.iconImage = iconImage;
        [self.contentView addSubview:iconImage];
        
        [self.textLabel setFont:[UIFont systemFontOfSize:14]];
    }
    
    return self;
}
@end
