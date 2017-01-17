//
//  GetAdvertising.h
//  HJApp
//
//  Created by 袁联林 on 16/9/9.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetAdvertising : NSObject
@property(nonatomic,copy)NSString *title,*sub_title,*imageurl;

+(id)GetAdvertisingWithDictionary:(NSDictionary*)dic;
-(id)initWithDictionary:(NSDictionary*)dic;

@end
