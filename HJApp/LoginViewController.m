//
//  LoginViewController.m
//  HJApp
//
//  Created by Bruce He on 15/11/2.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "LoginViewController.h"
#import "FlashViewController.h"
#import "HttpEngine.h"
#import "RegisterViewController.h"
#import "MyHJViewController.h"
#import "ForgetPasswordViewController.h"


//宏定义宽高
#define LBVIEW_WIDTH1 [UIScreen mainScreen].bounds.size.width
#define LBVIEW_HEIGHT1 [UIScreen mainScreen].bounds.size.height

@interface LoginViewController ()

@property (nonatomic,strong) UIScrollView*scrollView;
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor ]];
    [self.navigationController.navigationBar setBarTintColor:RGB(42, 125, 227)];
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(closeTouched:)];
    self.navigationItem.leftBarButtonItem = closeItem;
    
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent=NO;
    self.title=@"登录";
    
    self.view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, LBVIEW_WIDTH1, LBVIEW_HEIGHT1)];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self createUI];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapKeyDown)];
    [self.view addGestureRecognizer:tap];
}

- (void)createUI {

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, LBVIEW_WIDTH1, LBVIEW_HEIGHT1)];
    _scrollView.contentSize = CGSizeMake(LBVIEW_WIDTH1, LBVIEW_HEIGHT1+60);
    [self.view addSubview:_scrollView];
    
    //输入框和登陆注册按钮
    NSArray*labelNameArray=[[NSArray alloc]initWithObjects:@"账户名",@"登录密码", nil];
    NSArray*tfNameArray=[[NSArray alloc]initWithObjects:@"请输入帐号",@"请输入密码",nil];
    NSArray*btnNameArray=[[NSArray alloc]initWithObjects:@"登录",@"注册" ,nil];
    for (int i=0; i<2; i++)
    {
        
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(20, 40+i*(LBVIEW_HEIGHT1/15.0), LBVIEW_WIDTH1-40, LBVIEW_HEIGHT1/15.0)];
        view.layer.borderColor=[UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1].CGColor;
        view.layer.borderWidth=1;
        [_scrollView addSubview:view];
        
        
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, LBVIEW_WIDTH1/4.5, LBVIEW_HEIGHT1/15.0)];
        label.text=labelNameArray[i];
        label.font=[UIFont systemFontOfSize:16];
        label.textColor=[UIColor blackColor];
        [view addSubview:label];
        
        UITextField*field=[[UITextField alloc]initWithFrame:CGRectMake(20+LBVIEW_WIDTH1/4.5, 0, view.frame.size.width-label.frame.size.width-20, LBVIEW_HEIGHT1/15.0)];
        if (i==0)
        {
            NSString*nameStr=[[NSUserDefaults standardUserDefaults]objectForKey:@"NAME"];
            field.text=nameStr;
        }
        field.placeholder=tfNameArray[i];
        field.font=[UIFont systemFontOfSize:16];
        field.clearsOnBeginEditing=YES;
        if (i==1)
        {
            field.secureTextEntry=YES;
        }
        if(i==0)
        {
            field.clearButtonMode=UITextFieldViewModeAlways;
        }
        field.returnKeyType = UIReturnKeyDone;
        field.tag=i+10;
        [field addTarget:self action:@selector(keyDown:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [view addSubview:field];
        //登陆注册按钮
        UIButton*lgBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 40+2*label.frame.size.height+10+30+i*(LBVIEW_HEIGHT1/15.0+10), LBVIEW_WIDTH1-40, LBVIEW_HEIGHT1/15.0)];
        if (i==0)
        {
            [lgBtn setBackgroundColor:[UIColor redColor]];
        }
        else
        {
            [lgBtn setBackgroundColor:[UIColor grayColor]];
        }
        lgBtn.tag=i;
        lgBtn.layer.cornerRadius=7;
        lgBtn.clipsToBounds=YES;
        lgBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        [lgBtn setTitle:btnNameArray[i] forState:UIControlStateNormal];
        [lgBtn addTarget:self action:@selector(lgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:lgBtn];
        
    }
    //忘记密码按钮
    UIButton*disBtn=[[UIButton alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-LBVIEW_WIDTH1/4.0-10, 40+2*LBVIEW_HEIGHT1/15.0+10, LBVIEW_WIDTH1/4.0, LBVIEW_WIDTH1/15.0)];
    [disBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [disBtn addTarget:self action:@selector(disPassword) forControlEvents:UIControlEventTouchUpInside];
    [disBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [disBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_scrollView addSubview:disBtn];

}

- (void)keyDown:(UITextField *)TF {

    [TF resignFirstResponder];
}
- (void)tapKeyDown {
    UITextField *tf1 = [self.view viewWithTag:10];
    UITextField *tf2 = [self.view viewWithTag:11];
    [tf1 resignFirstResponder];
    [tf2 resignFirstResponder];
}
//忘记密码
-(void)disPassword
{
    ForgetPasswordViewController*forgetVC=[[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:forgetVC animated:NO];

}
- (void) closeTouched:(UIBarButtonItem *) sender{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
//登陆注册按钮
-(void)lgBtnClick:(UIButton*)sender
{
    UITextField*tfName=(UITextField*)[self.view viewWithTag:10];
    UITextField*tfPas=(UITextField*)[self.view viewWithTag:11];
    
    //登陆注册
    if (sender.tag==0)
    {
        //判断是否为空
        if ([tfName.text isEqualToString:@""])
        {
            [self alert:@"帐号不能为空"];
            return;
        }
        if ([tfPas.text isEqualToString:@""])
        {
            [self alert:@"密码不能为空"];
            return;
        }

        //发送登陆请求
        [HttpEngine loginRequest:tfName.text with:tfPas.text complete:^(NSString *fail)
         {
             if (fail) {
                 [self alert:fail];
             }
             else
             {
                 //原因：这个请求会把用户ID存到本地，由于异步执行可能还没将ID存到本地，就已经模态消失到新的页面，在新的页面会因为没有ID得不到数据而崩溃
                 //方案：等执行结束后模态消失
                 [HttpEngine getConsumerData:^(NSDictionary*dataDic) {
                     
                 [self dismissViewControllerAnimated:YES completion:nil];
                     
                 }];
             }
         }
         ];
    }
    //注册
    else
    {
        RegisterViewController*registerVC=[[RegisterViewController alloc]init];
        [self.navigationController pushViewController:registerVC animated:YES];
    }
}
- (void)alert:(NSString *)alertStr {
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:alertStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    [alert addAction:otherAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
