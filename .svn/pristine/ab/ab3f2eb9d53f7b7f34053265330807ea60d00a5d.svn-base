//
//  HjPaymentDetails.m
//  HJApp
//
//  Created by 袁联林 on 16/9/5.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "HjPaymentDetails.h"

@implementation HjPaymentDetails
+(id)HjPaymentDetailsDictionary:(NSDictionary*)dic
{

     return [[self alloc]initWithDictionary:dic];
    
}
-(id)initWithDictionary:(NSDictionary*)dic
{

    self=[super init];
    if (self)
    {
        _summary=[dic[@"summary"]copy];
        _nmoney=[dic[@"nmoney"]copy];
        _ntotal=[dic[@"ntotal"]copy];
        _ict =[dic[@"ict"]copy];
    }
    return self;
}
@end
