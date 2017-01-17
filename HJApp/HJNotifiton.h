//
//  HJNotifiton.h
//  HJApp
//
//  Created by Bruce He on 15/11/17.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJNotifiton : NSObject

@property(nonatomic,copy)NSString *article_id,*content,*title,*author,*dateCreated;

+(id)getPicWithDictionary:(NSDictionary*)dic;
-(id)initWithDictionary:(NSDictionary*)dic;

@end
