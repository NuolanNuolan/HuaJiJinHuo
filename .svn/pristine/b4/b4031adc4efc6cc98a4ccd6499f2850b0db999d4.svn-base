//
//  FeedbackAndCooperationTableViewCell.h
//  HJApp
//
//  Created by 袁联林 on 16/9/13.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HJHomePush_FeedbackDelegate <NSObject>

- (void)HomePushFeed:(NSString *)tag;

@end
@interface FeedbackAndCooperationTableViewCell : UITableViewCell
- (IBAction)Feedback:(UIButton *)sender;
- (IBAction)Cooperation:(UIButton *)sender;

//按钮跳转协议
@property(nonatomic,strong)id<HJHomePush_FeedbackDelegate>delegate;
@end
