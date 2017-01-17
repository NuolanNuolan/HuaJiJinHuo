//
//  CooperateViewController.m
//  HJApp
//
//  Created by Bruce He on 15/11/2.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "CooperateViewController.h"
#import "HttpEngine.h"

@interface CooperateViewController ()

@end
#define LBVIEW_WIDTH1 [UIScreen mainScreen].bounds.size.width
#define LBVIEW_HEIGHT1 [UIScreen mainScreen].bounds.size.height
@implementation CooperateViewController

- (void)viewWillDisappear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor = RGB(42, 125, 227);
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title=@"商务合作";
    
    [self showPage];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

}

-(void)showPage
{
    UIScrollView*scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, LBVIEW_WIDTH1, LBVIEW_HEIGHT1)];
    scrollView.contentSize=CGSizeMake(LBVIEW_WIDTH1, LBVIEW_HEIGHT1+420);
    [self.view addSubview:scrollView];
    
    NSArray*nameArray=[[NSArray alloc]initWithObjects:@"姓名＊",@"手机号＊",@"E-Mail＊",@"单位名称＊", nil];
    NSArray*fieldArray=[[NSArray alloc]initWithObjects:@"请输入您的姓名",@"请输入您的手机号码",@"请输入您的邮箱地址",@"请输入您所在单位名称", nil];
    for (int i=0; i<4; i++)
    {
        UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 20+i*100, 100, 30)];
        nameLabel.text=nameArray[i];
        nameLabel.font=[UIFont systemFontOfSize:14];
        [scrollView addSubview:nameLabel];
        
        UITextField*field=[[UITextField alloc]initWithFrame:CGRectMake(20, 60+i*100, LBVIEW_WIDTH1-40, 50)];
        //field.borderStyle=UITextBorderStyleLine;
        field.layer.cornerRadius=5;
        field.layer.borderWidth=1;
        field.layer.borderColor=[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1].CGColor;
        field.clipsToBounds=YES;
        field.placeholder=fieldArray[i];
        field.font=[UIFont systemFontOfSize:14];
        field.tag=i+1;
        field.returnKeyType = UIReturnKeyDone;
        field.clearButtonMode = UITextFieldViewModeAlways;
        
        UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(10,0,10,50)];
        leftView.backgroundColor = [UIColor clearColor];
        field.leftView = leftView;
        field.leftViewMode = UITextFieldViewModeAlways;
        [field addTarget:self action:@selector(keyDown) forControlEvents:UIControlEventEditingDidEndOnExit];
        
        [scrollView addSubview:field];
    }

    
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(10, 130+3*100, 100, 30)];
    label.text=@"其它信息＊";
    label.font=[UIFont systemFontOfSize:14];
    [scrollView addSubview:label];
    
    UITextView*tView=[[UITextView alloc]initWithFrame:CGRectMake(20, 170+3*100, LBVIEW_WIDTH1-40, LBVIEW_HEIGHT1/5)];
    tView.layer.borderColor =[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1].CGColor;
    tView.layer.borderWidth =1.0;
    tView.layer.cornerRadius =5.0;
    tView.tag=5;
    tView.font=[UIFont systemFontOfSize:14];
    [scrollView addSubview:tView];
    
    UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(20,490+LBVIEW_HEIGHT1/5, LBVIEW_WIDTH1-40, 40)];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    btn.layer.cornerRadius=5;
    btn.clipsToBounds=YES;
    [btn addTarget:self action:@selector(comit) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    [scrollView addSubview:btn];
    

}
-(void)comit
{
    UITextField*field1=(UITextField*)[self.view viewWithTag:1];
    UITextField*field2=(UITextField*)[self.view viewWithTag:2];
    UITextField*field3=(UITextField*)[self.view viewWithTag:3];
    UITextField*field4=(UITextField*)[self.view viewWithTag:4];
    UITextView*field5=(UITextView*)[self.view viewWithTag:5];

    if ([field1.text isEqualToString:@""]||[field2.text isEqualToString:@""]||[field3.text isEqualToString:@""]||[field4.text isEqualToString:@""]||[field5.text isEqualToString:@""])
    {
         [self alert:@"请完善信息" with:1];
        return;
    }
    
    [HttpEngine cooperateName:field1.text withMoblie:field2.text withEmail:field3.text withDanWei:field4.text withOther:field5.text withIp:@"192.168.33.249" complete:^(NSString *error) {
        if (error) {
            [self alert:error with:2];
        } else {
        [self alert:@"反馈成功" with:2];
        }
    }];
    
}
-(void)alert:(NSString*)str with:(int)tag
{
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction*defaultAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action)
                                 {
                                     if (tag==2)
                                     {
                                      [self.navigationController popViewControllerAnimated:YES];
                                     }
                                 }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)keyDown
{
    [self.view endEditing:YES];
}
-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}
@end
