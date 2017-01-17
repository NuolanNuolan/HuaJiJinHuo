//
//  AddCardsViewController.m
//  HJApp
//
//  Created by 袁联林 on 16/9/7.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "AddCardsViewController.h"

@interface AddCardsViewController ()
{

    //持卡人
    UITextField *_textname;
    //卡号
    UITextField *_textcard;
}

@end

@implementation AddCardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    // Do any additional setup after loading the view.
}

-(void)CreateUI{


    self.view.backgroundColor = RGB(230, 233, 236);
    self.title=@"添加银行卡";
    UILabel *lab = [[UILabel alloc]initWithFrame:CGMAKE(17, 18, 200, 13)];
    [lab setFont:[UIFont systemFontOfSize:12]];
    [lab setTextColor:RGB(88, 88, 88)];
    [lab setText:@"请绑定持本人银行卡"];
    
    UIView *view = [[UIView alloc]initWithFrame:CGMAKE(0, 40, SCREEN_WIDTH, 101)];
    view.backgroundColor = [UIColor whiteColor];
    NSArray *arr = [[NSArray alloc]initWithObjects:@"持卡人",@"卡号", nil];
    for (int i=0; i<2; i++) {
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGMAKE(17, 18+i*50, 55, 17)];
        [lab1 setText:arr[i]];
        [lab1 setFont:[UIFont systemFontOfSize:17]];
        [lab1 setTextColor: [UIColor blackColor]];
        [view addSubview:lab1];
    }
    UIView *view1= [[UIView alloc]initWithFrame:CGMAKE(0, 50, SCREEN_WIDTH, 1)];
    view1.backgroundColor=RGB(230, 233, 236);
    _textname = [[UITextField alloc]initWithFrame:CGMAKE(80, 14, SCREEN_WIDTH-120, 23)];
    _textname.backgroundColor = [UIColor clearColor];
    _textname.textColor = [UIColor blackColor];
    _textname.font=[UIFont systemFontOfSize:14];
    _textname.placeholder=@"持卡人姓名";
    UIImageView *imageview1 = [[UIImageView alloc]initWithFrame:CGMAKE(SCREEN_WIDTH-38, 15, 21, 21)];
    imageview1.image = [UIImage imageNamed:@"name_card"];
    
    
    _textcard = [[UITextField alloc]initWithFrame:CGMAKE(80, 67, SCREEN_WIDTH-120, 23)];
    _textcard.textColor = [UIColor blackColor];
    _textcard.font=[UIFont systemFontOfSize:14];
    _textcard.placeholder=@"银行卡号";
    _textcard.keyboardType = UIKeyboardTypeNumberPad;
    UIImageView *imageview2 = [[UIImageView alloc]initWithFrame:CGMAKE(SCREEN_WIDTH-38, 68, 21, 21)];
    imageview2.image = [UIImage imageNamed:@"photo_card"];

    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGMAKE(17, view.frame.origin.y+114, SCREEN_WIDTH-34, 12)];
    [lab3 setText:@"支付宝智能加密,保护您的账户安全"];
    [lab3 setFont:[UIFont systemFontOfSize:12]];
    [lab3 setTextColor: RGB(164, 164, 164)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn setTintColor:[UIColor whiteColor]];
    [btn setTitle:@"确 认" forState:UIControlStateNormal];
    btn.frame=CGMAKE(20, lab3.frame.origin.y+35, SCREEN_WIDTH-40, 40);
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:btn];
    [self.view addSubview:lab3];
    [view addSubview:imageview1];
    [view addSubview:imageview2];
    [view addSubview:_textname];
    [view addSubview:_textcard];
    [view addSubview:view1];
    [self.view addSubview:view];
    [self.view addSubview:lab];
}
-(void)click
{

    
}
@end
