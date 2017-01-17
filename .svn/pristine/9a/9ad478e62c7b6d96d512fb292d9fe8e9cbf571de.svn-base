//
//  UserMoneyViewController.m
//  HJApp
//
//  Created by Bruce He on 15/11/6.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "UserMoneyViewController.h"
#import "HttpEngine.h"


//wechat
#import "WXApi.h"

@interface UserMoneyViewController ()

@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *nokoLabel;
@property (nonatomic, strong) UITextField *monenyNum;
@property (nonatomic, strong) UIButton *zfbBtn;
@property (nonatomic, strong) UIButton *wechatBtn;
@property (nonatomic, strong) UIButton *okBtn;

@property (nonatomic, assign) BOOL btnStatus;
@property (nonatomic, assign) BOOL btn2Status;

///////
@property(nonatomic,strong)NSDictionary*dataDic;
@property(nonatomic,unsafe_unretained)int lastTag;

@end

@implementation UserMoneyViewController

//宏定义宽高
#define VIEW_WIDTH self.view.bounds.size.width
#define VIEW_HEIGHT self.view.bounds.size.height

#define LBVIEW_WIDTH1 [UIScreen mainScreen].bounds.size.width
#define LBVIEW_HEIGHT1 [UIScreen mainScreen].bounds.size.height


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账户余额";
    self.view.backgroundColor = [UIColor whiteColor];
    _lastTag = 1;
    
//    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] init];
//    [tapGes addTarget:self action:@selector(keybordHideAction:)];
//    
//    tapGes.cancelsTouchesInView = NO;
//    
//    [self.view addGestureRecognizer:tapGes];
    
}

-(void)viewWillAppear:(BOOL)animated
{

    self.navigationController.navigationBarHidden=NO;
    [HttpEngine getBalance:^(NSDictionary *dic)
     {
        _dataDic=dic;

         [self thePage];
     }];
    
    if([WXApi isWXAppInstalled]) // 判断 用户是否安装微信
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"order_pay_notification" object:nil];//监听一个通知
    }
}

#pragma mark - 通知信息
- (void)getOrderPayResult:(NSNotification *)notification{
    if ([notification.object isEqualToString:@"success"])
    {
        [self alert:@"恭喜" msg:@"您已成功支付啦!"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self alert:@"提示" msg:@"支付失败"];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//- (void)keybordHideAction:(UITapGestureRecognizer *)tap
//{
//    [self.monenyNum resignFirstResponder];
//    
//}

- (void)thePage
{
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake((LBVIEW_WIDTH1-LBVIEW_WIDTH1/1.5)/2, 40, LBVIEW_WIDTH1 / 1.5, 60)];
    // self.moneyLabel.backgroundColor = [UIColor redColor];
    if (_dataDic) {
        self.moneyLabel.text = _dataDic[@"nmoney"];
    }
    self.moneyLabel.textColor = [UIColor blackColor];
    self.moneyLabel.font = [UIFont systemFontOfSize:40];
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.moneyLabel];
    
    
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1 / 2.3-10,  95, 15, 15)];
    imageView.image=[UIImage imageNamed:@"balance.png"];
    [self.view addSubview:imageView];
    
    self.nokoLabel = [[UILabel alloc] initWithFrame:CGRectMake(LBVIEW_WIDTH1 / 2.3+10, 90, LBVIEW_WIDTH1 * 0.2, 30)];
    self.nokoLabel.text = @"账户余额";
    self.nokoLabel.textColor = [UIColor blackColor];
    self.nokoLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:self.nokoLabel];
    
    self.monenyNum = [[UITextField alloc] initWithFrame:CGRectMake(LBVIEW_WIDTH1 / 13, + self.moneyLabel.frame.size.height + self.nokoLabel.frame.size.height + LBVIEW_WIDTH1 / 9, LBVIEW_WIDTH1 / 1.2, LBVIEW_HEIGHT1 / 14)];
   // self.monenyNum.backgroundColor = [UIColor clearColor];
    self.monenyNum.placeholder = @"请输入充值金额 如:8888";
    //    [self.monenyNum becomeFirstResponder];
    self.monenyNum.font=[UIFont systemFontOfSize:14];
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(10,0,10,LBVIEW_HEIGHT1/14)];
    leftView.backgroundColor = [UIColor clearColor];
    self.monenyNum.leftView = leftView;
    self.monenyNum.leftViewMode = UITextFieldViewModeAlways;
    
    self.monenyNum.layer.borderColor=[UIColor grayColor].CGColor;
    //self.monenyNum.borderStyle = UITextBorderStyleLine;
    self.monenyNum.layer.borderWidth=1;
    self.monenyNum.layer.cornerRadius=5;
    self.monenyNum.clipsToBounds=YES;
    self.monenyNum.keyboardType = UIKeyboardTypeNumberPad;
