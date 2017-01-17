//
//  RegisterViewController.m
//  HJApp
//
//  Created by Bruce He on 15/11/2.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "RegisterViewController.h"
#import "HttpEngine.h"

@interface RegisterViewController ()

@property (nonatomic, strong) UIButton *yzmBtn;
@property (nonatomic, strong) UIButton *zcBtn;
@property (nonatomic,strong) UILabel *timeLimitLabel;

//注册参数
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *yzmTF;
@property (nonatomic, strong) UITextField *pswTF;
@property (nonatomic, strong) UITextField *psw2TF;

@property (nonatomic, strong) UIButton *getBtn;
@property (nonatomic, strong) UILabel *agreeL;
@property (nonatomic, strong) UIButton *hozonBtn;

@property (nonatomic, strong) UIImage *hqOn;
@property (nonatomic, strong) UIImage *hqOff;

@property (nonatomic, strong) UIImage *getOn;
@property (nonatomic, strong) UIImage *getOff;

@property (nonatomic, assign) BOOL hqStatus;
@property (nonatomic, assign) BOOL getStatus;

//花集协议页面
@property(nonatomic,strong)UIView*hJView;
@property(nonatomic,strong)UIView*shadowView;

@property (nonatomic,strong) UIScrollView *scrollView;
@end

#define LBVIEW_WIDTH1 [UIScreen mainScreen].bounds.size.width
#define LBVIEW_HEIGHT1 [UIScreen mainScreen].bounds.size.height

#define KEYDOWN returnKeyType = UIReturnKeyDone;
#define KEYVOID addTarget:self action:@selector(keyDown) forControlEvents:UIControlEventEditingDidEndOnExit

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor ]];
    [self.navigationController.navigationBar setBarTintColor:RGB(42, 125, 227)];
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(closeTouched:)];
    self.navigationItem.leftBarButtonItem = closeItem;
    
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    [self registerPage];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keybordHide:)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark---------模态消失
- (void) closeTouched:(UIBarButtonItem *) sender{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)keybordHide:(UITapGestureRecognizer *)tap
{
    [self.phoneTF resignFirstResponder];
    [self.yzmTF resignFirstResponder];
    [self.pswTF resignFirstResponder];
    [self.psw2TF resignFirstResponder];
    
}

