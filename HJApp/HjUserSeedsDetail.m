//
//  HjUserSeedsDetail.m
//  HJApp
//
//  Created by 袁联林 on 16/9/2.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "HjUserSeedsDetail.h"

@implementation HjUserSeedsDetail
+(id)HjUserSeedsDetailDictionary:(NSDictionary*)dic
{

    return [[self alloc]initWithDictionary:dic];
    
}
-(id)initWithDictionary:(NSDictionary*)dic
{

    self=[super init];
    if (self)
    {
        _coupon_number=[dic[@"coupon_number"]copy];
        _point_change=[dic[@"point_change"]copy];
        _point_money=[dic[@"point_money"]copy];
    }
    return self;
}
@end
