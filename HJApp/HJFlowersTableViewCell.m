//
//  HJFlowersTableViewCell.m
//  HJApp
//
//  Created by 袁联林 on 16/9/12.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "HJFlowersTableViewCell.h"
#import "GetAdvertising.h"

@implementation HJFlowersTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)GetDataArr:(NSArray *)dataArr
{
    GetAdvertising *model = dataArr[0];
    _lab_one.text = model.title;
    _labsub_one.text = model.sub_title;
    [_imageview_one sd_setImageWithURL:[NSURL URLWithString:model.imageurl]];
    _imageview_one.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    [_imageview_one addGestureRecognizer:tap];
    
}
- (void)click:(UITapGestureRecognizer*)sender{
    
    
    [self.delegate HomePushClassification];

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
