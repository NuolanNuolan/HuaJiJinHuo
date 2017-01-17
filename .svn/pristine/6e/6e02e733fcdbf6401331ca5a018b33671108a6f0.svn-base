//
//  BWCommon.h
//  HJApp
//
//  Created by Bruce on 15/11/30.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "MBProgressHUD.h"

#define NJTitleFont [UIFont systemFontOfSize:14]
#define NJNameFont [UIFont systemFontOfSize:12]
#define NJTextFont [UIFont systemFontOfSize:10.5]
#define NJFontColor [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]

@interface BWCommon : NSObject
+ (void)verificationCode:(void(^)())blockYes blockNo:(void(^)(id time))blockNo;
+ (UIViewController *)getCurrentVC;

+(MBProgressHUD *)getHUD;

+(UIColor *) getRGBColor: (NSInteger) rgbValue;

+ (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize;

+(void) setTopBorder:(UIView *)view color:(UIColor *)color;
+(void) setBottomBorder:(UIView *)view color:(UIColor *)color;
//时间戳转时间
+(NSString *)TheTimeStamp:(NSString *)date;
//判断是否包含某个字符
+(BOOL)DoesItInclude:(NSString *)str withString:(NSString *)str1;
+(NSMutableArray *)SenderTag:(NSInteger )Tag withArr:(NSArray *)arr;
@end