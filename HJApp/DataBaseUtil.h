//
//  DataBaseUtil.h
//  HJApp
//
//  Created by Bruce He on 15/11/25.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@interface DataBaseUtil : NSObject

//获取数据库对象
+(FMDatabase *)getDataBase;
@end
