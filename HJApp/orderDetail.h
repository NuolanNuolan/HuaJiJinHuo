//
//  orderDetail.h
//  HJApp
//
//  Created by Bruce He on 15/11/4.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface orderDetail : NSObject

@property(nonatomic,copy)NSString *orderNo,*recvName,*recvMobile,*recvAddress,*preferMoney,*datetime,*toFloristName,*paymentPrice,*currPrice,*merchDesc,*merchImage,*merchName,*merchQty,*orderPrice,*discountPrice;
@property(nonatomic,strong)NSArray*dataArray;

//+(id)ConsumerDetailDictionary:(NSDictionary*)dic;
//-(id)initWithDictionary:(NSDictionary*)dic;
@end
