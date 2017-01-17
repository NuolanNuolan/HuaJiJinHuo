//
//  MyBtn.h
//  HJApp
//
//  Created by Bruce He on 15/11/5.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBtn : UIButton

@property(nonatomic,unsafe_unretained)BOOL isOpen;
@property(nonatomic,unsafe_unretained)NSInteger section;
@property(nonatomic,unsafe_unretained)NSInteger row;
@property (nonatomic,copy) NSString *titleStr;


@end
