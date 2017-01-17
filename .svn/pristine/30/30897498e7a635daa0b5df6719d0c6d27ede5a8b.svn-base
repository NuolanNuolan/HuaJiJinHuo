//
//  ComplainServe.m
//  HJApp
//
//  Created by Bruce He on 15/11/18.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "ComplainServe.h"

@implementation ComplainServe
+(id)ConsumerDetailDictionary:(NSDictionary*)dic
{
    return [[self alloc]initWithDictionary:dic];
    
}
-(id)initWithDictionary:(NSDictionary*)dic
{
    self=[super init];
    if (self)
    {
        _orderNo=[dic[@"order_no"]copy];
        _dateCreated=[dic[@"date_created"]copy];
        _images=[dic[@"images"]copy];
        _content=[dic[@"content"]copy];
    }
    return self;
}
@end