#pragma mark---------加载页面
- (void)registerPage
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, LBVIEW_WIDTH1, LBVIEW_HEIGHT1)];
    _scrollView.contentSize = CGSizeMake(LBVIEW_WIDTH1, LBVIEW_HEIGHT1+120);
    [self.view addSubview:_scrollView];
    
    self.phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(LBVIEW_WIDTH1*0.05, LBVIEW_HEIGHT1 * 0.02+10, LBVIEW_WIDTH1*0.9, LBVIEW_HEIGHT1*0.06)];
    self.phoneTF.backgroundColor = [UIColor clearColor];
    [self.phoneTF setBorderStyle:UITextBorderStyleLine];
    [self.phoneTF.layer setBorderWidth:1];
    [self.phoneTF.layer setBorderColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1].CGColor];
    self.phoneTF.textColor = [UIColor blackColor];
    self.phoneTF.placeholder=@"手机号码";
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(10,0,10,LBVIEW_HEIGHT1*0.06)];
    leftView.backgroundColor = [UIColor clearColor];
    _phoneTF.leftView = leftView;
    _phoneTF.leftViewMode = UITextFieldViewModeAlways;
    _phoneTF.KEYDOWN
    [_phoneTF KEYVOID];
    [_scrollView addSubview:self.phoneTF];
    
    self.yzmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.yzmBtn.frame = CGRectMake(LBVIEW_WIDTH1 * 0.05, LBVIEW_HEIGHT1 *0.09+15, LBVIEW_WIDTH1*0.9, LBVIEW_HEIGHT1*0.06);
    self.hqOn = [UIImage imageNamed:@"huoqu1.png"];
    self.hqOff = [UIImage imageNamed:@"huoqu2.png"];
    self.hqStatus = YES;
    [self.yzmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.yzmBtn addTarget:self action:@selector(click2:) forControlEvents:UIControlEventTouchUpInside];
    [self.yzmBtn setBackgroundColor:[UIColor redColor]];
    [self.yzmBtn setTitle:@"获取手机验证码" forState:UIControlStateNormal];
    self.yzmBtn.layer.cornerRadius=5;
    self.yzmBtn.clipsToBounds=YES;
    [_scrollView addSubview:self.yzmBtn];
    
    self.timeLimitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.yzmBtn.bounds.size.width, LBVIEW_HEIGHT1*0.06)];
    [self.timeLimitLabel setTextColor:[UIColor whiteColor]];
    [self.timeLimitLabel setTextAlignment:NSTextAlignmentCenter];
    [self.yzmBtn addSubview:self.timeLimitLabel];
    
    self.yzmTF = [[UITextField alloc] initWithFrame:CGRectMake(LBVIEW_WIDTH1* 0.05, LBVIEW_HEIGHT1 * 0.15+25, LBVIEW_WIDTH1*0.9, LBVIEW_HEIGHT1*0.06)];
    self.yzmTF.backgroundColor = [UIColor clearColor];
    self.yzmTF.textColor = [UIColor blackColor];
    [self.yzmTF setBorderStyle:UITextBorderStyleLine];
    [self.yzmTF.layer setBorderWidth:1];
    [self.yzmTF.layer setBorderColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1].CGColor];
    self.yzmTF.placeholder=@"验证码";
    self.yzmTF.KEYDOWN
    [_yzmTF KEYVOID];
    UIView * leftView1 = [[UIView alloc] initWithFrame:CGRectMake(10,0,10,LBVIEW_HEIGHT1*0.06)];
    leftView1.backgroundColor = [UIColor clearColor];
    _yzmTF.leftView = leftView1;
    _yzmTF.leftViewMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:self.yzmTF];
    
    
    self.pswTF = [[UITextField alloc] initWithFrame:CGRectMake(LBVIEW_WIDTH1*0.05, LBVIEW_HEIGHT1 * 0.23+25, LBVIEW_WIDTH1*0.9, LBVIEW_HEIGHT1*0.06)];
    self.pswTF.backgroundColor = [UIColor clearColor];
    [self.pswTF setBorderStyle:UITextBorderStyleLine];
    [self.pswTF.layer setBorderWidth:1];
    [self.pswTF.layer setBorderColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1].CGColor];
    self.pswTF.textColor = [UIColor blackColor];
    self.pswTF.placeholder=@"密码";
    self.pswTF.secureTextEntry=YES;
    self.pswTF.KEYDOWN
    [self.pswTF KEYVOID];
    UIView * leftView2 = [[UIView alloc] initWithFrame:CGRectMake(10,0,10,LBVIEW_HEIGHT1*0.06)];
    leftView2.backgroundColor = [UIColor clearColor];
    _pswTF.leftView = leftView2;
    _pswTF.leftViewMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:self.pswTF];
    
    self.psw2TF = [[UITextField alloc] initWithFrame:CGRectMake(LBVIEW_WIDTH1*0.05, LBVIEW_HEIGHT1 * 0.31+25, LBVIEW_WIDTH1*0.9, LBVIEW_HEIGHT1*0.06)];
    self.psw2TF.backgroundColor = [UIColor clearColor];
    [self.psw2TF setBorderStyle:UITextBorderStyleLine];
    [self.psw2TF.layer setBorderWidth:1];
    [self.psw2TF.layer setBorderColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1].CGColor];
    self.psw2TF.textColor = [UIColor blackColor];
    self.psw2TF.placeholder=@"确认密码";
    self.psw2TF.secureTextEntry=YES;
    self.psw2TF.KEYDOWN
    [self.psw2TF KEYVOID];
    UIView * leftView3 = [[UIView alloc] initWithFrame:CGRectMake(10,0,10,LBVIEW_HEIGHT1*0.06)];
    leftView3.backgroundColor = [UIColor clearColor];
    _psw2TF.leftView = leftView3;
    _psw2TF.leftViewMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:self.psw2TF];
    
    self.getBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.getBtn.frame = CGRectMake(LBVIEW_WIDTH1 * 0.05, LBVIEW_HEIGHT1*0.39+25, 24,24);
    self.getOff = [UIImage imageNamed:@"agreeG.png"];
    self.getOn = [UIImage imageNamed:@"agreeR.png"];
    self.getStatus = NO;
    [self.getBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.getBtn setBackgroundImage:self.getOff  forState:UIControlStateNormal];
    [_scrollView addSubview:self.getBtn];
    
    self.agreeL = [[UILabel alloc] init];
    self.agreeL.text = @"我已阅读并同意";
    self.agreeL.textAlignment=NSTextAlignmentRight;
    self.agreeL.textColor = [UIColor grayColor];
    self.agreeL.font = [UIFont systemFontOfSize:16];
    self.agreeL.frame = CGRectMake(LBVIEW_WIDTH1 * 0.10, LBVIEW_HEIGHT1*0.38+25, LBVIEW_WIDTH1*0.4, LBVIEW_HEIGHT1*0.05);
    [_scrollView addSubview:self.agreeL];
    
    
    UILabel*userProtocolLabel = [[UILabel alloc] init];
    userProtocolLabel.text = @"花集网用户协议";
    userProtocolLabel.textColor = [UIColor colorWithRed:37/255.0f green:119/255.0f blue:188/255.0f alpha:1];
    userProtocolLabel.font = [UIFont systemFontOfSize:16];
    userProtocolLabel.frame = CGRectMake(LBVIEW_WIDTH1*0.51, LBVIEW_HEIGHT1*0.38+25, LBVIEW_WIDTH1*0.4, LBVIEW_HEIGHT1*0.05);
    [_scrollView addSubview:userProtocolLabel];
    
    UIButton *userProtocol=[[UIButton alloc] initWithFrame:CGRectMake(LBVIEW_WIDTH1*0.52, LBVIEW_HEIGHT1*0.39+25, LBVIEW_WIDTH1*0.4, LBVIEW_HEIGHT1*0.05)];
    //[userProtocol addTarget:self action:@selector(userProtocolBtn) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:userProtocol];
    
    self.hozonBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //UIImage *hozonI = [UIImage imageNamed:@"zhuce.png"];
    //hozonI = [hozonI imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.hozonBtn.frame = CGRectMake(LBVIEW_WIDTH1 * 0.05, LBVIEW_HEIGHT1*0.46+25, LBVIEW_WIDTH1*0.9, LBVIEW_HEIGHT1/15);
    //[self.hozonBtn setImage:hozonI forState:UIControlStateNormal];
    [self.hozonBtn setBackgroundColor:[UIColor redColor]];
    [self.hozonBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.hozonBtn setTitle:@"注 册" forState:UIControlStateNormal];
    [self.hozonBtn addTarget:self action:@selector(goRegiseter) forControlEvents:UIControlEventTouchUpInside];
    self.hozonBtn.layer.cornerRadius=5;
    self.hozonBtn.clipsToBounds=YES;
    [_scrollView addSubview:self.hozonBtn];
    
    
}
- (void)keyDown {

    [self.phoneTF resignFirstResponder];
    [self.yzmTF resignFirstResponder];
    [self.pswTF resignFirstResponder];
    [self.psw2TF resignFirstResponder];

}
#pragma mark--------协议内容
//-(void)userProtocolBtn
//{
//    //协议阅读界面
//    _hJView=[[UIView alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1*0.1, LBVIEW_HEIGHT1*0.2, LBVIEW_WIDTH1*0.8, LBVIEW_HEIGHT1*0.6)];
//    _hJView.backgroundColor=[UIColor whiteColor];
//    _hJView.layer.cornerRadius=10;
//    _hJView.clipsToBounds=YES;
//    
//    
//    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, _hJView.frame.size.width-20,50)];
//    label.text=@"请自觉遵守花集用户协议";
//    label.textAlignment=NSTextAlignmentCenter;
//    label.font=[UIFont systemFontOfSize:20];
//    label.textColor=[UIColor redColor];
//    [_hJView addSubview:label];
//    
//    
//    UIButton*timeBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, LBVIEW_HEIGHT1*0.55+1, LBVIEW_WIDTH1*0.8, LBVIEW_HEIGHT1*0.05-1)];
//    [timeBtn setTitle:@"确定" forState:UIControlStateNormal];
//    [timeBtn setTintColor:[UIColor blackColor]];
//    [timeBtn setBackgroundColor:[UIColor redColor]];
//    [timeBtn addTarget:self action:@selector(accomplishReadBtn) forControlEvents:UIControlEventTouchUpInside];
//    [_hJView addSubview:timeBtn];
//    
//    
//       
//    _shadowView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    _shadowView.backgroundColor=[UIColor darkGrayColor];
//    _shadowView.alpha=0.9;
//    
//    //找window
//    UIWindow *window=[[UIApplication sharedApplication]keyWindow];
//    [window addSubview:_shadowView];
//    [_shadowView addSubview:_hJView];
//    
//}
//-(void)accomplishReadBtn
//{
//    [_shadowView removeFromSuperview];
//    
//}


