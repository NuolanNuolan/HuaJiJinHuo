//
//  ShopingCar.m
//  HJApp
//
//  Created by Bruce He on 15/11/5.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "ShopingCar.h"

@implementation ShopingCar


+(id)ConsumerDetailDictionary:(NSDictionary*)dic
{
    return [[self alloc]initWithDictionary:dic];
    
}
-(id)initWithDictionary:(NSDictionary*)dic
{
    self=[super init];
    if (self)
    {
        _skuName=[dic[@"sku_name"]copy];
        _price=[dic[@"price"]copy];
        _number=[dic[@"number"]copy];
        _skuId=[dic[@"sku_id"]copy];
        _supplierId=[dic[@"supplier_id"]copy];
        _Id=[dic[@"id"]copy];
        _props=dic[@"props"];
    }
    return self;
}
@end
