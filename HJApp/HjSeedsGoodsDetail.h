//
//  HjSeedsGoodsDetail.h
//  HJApp
//
//  Created by 袁联林 on 16/9/5.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HjSeedsGoodsDetail : NSObject
@property(nonatomic,copy)NSString *name,*imageurl,*price,*Goodsid,*num1,*desc;
+(id)HjSeedsGoodsDetailDictionary:(NSDictionary*)dic;
-(id)initWithDictionary:(NSDictionary*)dic;
@end