- (void)click:(id)sender
{
    if (self.getStatus == YES) {
        [self.getBtn setBackgroundImage:self.getOff forState:UIControlStateNormal];
    } else {
        [self.getBtn setBackgroundImage:self.getOn forState:UIControlStateNormal];
    }
    self.getStatus = !self.getStatus;
}

- (void)click2:(id)sender
{
    if (_phoneTF.text.length!=11) {
        [self alert:@"手机号码格式错误" with:1];
        return;
    }

    if (self.hqStatus == NO) {
        
        return;
        //[self.yzmBtn setBackgroundImage:self.hqOn forState:UIControlStateNormal];
        //[self.yzmBtn setBackgroundColor:[UIColor redColor]];
    } else
    {
        
        [HttpEngine checkUserPhone:_phoneTF.text with:^(NSString *existe)
        {
            NSString*str=existe;
            if (![str isEqualToString:@"true"])
            {
                
                self.hqStatus = NO;
                
                [self.yzmBtn setTitle:@"" forState:UIControlStateNormal];
                [self.yzmBtn setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]];
                [BWCommon verificationCode:^{
                    [self.yzmBtn setBackgroundColor:[UIColor redColor]];
                    [self.yzmBtn setTitle:@"获取手机验证码" forState:UIControlStateNormal];
                    self.hqStatus = YES;
                    [self.timeLimitLabel setText:@""];
                } blockNo:^(id time) {
                    
                    [self.timeLimitLabel setText:[NSString stringWithFormat:@"%@秒后重新获取验证码",time]];
                }];
            
                //TODO 发送验证码
                [HttpEngine sendMessageMoblie:_phoneTF.text withKind:1];
            }
            else
            {
                [self alert:@"该用户已存在" with:1];
            }
            
        }];
        
        
        //[self.yzmBtn setBackgroundImage:self.hqOff forState:UIControlStateNormal];
    }
    //self.hqStatus = !self.hqStatus;
}
//去注册
-(void)goRegiseter
{

        if ([_pswTF.text isEqualToString:@""]||[_phoneTF.text isEqualToString:@""]||[_yzmTF.text isEqualToString:@""])
        {
            [self alert:@"请完善信息" with:1];
            return;
        }
       else
       {
           if(_pswTF.text.length<6)
           {
               [self alert:@"密码过于简单" with:1];
               return;
           }
           if(![_pswTF.text isEqualToString:_psw2TF.text])
           {
               [self alert:@"密码不一致" with:1];
               return;
           }
           NSString*str=[[NSUserDefaults standardUserDefaults]objectForKey:@"TEXTNUM"];
           if (![_yzmTF.text isEqualToString:str])
           {
               [self alert:@"验证码错误" with:1];
               return;
           }
       }
    
    if(self.getStatus==NO){
        [self alert:@"请先同意《花集网用户协议》" with:1];
        return;
    }
    
    [HttpEngine registerRequestPassword:_pswTF.text withMobile:_phoneTF.text withRegIp:@"" withFlorist:@"1" complete:^(NSString *fail) {
        if ([fail isEqualToString:@"true"])
        {
            [self alert:@"注册成功" with:2];
            
        }
        else
        {
            [self alert:@"注册失败" with:1];
        }
        
    }];
   
}
-(void)alert:(NSString*)str with:(int)tag;
{
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction*defaultAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action)
                                 {
                                     if (tag==2)
                                     {
                                        [self dismissViewControllerAnimated:YES completion:nil];
                                     }
               
                                 }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
