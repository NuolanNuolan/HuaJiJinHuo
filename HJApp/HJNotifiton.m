//
//  HJNotifiton.m
//  HJApp
//
//  Created by Bruce He on 15/11/17.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "HJNotifiton.h"

@implementation HJNotifiton

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
        _author=[dic[@"author"]copy];
        _dateCreated=[dic[@"date_created"]copy];
        _content=[dic[@"content"]copy];
        _article_id = [dic[@"id"] copy];
    }
    return self;
}
@end