//    [self.monenyNum addTarget:self action:@selector(keyDown) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:self.monenyNum];
    
    //LBVIEW_WIDTH1 / 1.2-10
    
    //button点击之后本身换成另一张图片。此处用于支付按钮的切换
    self.zfbBtn = [[UIButton alloc]initWithFrame:CGRectMake((LBVIEW_WIDTH1-LBVIEW_WIDTH1 / 1.2)/2-5, + self.moneyLabel.frame.size.height + self.nokoLabel.frame.size.height + LBVIEW_WIDTH1 / 9 + 65, (LBVIEW_WIDTH1 / 1.2-10)/2,(LBVIEW_WIDTH1 / 1.2-10)/270*33)];
    self.zfbBtn.tag=1;
    [self.zfbBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.zfbBtn setBackgroundImage:[UIImage imageNamed:@"zfbBlue.png"] forState:UIControlStateSelected];
    [self.zfbBtn setBackgroundImage:[UIImage imageNamed:@"zfbGray.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.zfbBtn];
    self.zfbBtn.selected = YES;
    
    self.wechatBtn = [[UIButton alloc]initWithFrame:CGRectMake((LBVIEW_WIDTH1-LBVIEW_WIDTH1 / 1.2)/2+(LBVIEW_WIDTH1 / 1.2-10)/2+10, + self.moneyLabel.frame.size.height + self.nokoLabel.frame.size.height + LBVIEW_WIDTH1 / 9 + 65, (LBVIEW_WIDTH1 / 1.2-10)/2, (LBVIEW_WIDTH1 / 1.2-10)/270*33)];
    [self.wechatBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.wechatBtn setBackgroundImage:[UIImage imageNamed:@"wechatGray.png"] forState:UIControlStateNormal];
    [self.wechatBtn setBackgroundImage:[UIImage imageNamed:@"wechatGreen.png"] forState:UIControlStateSelected];
    self.wechatBtn.tag=2;
    [self.view addSubview:self.wechatBtn];
    

    self.okBtn = [[UIButton alloc]init];
    self.okBtn.frame = CGRectMake(LBVIEW_WIDTH1 / 13, + self.moneyLabel.frame.size.height + self.nokoLabel.frame.size.height + LBVIEW_WIDTH1 / 9+(LBVIEW_WIDTH1 / 1.2-10)/270*33+90, LBVIEW_WIDTH1 / 1.2, 40);
    [self.okBtn setTitle:@"确定充值" forState:UIControlStateNormal];
    [self.okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.okBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.okBtn setBackgroundColor:[UIColor redColor]];
    [self.okBtn addTarget:self action:@selector(addMoney) forControlEvents:UIControlEventTouchUpInside];
    self.okBtn.layer.cornerRadius = 5;
    self.okBtn.clipsToBounds=YES;
    [self.view addSubview:self.okBtn];
    
    
}

- (void)click:(UIButton*)sender
{
    if (_lastTag==sender.tag)
    {
        sender.selected=YES;
        return;
    }
    
    if (_lastTag!=0)
    {
        UIButton*btn=[self.view viewWithTag:_lastTag];
        btn.selected=NO;
    }
    
    _lastTag=(int)sender.tag;
    sender.selected=!sender.selected;
}

-(void)addMoney
{
    
    if ([_monenyNum.text isEqualToString:@""])
    {
        [self alert:@"提示" msg:@"请输入金额"];
        
        return;
    }
    
    NSString *pay_method = _lastTag==1 ? @"alipay" : @"weixin";
    
    //[self goZhiFuBao];
    //return;
    NSString *amount = self.monenyNum.text;
    //amount = @"0.01";
    if([amount isEqualToString:@""]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"系统提示" message:@"请输入充值的金额" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction*defaultAction=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            
        }];
        [alertController addAction:defaultAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    [HttpEngine topUpAmount:amount withMethod:pay_method completion:^(NSDictionary *dict) {
        
        NSString *out_trade_no = [dict objectForKey:@"out_trade_no"];
        if([pay_method isEqualToString:@"alipay"])
        {
            [self alipay:out_trade_no amount:amount completion:^(BOOL success) {
                if(success){
                    //返回我的花集
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }
        else
        {
            [self WeiXinPay:out_trade_no];
        }
    }];
}


//-(void)keyDown
//{
//    [self.monenyNum resignFirstResponder];
//}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
