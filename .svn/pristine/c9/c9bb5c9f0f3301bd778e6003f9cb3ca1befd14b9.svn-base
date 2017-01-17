//
//  HjSeedsGoodsDetail.m
//  HJApp
//
//  Created by 袁联林 on 16/9/5.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "HjSeedsGoodsDetail.h"

@implementation HjSeedsGoodsDetail
+(id)HjSeedsGoodsDetailDictionary:(NSDictionary*)dic
{

    return [[self alloc]initWithDictionary:dic];
}
-(id)initWithDictionary:(NSDictionary*)dic
{

    self=[super init];
    if (self)
    {
        _name=[dic[@"name"]copy];
        _imageurl=[dic[@"full_pic"]copy];
        _price=[dic[@"price"]copy];
        _Goodsid =[dic[@"id"]copy];
        _num1 =[dic[@"num1"]copy];
        _desc =[dic[@"desc"]copy];
    }
    return self;
    
}
@end
