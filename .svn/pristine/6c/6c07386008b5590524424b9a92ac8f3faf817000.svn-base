//
//  DataBaseUtil.m
//  HJApp
//
//  Created by Bruce He on 15/11/25.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "DataBaseUtil.h"

@implementation DataBaseUtil

//静态变量： 只会初始化一次；
static FMDatabase *_db=nil;
+(FMDatabase *)getDataBase
{
    if (_db==nil) {
        _db=[[FMDatabase alloc]initWithPath:[NSHomeDirectory()stringByAppendingString:@"/Documents/mydatabasehuajia.sqlite"]];
    }
    return _db;
}

@end
