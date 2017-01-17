//
//  FlowerDetail.m
//  HJApp
//
//  Created by Bruce He on 15/11/5.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "FlowerDetail.h"

@implementation FlowerDetail

+(id)getAllFlowerDictionary:(NSDictionary*)dic
{
    return [[self alloc]initWithDictionary:dic];
    
}
-(id)initWithDictionary:(NSDictionary*)dic
{
    self=[super init];
    if (self)
    {
        //goodsName,*image,*propValue;
        _goodsName=[dic[@"goods_name"]copy];
        _image=[dic[@"image"]copy];
        _propValue=[dic[@"prop_value"]copy];
        _standardNumber=[dic[@"standard_number"]copy];
        _Id=[dic[@"id"]copy];
        _dataArray=dic[@"price_list"];
    }
    return self;
}
@end
