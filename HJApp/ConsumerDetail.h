//
//  ConsumerDetail.h
//  HJApp
//
//  Created by Bruce He on 15/11/2.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsumerDetail : NSObject

@property(nonatomic,copy)NSString *userid,*uniqueid,*realName,*gender,*birthday,*mobile,*portrait;

+(id)ConsumerDetailDictionary:(NSDictionary*)dic;
-(id)initWithDictionary:(NSDictionary*)dic;
@end
