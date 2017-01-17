//
//  ConsumerDetail.m
//  HJApp
//
//  Created by Bruce He on 15/11/2.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "ConsumerDetail.h"

@implementation ConsumerDetail

+(id)ConsumerDetailDictionary:(NSDictionary*)dic
{
    return [[self alloc]initWithDictionary:dic];
    
}
-(id)initWithDictionary:(NSDictionary*)dic
{
    self=[super init];
    if (self)
    {
        //NSString *userid,*uniqueid,*realName,*gender,*birthday;
        _userid=[dic[@"userid"]copy];
        _uniqueid=[dic[@"uniqueid"]copy];
        _realName=[dic[@"realName"]copy];
        _gender=[dic[@"gender"]copy];
        _birthday=[dic[@"birthday"]copy];
        _portrait=[dic[@"portrait"]copy];
        
    }
    return self;
}
@end
