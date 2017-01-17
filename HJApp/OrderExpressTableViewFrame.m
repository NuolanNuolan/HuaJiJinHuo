//
//  OrderExpressTableViewFrame.m
//  HJApp
//
//  Created by Bruce on 16/3/23.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "OrderExpressTableViewFrame.h"

#define NJDateFont [UIFont systemFontOfSize:12]
#define NJTextFont [UIFont systemFontOfSize:14]

@implementation OrderExpressTableViewFrame

-(void) setData:(NSDictionary *) data{
    _data = data;
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    
    CGFloat paddingY = 10;
    CGFloat paddingX = 10;
    
    CGFloat contentX = paddingX;
    CGFloat contentY = paddingY;
    
    CGSize contentSize = [self sizeWithString:[data objectForKey:@"AcceptStation"] font:NJTextFont maxSize:CGSizeMake(size.width - paddingX*2, MAXFLOAT)];
    
    self.contentF = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    
    CGFloat dateY = paddingY + contentY + contentSize.height;
    CGFloat dateX = paddingX;
    CGFloat dateW = size.width / 2;
    CGFloat dateH = 20;
    
    self.dateF = CGRectMake(dateX, dateY, dateW , dateH);
    self.cellHeight =  MAX(dateY + dateH + paddingY,50);
    
}


/**
 *  计算文本的宽高
 *
 *  @param str     需要计算的文本
 *  @param font    文本显示的字体
 *  @param maxSize 文本显示的范围
 *
 *  @return 文本占用的真实宽高
 */
- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}
@end
