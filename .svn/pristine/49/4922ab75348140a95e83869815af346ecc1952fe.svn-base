//
//  IdeaBackViewController.m
//  HJApp
//
//  Created by Bruce He on 15/11/2.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "IdeaBackViewController.h"
#import "HttpEngine.h"

@interface IdeaBackViewController ()
@property(nonatomic,copy)NSString*mobile;
@property(nonatomic,strong)UITextView*tView;
@property(nonatomic,strong)UIScrollView*scrollView;
//@property(nonatomic,copy)NSString*nameTF;
//@property(nonatomic,copy)NSString*mobileTF;
//@property(nonatomic,copy)NSString*contentTF;
@end

@implementation IdeaBackViewController
#define LBVIEW_WIDTH1 [UIScreen mainScreen].bounds.size.width
#define LBVIEW_HEIGHT1 [UIScreen mainScreen].bounds.size.height

- (void)viewWillDisappear:(BOOL)animated
{

    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString*str=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    if(str==NULL)
    {
        UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请登陆后反馈" preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction*defaultAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action)
                                     {
                                  [self.navigationController popViewControllerAnimated:YES];
                                     }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    
    }
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor = RGB(42, 125, 227);
    self.navigationController.navigationBar.translucent=NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title=@"意见反馈";
    
    NSString*strId=[[NSUserDefaults standardUserDefaults]objectForKey:@"ID"];
    [HttpEngine getConsumerDetailData:strId completion:^(NSArray *dataArray)
    {
        ConsumerDetail*cons=dataArray[0];
        _mobile=cons.mobile;
        [self showPage];
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}
-(void)showPage
{
    UIScrollView*scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, LBVIEW_WIDTH1, LBVIEW_HEIGHT1)];
    scrollView.contentSize=CGSizeMake(LBVIEW_WIDTH1, LBVIEW_HEIGHT1+256);
    [self.view addSubview:scrollView];
    
    NSArray*nameArray=[[NSArray alloc]initWithObjects:@"姓名",@"手机号", nil];
    for (int i=0; i<2; i++)
    {
        UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10+i*120, 100, 30)];
        nameLabel.text=nameArray[i];
        nameLabel.font=[UIFont systemFontOfSize:14];
        [scrollView addSubview:nameLabel];
        
        UITextField*field=[[UITextField alloc]initWithFrame:CGRectMake(20, 60+i*120, LBVIEW_WIDTH1-40, 50)];
        field.layer.cornerRadius=5;
        field.clipsToBounds=YES;
        field.clearButtonMode = UITextFieldViewModeAlways;
        field.returnKeyType = UIReturnKeyDone;
        field.layer.borderColor=[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1].CGColor;
        
        UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(10,0,10,LBVIEW_HEIGHT1/14)];
        leftView.backgroundColor = [UIColor clearColor];
        field.leftView = leftView;
        field.leftViewMode = UITextFieldViewModeAlways;
        field.font=[UIFont systemFontOfSize:14];
        field.layer.borderWidth=1;
        [field addTarget:self action:@selector(keyDown) forControlEvents:UIControlEventEditingDidEndOnExit];
        
        //field.borderStyle=UITextBorderStyleLine;
        if (i==0)
        {
            field.placeholder=@"请输入您的姓名";
            field.tag=1;
        }
        else
        {
            field.text=_mobile;
            field.tag=2;
        }
        [scrollView addSubview:field];
    }

    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(10,270, 100, 30)];
    label.text=@"详细内容";
    label.font=[UIFont systemFontOfSize:14];
    [scrollView addSubview:label];
    
    _tView=[[UITextView alloc]initWithFrame:CGRectMake(20, 320, LBVIEW_WIDTH1-40, LBVIEW_HEIGHT1/5)];
    _tView.layer.borderColor =[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1].CGColor;
    _tView.layer.borderWidth =1.0;
    _tView.layer.cornerRadius =5.0;
    _tView.tag=3;
    //_tView.delegate=self;
    _tView.font=[UIFont systemFontOfSize:14];
    
    [scrollView addSubview:_tView];
    
    UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(20,350+ LBVIEW_HEIGHT1/5, LBVIEW_WIDTH1-40, 40)];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    btn.layer.cornerRadius=5;
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    btn.clipsToBounds=YES;
    [btn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn];
}

-(void)submit:(UIButton *) sender
{
    UITextField*field1=(UITextField*)[self.view viewWithTag:1];
    UITextField*field2=(UITextField*)[self.view viewWithTag:2];
    UITextView*tfView=(UITextView*)[self.view viewWithTag:3];
    
    if ([field1.text isEqualToString:@""]||[field2.text isEqualToString:@""]||[tfView.text isEqualToString:@""]) {
        [self alert:@"请完善信息"];
        return;
    }
    [HttpEngine ideaFeedBackName:field1.text withMoblie:field2.text withContent:tfView.text complete:^(NSString *error) {
        if (error) {
            [self alert:error];
        } else {
            [self alert:@"反馈成功"];
        }
    }];
}
- (void)alert:(NSString *)str {
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction*defaultAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action)
                                 {
                                     [self.navigationController popViewControllerAnimated:YES];
                                 }];
    [alert addAction:defaultAction];
    [alert addAction:cancel];
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
