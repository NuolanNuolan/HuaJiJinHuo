//
//  Exchange ViewController.m
//  HJApp
//
//  Created by 袁联林 on 16/9/6.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "Exchange ViewController.h"
#import "KJAreaPickerView.h"
#import "KJLocation.h"
@interface Exchange_ViewController ()<UITextFieldDelegate,KJAreaPickerViewDelegate>
@property (nonatomic, strong) UITextField *userNameTF;
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *proconTF;
@property (nonatomic, strong) UITextField *adreTF;
@property (nonatomic, strong) KJAreaPickerView *areaPickerView;
@end
//宏定义宽高
#define VIEW_WIDTH self.view.bounds.size.width
#define VIEW_HEIGHT self.view.bounds.size.height

#define LBVIEW_WIDTH1 [UIScreen mainScreen].bounds.size.width
#define LBVIEW_HEIGHT1 [UIScreen mainScreen].bounds.size.height
@implementation Exchange_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    // Do any additional setup after loading the view.
}

-(void)CreateUI
{

    self.view.backgroundColor = [UIColor whiteColor];
    self.title=@"信息确认";
    
    UIView *userV = [[UIView alloc] initWithFrame:CGRectMake(LBVIEW_WIDTH1 / 17, 30, LBVIEW_WIDTH1 / 1.1, LBVIEW_HEIGHT1 / 17)];
    // userV.backgroundColor = [UIColor redColor];
    userV.layer.borderColor = [[UIColor grayColor] CGColor];
    userV.layer.borderWidth = 1;
    userV.layer.cornerRadius=5;
    userV.clipsToBounds=YES;
    [self.view addSubview:userV];
    
    UILabel*userLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, LBVIEW_HEIGHT1 * 0.001, LBVIEW_WIDTH1 / 4+4, LBVIEW_HEIGHT1 / 17)];
    userLabel.text=@"  收货人";
    userLabel.font=[UIFont systemFontOfSize:14];
    userLabel.textColor=[UIColor grayColor];
    //userLabel.font=[UIFont systemFontOfSize:14];
    [userV addSubview:userLabel];
    
    UILabel*line1=[[UILabel alloc]initWithFrame:CGRectMake( LBVIEW_WIDTH1 / 4+4, 3, 1,  LBVIEW_HEIGHT1 / 17-6)];
    line1.backgroundColor=[UIColor lightGrayColor];
    [userV addSubview:line1];
    
    self.userNameTF = [[UITextField alloc] initWithFrame: CGRectMake(LBVIEW_WIDTH1 / 4+10, LBVIEW_HEIGHT1 * 0.001, LBVIEW_WIDTH1 / 1.6, LBVIEW_HEIGHT1 / 17)];
    self.userNameTF.tag=100;
    self.userNameTF.backgroundColor = [UIColor clearColor];
    self.userNameTF.borderStyle = UITextBorderStyleNone;
    self.userNameTF.textColor = [UIColor blackColor];
    self.userNameTF.font=[UIFont systemFontOfSize:14];
    UIView * leftView1= [[UIView alloc] initWithFrame:CGRectMake(10,0,10,LBVIEW_HEIGHT1 / 17)];
    leftView1.backgroundColor = [UIColor clearColor];
    self.userNameTF.leftView = leftView1;
    self.userNameTF.leftViewMode = UITextFieldViewModeAlways;
    
    [userV addSubview:self.userNameTF];
    
    UIView *phoneV = [[UIView alloc] initWithFrame:CGRectMake(LBVIEW_WIDTH1 / 17, LBVIEW_HEIGHT1 / 17+50, LBVIEW_WIDTH1 / 1.1, LBVIEW_HEIGHT1 / 17)];
    //phoneV.backgroundColor = [UIColor redColor];
    phoneV.layer.borderColor = [[UIColor grayColor] CGColor];
    phoneV.layer.borderWidth = 1;
    phoneV.layer.cornerRadius=5;
    phoneV.clipsToBounds=YES;
    [self.view addSubview:phoneV];
    
    
    UILabel*phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, LBVIEW_HEIGHT1 * 0.001, LBVIEW_WIDTH1 / 4+4, LBVIEW_HEIGHT1 / 17)];
    phoneLabel.text=@"  手机";
    phoneLabel.font=[UIFont systemFontOfSize:14];
    phoneLabel.textColor=[UIColor grayColor];
    // phoneLabel.font=[UIFont systemFontOfSize:14];
    [phoneV addSubview:phoneLabel];
    
    UILabel*line2=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1 / 4+4, 3, 1,  LBVIEW_HEIGHT1 / 17-6)];
    line2.backgroundColor=[UIColor lightGrayColor];
    [phoneV addSubview:line2];
    
    self.phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(LBVIEW_WIDTH1 / 4+10, LBVIEW_HEIGHT1 * 0.001, LBVIEW_WIDTH1 / 1.6, LBVIEW_HEIGHT1 / 17)];
    self.phoneTF.tag=101;
    self.phoneTF.backgroundColor = [UIColor clearColor];
    self.phoneTF.borderStyle = UITextBorderStyleNone;
    self.phoneTF.textColor = [UIColor blackColor];
    self.phoneTF.font=[UIFont systemFontOfSize:14];
    UIView * leftView2= [[UIView alloc] initWithFrame:CGRectMake(10,0,10,LBVIEW_HEIGHT1 / 17)];
    leftView2.backgroundColor = [UIColor clearColor];
    self.phoneTF.leftView = leftView2;
    self.phoneTF.leftViewMode = UITextFieldViewModeAlways;
    [phoneV addSubview:self.phoneTF];
    
    UIView *proconV = [[UIView alloc] initWithFrame:CGRectMake(LBVIEW_WIDTH1 / 17, 2*LBVIEW_HEIGHT1 / 17+70, LBVIEW_WIDTH1 / 1.1, LBVIEW_HEIGHT1 / 17)];
    proconV.layer.borderColor = [[UIColor grayColor] CGColor];
    proconV.layer.borderWidth = 1;
    proconV.layer.cornerRadius=5;
    proconV.clipsToBounds=YES;
    [self.view addSubview:proconV];
    
    UILabel*proconLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, LBVIEW_HEIGHT1 * 0.001, LBVIEW_WIDTH1 / 4+4, LBVIEW_HEIGHT1 / 17)];
    proconLabel.text=@"  所在地区";
    proconLabel.font=[UIFont systemFontOfSize:14];
    proconLabel.textColor=[UIColor grayColor];
    //proconLabel.font=[UIFont systemFontOfSize:14];
    [proconV addSubview:proconLabel];
    
    UILabel*line3=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1 / 4+4, 3, 1,  LBVIEW_HEIGHT1 / 17-6)];
    line3.backgroundColor=[UIColor lightGrayColor];
    [proconV addSubview:line3];
    
    self.proconTF = [[UITextField alloc] initWithFrame:CGRectMake(LBVIEW_WIDTH1 /4+10, LBVIEW_HEIGHT1 * 0.001, LBVIEW_WIDTH1 / 1.6, LBVIEW_HEIGHT1 / 17)];
    self.proconTF.tag=102;
    self.proconTF.backgroundColor = [UIColor clearColor];
    self.proconTF.borderStyle = UITextBorderStyleNone;
    self.proconTF.textColor = [UIColor blackColor];
    self.proconTF.font=[UIFont systemFontOfSize:14];
    UIView * leftView3= [[UIView alloc] initWithFrame:CGRectMake(10,0,10,LBVIEW_HEIGHT1 / 17)];
    leftView3.backgroundColor = [UIColor clearColor];
    self.proconTF.leftView = leftView3;
    self.proconTF.leftViewMode = UITextFieldViewModeAlways;
    self.proconTF.delegate=self;
    
    [proconV addSubview:self.proconTF];
    
    UIView *adreV = [[UIView alloc] init];
    adreV.frame = CGRectMake(LBVIEW_WIDTH1 / 17, 3*LBVIEW_HEIGHT1 / 17+90, LBVIEW_WIDTH1 / 1.1, LBVIEW_HEIGHT1 / 17);
    adreV.layer.borderColor = [[UIColor grayColor] CGColor];
    adreV.layer.borderWidth = 1;
    adreV.layer.cornerRadius=5;
    adreV.clipsToBounds=YES;
    [self.view addSubview:adreV];
    
    
    UILabel*adreLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, LBVIEW_HEIGHT1 * 0.001, LBVIEW_WIDTH1 / 4+4, LBVIEW_HEIGHT1 / 17)];
    adreLabel.text=@"  详细地址";
    adreLabel.font=[UIFont systemFontOfSize:14];
    adreLabel.textColor=[UIColor grayColor];
    // adreLabel.font=[UIFont systemFontOfSize:14];
    [adreV addSubview:adreLabel];
    
    UILabel*line4=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1 / 4+4, 3, 1,  LBVIEW_HEIGHT1 / 17-6)];
    line4.backgroundColor=[UIColor lightGrayColor];
    [adreV addSubview:line4];
    
    self.adreTF = [[UITextField alloc] initWithFrame:CGRectMake(LBVIEW_WIDTH1 / 4+10, LBVIEW_HEIGHT1 * 0.001, LBVIEW_WIDTH1 / 1.6, LBVIEW_HEIGHT1 / 17)];
    self.adreTF.tag=103;
    self.adreTF.backgroundColor = [UIColor clearColor];
    self.adreTF.borderStyle = UITextBorderStyleNone;
    self.adreTF.textColor = [UIColor blackColor];
    self.adreTF.font=[UIFont systemFontOfSize:14];
    UIView * leftView4= [[UIView alloc] initWithFrame:CGRectMake(10,0,10,LBVIEW_HEIGHT1 / 17)];
    leftView4.backgroundColor = [UIColor clearColor];
    self.adreTF.leftView = leftView4;
    self.adreTF.leftViewMode = UITextFieldViewModeAlways;
    [adreV addSubview:self.adreTF];
    
    UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1 / 17, 4*LBVIEW_HEIGHT1 / 17+130, LBVIEW_WIDTH1 / 1.1,40)];
    [btn setTitle:@"确认兑换" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    btn.layer.cornerRadius=7;
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    btn.clipsToBounds=YES;
    
    [btn addTarget:self action:@selector(saveDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}
-(void)saveDetail
{

    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i=0; i<4; i++) {
        UITextField *test = [self.view viewWithTag:100+i];
        if ([test.text isEqualToString:@""]) {
            [MBProgressHUD showError:@"请填写完整信息"];
            return;
        }
        else
        {
            [arr addObject:test.text];
            
        }
    }
    //数据完整开始请求
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInteger:[_model.Goodsid intValue]],@"prodid",[NSNumber numberWithInteger:_count],@"number",arr[0],@"name",arr[1],@"mobile",[arr[2] stringByAppendingString:arr[3]],@"addr", nil];
    [HttpEngine SeedsGoods:dic withcompletion:^(NSString*str) {
        if ([str isEqualToString:@"succ"]) {
            [MBProgressHUD showSuccess:@"兑换成功,请等待发货"];
            //返回
             [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        }else
        {
        
            [MBProgressHUD showError:str];
        }
    }];
    
}
#pragma mark - UITextFieldDelegate的代理
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    for(UITextField *field in self.view.subviews)
    {
        
        if([field isKindOfClass:[UITextField class]])
        {
            
            [field resignFirstResponder];
            
        }
    }
    // 1, 先清空AreaPickerView
    [self cancelLocatePicker];
    // 2，再初始化AreaPickerView
    self.areaPickerView = [KJAreaPickerView areaPickerViewWithDelegate:self];
    // 3，显示
    [self.areaPickerView showInView:self.view];
    return NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for(UITextField *field in self.view.subviews)
    {
        
        if([field isKindOfClass:[UITextField class]])
        {
            
            [field resignFirstResponder];
            
        }
    }
    [super touchesBegan:touches withEvent:event];
    // 取消areaPickerView
    [self cancelLocatePicker];
}
-(void)cancelLocatePicker
{
    [self.areaPickerView cancelPicker];
    self.areaPickerView.delegate = nil;
    self.areaPickerView = nil;
}
#pragma mark - KJAreaPickerViewDelegate的代理
- (void)pickerDidChangeStatus:(KJAreaPickerView *)picker
{
    self.proconTF.text = [NSString stringWithFormat:@"%@ %@ %@",picker.locate.state,picker.locate.city,picker.locate.district];
    
}
@end
