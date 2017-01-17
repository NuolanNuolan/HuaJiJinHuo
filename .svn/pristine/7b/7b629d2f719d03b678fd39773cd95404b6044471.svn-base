//
//  FeedbackAndCooperationTableViewCell.m
//  HJApp
//
//  Created by 袁联林 on 16/9/13.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "FeedbackAndCooperationTableViewCell.h"

@implementation FeedbackAndCooperationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)Feedback:(UIButton *)sender {
    
    [self.delegate HomePushFeed:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
}

- (IBAction)Cooperation:(UIButton *)sender {
    
    [self.delegate HomePushFeed:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
}
@end
