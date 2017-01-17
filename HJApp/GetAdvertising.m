//
//  GetAdvertising.m
//  HJApp
//
//  Created by 袁联林 on 16/9/9.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "GetAdvertising.h"

@implementation GetAdvertising
+(id)GetAdvertisingWithDictionary:(NSDictionary*)dic
{
    return [[self alloc]initWithDictionary:dic];
    
}
-(id)initWithDictionary:(NSDictionary*)dic
{
    self=[super init];
    if (self)
    {
        _title=[dic[@"title"]copy];
        _sub_title=[dic[@"sub_title"]copy];
        _imageurl=[dic[@"image"]copy];
//        _position=[dic[@"position"]copy];
//        _linkurl=[dic[@"linkurl"]copy];
    }
    return self;
}
@end
