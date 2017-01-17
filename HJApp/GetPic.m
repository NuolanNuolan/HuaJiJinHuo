//
//  GetPic.m
//  HJApp
//
//  Created by Bruce He on 15/11/2.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "GetPic.h"

@implementation GetPic

+(id)getPicWithDictionary:(NSDictionary*)dic
{
    return [[self alloc]initWithDictionary:dic];
    
}
-(id)initWithDictionary:(NSDictionary*)dic
{
    self=[super init];
    if (self)
    {
        _title=[dic[@"title"]copy];
        _pictureUrlStr=[dic[@"image"]copy];
        _deadline=[dic[@"deadline"]copy];
        _position=[dic[@"position"]copy];
        _linkurl=[dic[@"linkurl"]copy];
    }
    return self;
}

@end
