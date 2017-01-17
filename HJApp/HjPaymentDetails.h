//
//  HjPaymentDetails.h
//  HJApp
//
//  Created by 袁联林 on 16/9/5.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HjPaymentDetails : NSObject
//消费描述  余额  流水金额
@property(nonatomic,copy)NSString *summary,*nmoney,*ntotal;
@property(nonatomic,copy)NSString *ict;

+(id)HjPaymentDetailsDictionary:(NSDictionary*)dic;
-(id)initWithDictionary:(NSDictionary*)dic;
@end
