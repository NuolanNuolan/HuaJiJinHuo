//
//  HJFlowersTableViewCell.h
//  HJApp
//
//  Created by 袁联林 on 16/9/12.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HJHomePush_ClassificationDelegate <NSObject>

- (void)HomePushClassification;

@end
@interface HJFlowersTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageview_one;
@property (weak, nonatomic) IBOutlet UIImageView *imageview_two;
@property (weak, nonatomic) IBOutlet UIImageView *imageview_there;
@property (weak, nonatomic) IBOutlet UIImageView *imageview_four;
@property (weak, nonatomic) IBOutlet UILabel *lab_one;
@property (weak, nonatomic) IBOutlet UILabel *lab_two;
@property (weak, nonatomic) IBOutlet UILabel *lab_there;
@property (weak, nonatomic) IBOutlet UILabel *lab_four;
@property (weak, nonatomic) IBOutlet UILabel *labsub_one;
@property (weak, nonatomic) IBOutlet UILabel *labsub_two;
@property (weak, nonatomic) IBOutlet UILabel *labsub_there;
@property (weak, nonatomic) IBOutlet UILabel *labsub_four;
@property(nonatomic,strong)id<HJHomePush_ClassificationDelegate>delegate;
-(void)GetDataArr:(NSArray *)dataArr;

@end
