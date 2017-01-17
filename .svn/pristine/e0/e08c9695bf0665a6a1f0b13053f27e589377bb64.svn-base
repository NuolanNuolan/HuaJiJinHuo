//
//  FlowerCatalogue.m
//  HJApp
//
//  Created by Bruce He on 15/11/12.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "FlowerCatalogue.h"

@implementation FlowerCatalogue

+(id)getCatalogueDictionary:(NSDictionary*)dic
{
    return [[self alloc]initWithDictionary:dic];
    
}
-(id)initWithDictionary:(NSDictionary*)dic
{
    self=[super init];
    if (self)
    {
        _catalogueArray=dic[@"prop_value"];
        _name=[dic[@"name"]copy];
    }
    return self;
}
@end
