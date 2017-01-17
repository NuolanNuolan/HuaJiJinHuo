//
//  HjUserSeedsDetail.h
//  HJApp
//
//  Created by 袁联林 on 16/9/2.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HjUserSeedsDetail : NSObject
//花籽数 积分代金券
@property(nonatomic,copy)NSString *point_change,*point_money,*coupon_number;

+(id)HjUserSeedsDetailDictionary:(NSDictionary*)dic;
-(id)initWithDictionary:(NSDictionary*)dic;
@end
