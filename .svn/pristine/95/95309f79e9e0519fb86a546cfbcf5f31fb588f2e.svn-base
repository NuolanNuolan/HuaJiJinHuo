//
//  MyPropBtn.m
//  HJApp
//
//  Created by Bruce on 15/11/29.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "MyPropBtn.h"

@implementation MyPropBtn


-(void) drawRect:(CGRect)rect{
    
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:3];
    [self.layer setBorderWidth:0.6];
    
    //[self setContentEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    //[self.layer setBorderColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1].CGColor];
    
    
}
-(void) changeStyle{
    if(self.selected){
        [self addSelectedStyle];
    }else{
        [self removeSelectedStyle];
    }
}

-(void) removeSelectedStyle{
    
    [self.layer setBorderColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1].CGColor];
    [self.selectedIcon removeFromSuperview];
}

-(void) addSelectedStyle{
    MYLOG(@"add Selected Style clicked");
    [self.layer setBorderColor:[UIColor colorWithRed:37/255.0 green:119/255.0 blue:188/255.0 alpha:1].CGColor];
    UIImageView *btnSelectedIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"select11.png"]];
    btnSelectedIcon.frame = CGRectMake(self.bounds.size.width-12, 8, 12, 12);
    self.selectedIcon = btnSelectedIcon;
    [self addSubview:btnSelectedIcon];

    //[self.selectedIcon setHidden:NO];
}
//- (MyPropBtn *)withSection:(NSInteger)section withRow:(NSInteger)row {
//
//}
@end
