//
//  WithdrawalViewController.m
//  HJApp
//
//  Created by 袁联林 on 16/9/6.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "WithdrawalViewController.h"

@interface WithdrawalViewController ()
{

    UITextField *_textfild;
}

@end

@implementation WithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    // Do any additional setup after loading the view.
}

-(void)CreateUI{

    self.view.backgroundColor = RGB(230, 233, 236);
    self.title=@"余额提现";
    UIView *view = [[UIView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, 40)];
    view.backgroundColor=[UIColor clearColor];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGMAKE(20, 12, 150, 15)];
    [lab setFont:[UIFont systemFontOfSize:15]];
    [lab setTextColor:[UIColor blackColor]];
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"可提现金额: %@元",_balance]];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:[NSString stringWithFormat:@"%@",_balance]];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range1];
    lab.attributedText=hintString;
    
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGMAKE(0, 40, SCREEN_WIDTH, 69)];
    view1.backgroundColor = [UIColor whiteColor];
    _textfild = [[UITextField alloc]initWithFrame:CGMAKE(20, 15, SCREEN_WIDTH-40, 40)];
    _textfild.backgroundColor = RGB(230, 233, 236);
    _textfild.layer.borderWidth=1;
    _textfild.layer.borderColor = RGB(230, 233, 236).CGColor;
    _textfild.textColor = [UIColor blackColor];
    _textfild.font=[UIFont systemFontOfSize:14];
    _textfild.placeholder=@" 请输入提现金额";
    _textfild.keyboardType = UIKeyboardTypeNumberPad;
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGMAKE(0, view1.frame.origin.y+74, SCREEN_WIDTH, 116)];
    view2.backgroundColor = [UIColor whiteColor];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGMAKE(31, 34, 10, 13)];
    imageview.image = [UIImage imageNamed:@"lamp"];
    UILabel *lab1= [[UILabel alloc]initWithFrame:CGMAKE(45, 33, SCREEN_WIDTH-90, 15)];
    [lab1 setTextColor:[UIColor blackColor]];
    [lab1 setText:@"2个工作日之内退回至最近消费的账户中"];
    [lab1 setFont:[UIFont systemFontOfSize:15]];
    UILabel*lab2 = [[UILabel alloc]initWithFrame:CGMAKE(31, 57, SCREEN_WIDTH-62, 35)];
    [lab2 setFont:[UIFont systemFontOfSize:12]];
    lab2.numberOfLines=0;
    [lab2 setText:@"银行处理可能有延迟,具体以到账时间为准.由于余额可能有多个支付来源,提现时也分多笔到账"];
    [lab2 setTextColor:RGB(88, 88, 88)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:RGB(52, 147, 233)];
    [btn setTintColor:[UIColor whiteColor]];
    [btn setTitle:@"确认提现" forState:UIControlStateNormal];
    btn.frame=CGMAKE(20, view2.frame.origin.y+134, SCREEN_WIDTH-40, 40);
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    UILabel *lab3= [[UILabel alloc]initWithFrame:CGMAKE(50, btn.frame.origin.y+47, SCREEN_WIDTH-100, 13)];
    [lab3 setFont:[UIFont systemFontOfSize:12]];
    [lab3 setTextColor:RGB(88, 88, 88)];
    [lab3 setText:@"每日可提现一次"];
    lab3.textAlignment = NSTextAlignmentCenter;
    
    
    [self.view addSubview:lab3];
    [self.view addSubview:btn];
    [view2 addSubview:lab2];
    [view2 addSubview:lab1];
    [view2 addSubview:imageview];
    [view1 addSubview:_textfild];
    [view addSubview:lab];
    [self.view addSubview:view];
    [self.view addSubview:view1];
    [self.view addSubview:view2];
}
-(void)click
{

    
}
@end
