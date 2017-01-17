//
//  NewAdViewController.m
//  HJApp
//
//  Created by Bruce He on 15/11/6.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "NewAdViewController.h"
#import "HttpEngine.h"
#import "GroupTableModel.h"

@interface NewAdViewController ()
@property (nonatomic, strong) UITextField *userNameTF;
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *proconTF;
@property (nonatomic, strong) UITextField *adreTF;
@property(nonatomic,strong)HZAreaPickerView*locatePicker;
@property (nonatomic,copy) NSString *areaValue, *cityValue;

-(void)cancelLocatePicker;

@end


//宏定义宽高
#define VIEW_WIDTH self.view.bounds.size.width
#define VIEW_HEIGHT self.view.bounds.size.height

#define LBVIEW_WIDTH1 [UIScreen mainScreen].bounds.size.width
#define LBVIEW_HEIGHT1 [UIScreen mainScreen].bounds.size.height

@implementation NewAdViewController

@synthesize areaValue=_areaValue, cityValue=_cityValue;
@synthesize locatePicker=_locatePicker;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"新建地址";
    self.navigationController.navigationBar.translucent =NO;
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] init];
    [tapGes addTarget:self action:@selector(keybordHide:)];
    
    tapGes.cancelsTouchesInView = NO;
    
    [self.view addGestureRecognizer:tapGes];
    
    
    [self newadressPage];
}

- (void)keybordHide:(UITapGestureRecognizer *)tap
{
    [self.userNameTF resignFirstResponder];
    [self.phoneTF resignFirstResponder];
    [self.proconTF resignFirstResponder];
    [self.adreTF resignFirstResponder];
}


- (void)newadressPage
{
    
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
    self.userNameTF.backgroundColor = [UIColor clearColor];
    self.userNameTF.borderStyle = UITextBorderStyleNone;
    self.userNameTF.textColor = [UIColor blackColor];
    self.userNameTF.text=_userName;
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
    self.phoneTF.backgroundColor = [UIColor clearColor];
    self.phoneTF.borderStyle = UITextBorderStyleNone;
    self.phoneTF.textColor = [UIColor blackColor];
    self.phoneTF.text=_phone;
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
    self.proconTF.backgroundColor = [UIColor clearColor];
    self.proconTF.borderStyle = UITextBorderStyleNone;
    self.proconTF.textColor = [UIColor blackColor];
    self.proconTF.text=_procon;
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
    self.adreTF.backgroundColor = [UIColor clearColor];
    self.adreTF.borderStyle = UITextBorderStyleNone;
    self.adreTF.textColor = [UIColor blackColor];
    self.adreTF.text=_adre;
    self.adreTF.font=[UIFont systemFontOfSize:14];
    UIView * leftView4= [[UIView alloc] initWithFrame:CGRectMake(10,0,10,LBVIEW_HEIGHT1 / 17)];
    leftView4.backgroundColor = [UIColor clearColor];
    self.adreTF.leftView = leftView4;
    self.adreTF.leftViewMode = UITextFieldViewModeAlways;
    [adreV addSubview:self.adreTF];
    
    UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1 / 17, 4*LBVIEW_HEIGHT1 / 17+130, LBVIEW_WIDTH1 / 1.1,40)];
    //[btn setImage:[UIImage imageNamed:@"hozon.png"] forState:UIControlStateNormal];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    btn.layer.cornerRadius=7;
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    btn.clipsToBounds=YES;

    [btn addTarget:self action:@selector(saveDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

//初始化tf值
-(void)setAreaValue:(NSString *)areaValue
{
    if (![_areaValue isEqualToString:areaValue]) {
        _areaValue =areaValue;
        self.proconTF.text = areaValue;
    }
}
#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        self.areaValue = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
    } else{
        self.cityValue = [NSString stringWithFormat:@"%@ %@", picker.locate.state, picker.locate.city];
    }
}

-(NSArray *)areaPickerData:(HZAreaPickerView *)picker
{
    NSArray *data;
    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        data = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
    } else{
        data = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];

    }
    return data;
}

-(void)cancelLocatePicker
{
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker= nil;
}


#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.proconTF]) {
        [self cancelLocatePicker];
        self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict
                                                        withDelegate:self
                                                       andDatasource:self];
        [self.locatePicker showInView:self.view];
    }
    return NO;
}

//点击其它取消
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self cancelLocatePicker];
}



-(void)saveDetail
{
    //consignee，phone_mob，province，city，town，address
    
    if ([_userNameTF.text isEqualToString:@""]||[_phoneTF.text isEqualToString:@""]||[_proconTF.text isEqualToString:@""]||[_adreTF.text isEqualToString:@""])
    {
        UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请完善信息" preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction*defaultAction=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                     {
                                     }];
        UIAlertAction*cancal=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                              {
                              }];
        [alert addAction:defaultAction];
        [alert addAction:cancal];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if ([_proconTF.text isEqualToString:@""])
    {
        return;
    }
    
    NSArray*array=[_proconTF.text componentsSeparatedByString:@" "];
    
    NSString*province;
    NSString*city;
    NSString*town;
    //省
    NSMutableArray*idArray=[GroupTableModel getAllFromMenuTable:array[0]];
    
    if (idArray.count!=0)
    {
    AreaModel*area=idArray[0];
   // MYLOG(@"area.regionId0==%@  area.parentId0==%@",area.regionId,area.parentId);
    province=area.regionId;
    
    //城市
    
    NSMutableArray*id1Array=[GroupTableModel getAllFromMenuTable:array[1]];
  
    if (id1Array.count!=0)
    {
        AreaModel*area1=id1Array[0];
        city=area1.regionId;
        
        //县级
        if (![array[2] isEqualToString:@""])
        {
            NSMutableArray*id2Array=[GroupTableModel getAllFromMenuTable:array[2]];
            if(id2Array.count!=0)
            {
                AreaModel*area2=id2Array[0];
                town=area2.regionId;
            }
            else
            {
                town=@"0";
            }
        }
        else
        {
            town=@"0";
        }

    }
    else
    {
    city=@"0";
    town=@"0";
    }
    }
    else
    {
    province=@"0";
        city=@"0";
        town=@"0";
    }
    
    
    MYLOG(@"province===%@city===%@town====%@",province,city,town);
    
    if (_bj==1)
    {
        [HttpEngine changeAddress:_addrId Consignee:_userNameTF.text withPhoneMob:_phoneTF.text withProvince:province withCity:city withTown:town withAddress:_adreTF.text];
        [self alartView:@"更新成功"];
    }
    else
    {
        [HttpEngine addAdressConsignee:_userNameTF.text withPhoneMob:_phoneTF.text withProvince:province withCity:city withTown:town withAddress:_adreTF.text completion:^(NSString *str) {
            if ([str isEqualToString:@"succe"]) {
                [self alartView:@"新增成功"];
            } else {
                [self alartView:@"新增失败"];
            }
        }];
    }
}
//
//- (void)showMessge:(NSString *)MessgeStr {
//    [WSProgressHUD showImage:nil status:MessgeStr];
//    [self performSelector:@selector(dismisshud) withObject:nil afterDelay:1.5];
//}
//- (void)dismisshud {
//    [WSProgressHUD dismiss];
//    [self.navigationController popViewControllerAnimated:YES];
//}
-(void)alartView:(NSString*)str
{
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction*defaultAction=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                 {
        [self.navigationController popViewControllerAnimated:YES];
                                 }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
