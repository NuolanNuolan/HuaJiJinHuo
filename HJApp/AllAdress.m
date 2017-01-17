//
//  AllAdress.m
//  HJApp
//
//  Created by Bruce He on 15/11/6.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "AllAdress.h"

@implementation AllAdress

+(id)ConsumerDetailDictionary:(NSDictionary*)dic
{
    return [[self alloc]initWithDictionary:dic];
    
}
-(id)initWithDictionary:(NSDictionary*)dic
{
    self=[super init];
    if (self)
    {
        _addrId=[dic[@"addr_id"]copy];
        _consignee=[dic[@"consignee"]copy];
        _phoneMob=[dic[@"phone_mob"]copy];
        _chineseCity=[dic[@"chinese_city"]copy];
        _chineseProvince=[dic[@"chinese_province"]copy];
        _chineseTown=[dic[@"chinese_town"]copy];
        _address=[dic[@"address"]copy];
        _province=[dic[@"province"]copy];

    }
    return self;
}


@end
