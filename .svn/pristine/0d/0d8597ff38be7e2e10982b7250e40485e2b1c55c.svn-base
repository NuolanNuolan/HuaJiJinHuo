//
//  AboutMeViewController.m
//  HJApp
//
//  Created by Bruce He on 15/11/2.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "AboutMeViewController.h"
#import "HttpEngine.h"
#import "MyHJViewController.h"
#import "ChangeSexViewController.h"
#import "UIImageView+WebCache.h"


@interface AboutMeViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>
@property(nonatomic,strong)NSArray*dataArray;

@property(nonatomic,strong)UIView*btnView;
@property(nonatomic,strong)UIView*timeView;
@property(nonatomic,strong)UIView*shadowView;
@property(nonatomic,strong)UIDatePicker *datePicker;
@property(nonatomic,strong)NSArray*titleArray;

@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)UIButton*sexBtn;
@property(nonatomic,strong)UIButton*birthdayBtn;
@property(nonatomic,strong)UITextField*trueNameTF;
@property(nonatomic,strong)UITextView*trueNameTFV;
@property(nonatomic,strong)UILabel*sexLabel;
@property(nonatomic,strong)UILabel*birthdayLabel;

@property(nonatomic,unsafe_unretained)BOOL isOpen;
@property(nonatomic,strong)UILabel*timeLabel;
@property(nonatomic,strong)UIView*chooseView;
@property(nonatomic,strong)UIImagePickerController*imageVC;
@property(nonatomic,strong)UIImageView*headImage;

@end

#define LBVIEW_WIDTH1 [UIScreen mainScreen].bounds.size.width
#define LBVIEW_HEIGHT1 [UIScreen mainScreen].bounds.size.height

@implementation AboutMeViewController


-(void)viewWillAppear:(BOOL)animated
{
    if (_isTag==10)
    {
        _sexLabel.text=@"男";
    }
    if (_isTag==11)
    {
        _sexLabel.text=@"女";
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self CreateUI];
    [self LoadData];
}
-(void)LoadData{

    NSString*str=[[NSUserDefaults standardUserDefaults]objectForKey:@"ID"];
    [HttpEngine getConsumerDetailData:str completion:^(NSArray *dataArray)
     {
         _dataArray=dataArray;
         [_tableView reloadData];
        
     }];

}
-(void)CreateUI{


    self.navigationController.navigationBarHidden=NO;
    self.title=@"个人资料";
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.navigationController.navigationBar.translucent =NO;
    _titleArray=[[NSArray alloc]initWithObjects:@"会员",@"会员UID",@"真实姓名",@"性别",@"生日", nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
     [self showConsumerDetail];
    
}
-(void)showConsumerDetail
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, LBVIEW_WIDTH1, LBVIEW_HEIGHT1-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    //_tableView.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [self.view addSubview:_tableView];
}

//区头
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView*view=[[UIView alloc]init];
    
    _headImage=[[UIImageView alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1 * 0.05, (80-LBVIEW_HEIGHT1*0.09)/2, LBVIEW_HEIGHT1*0.09, LBVIEW_HEIGHT1* 0.09)];
    ConsumerDetail*consumer=_dataArray[0];
    NSString*picUrl=[NSString stringWithFormat:@"http://s.huaji.com%@",consumer.portrait];
    [_headImage sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"head.png"]];
    _headImage.layer.cornerRadius=LBVIEW_HEIGHT1* 0.09/2;
    _headImage.clipsToBounds=YES;
    [view addSubview:_headImage];
    
    UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(4*LBVIEW_WIDTH1/5-10, 20, LBVIEW_WIDTH1/5, 40)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"更换头像" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    btn.layer.borderColor=[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1].CGColor;
    btn.layer.borderWidth=1;
    btn.layer.cornerRadius=5;
    btn.clipsToBounds=YES;
    _isOpen=NO;
    [btn addTarget:self action:@selector(uploadPic) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    return view;
}
//上传头像
-(void)uploadPic
{
    _imageVC=[[UIImagePickerController alloc]init];
    _imageVC.delegate=self;
    _imageVC.allowsEditing=YES;

    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction*defaultAction=[UIAlertAction actionWithTitle:@"本地相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action)
                                 {
                        _imageVC.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                        [self presentViewController:_imageVC animated:YES completion:nil];
                                 }];
    UIAlertAction*defaultAction1=[UIAlertAction actionWithTitle:@"使用相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action)
                                 {
                                     if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                                     {
                                         //说明相机 可以使用 ；
                                         _imageVC.sourceType=UIImagePickerControllerSourceTypeCamera;
                                         [self presentViewController:_imageVC animated:YES completion:nil];
                                     }
                                 }];
    UIAlertAction*cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction*action)
                          {
                              
                          }];
    [alert addAction:cancel];
    [alert addAction:defaultAction];
    [alert addAction:defaultAction1];
    [self presentViewController:alert animated:YES completion:nil];

    
}
//点击取消 ；
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//选中某项媒体文件；
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //取出选中的图片 ；
    
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    _headImage.image=image;
    
    [HttpEngine uploadPicData:image];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}

//区尾
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView*view=[[UIView alloc]init];
    UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(10, 30, LBVIEW_WIDTH1-20, 40)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius=7;
    btn.clipsToBounds=YES;
    [btn addTarget:self action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
}

//区
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConsumerDetail*consumer=_dataArray[0];
    UITableViewCell*cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.textLabel.text=_titleArray[indexPath.row];
        cell.textLabel.textColor=[UIColor grayColor];
//        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.textLabel.adjustsFontForContentSizeCategory=YES;
        switch (indexPath.row)
        {
            case 0:
            {
                UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1/3, 20, 2*LBVIEW_WIDTH1/3, 20)];
                label.textColor=[UIColor blackColor];
                label.text=consumer.userid;
                label.font=[UIFont systemFontOfSize:14];
                [cell addSubview:label];
            }
                break;
            case 1:
            {
                UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1/3, 20, 2*LBVIEW_WIDTH1/3, 20)];
                label.textColor=[UIColor blackColor];
                label.text=consumer.uniqueid;
                label.font=[UIFont systemFontOfSize:14];
                [cell addSubview:label];
                
            }
                break;
            case 2:
            {
//                _trueNameTF=[[UITextField alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1/3, 15,LBVIEW_WIDTH1/2, 40)];
//                _trueNameTF.layer.borderColor=[UIColor grayColor].CGColor;
//                _trueNameTF.layer.borderWidth=1;
//                _trueNameTF.layer.cornerRadius=10;
//                _trueNameTF.clipsToBounds=YES;
//                _trueNameTF.text=[NSString stringWithFormat:@"%@",consumer.realName];
//                [_trueNameTF addTarget:self action:@selector(keyDown) forControlEvents:UIControlEventEditingDidEndOnExit];
//                _trueNameTF.textColor=[UIColor blackColor];
//                
//                UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(10,0,10,40)];
//                leftView.backgroundColor = [UIColor clearColor];
//                _trueNameTF.leftView = leftView;
//                _trueNameTF.leftViewMode = UITextFieldViewModeAlways;
//                _trueNameTF.font=[UIFont systemFontOfSize:14];
//                [cell addSubview:_trueNameTF];
                
                _trueNameTFV=[[UITextView alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1/3, 15,LBVIEW_WIDTH1/2, 40)];
                _trueNameTFV.layer.borderColor=[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1].CGColor;
                _trueNameTFV.layer.borderWidth=1;
                _trueNameTFV.layer.cornerRadius=10;
                _trueNameTFV.clipsToBounds=YES;
                _trueNameTFV.text=[NSString stringWithFormat:@"%@",consumer.realName];
                _trueNameTFV.textColor=[UIColor blackColor];
                _trueNameTFV.delegate=self;
                _trueNameTFV.returnKeyType = UIReturnKeyDone;
                _trueNameTFV.font=[UIFont systemFontOfSize:14];
                [cell addSubview:_trueNameTFV];

                
            }
                break;
            case 3:
            {
                
                _sexLabel=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1/3+10, 10,LBVIEW_WIDTH1/2-10, 40)];
                _sexLabel.textColor=[UIColor blackColor];
                _sexLabel.font=[UIFont systemFontOfSize:14];
                [cell addSubview:_sexLabel];
                
                _sexBtn=[[UIButton alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1/3, 10,LBVIEW_WIDTH1/2, 40)];
                _sexBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                _sexBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                _sexBtn.layer.borderWidth=1;
                _sexBtn.layer.borderColor=[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1].CGColor;
                _sexBtn.layer.cornerRadius=10;
                _sexBtn.clipsToBounds=YES;
                [_sexBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                if ([consumer.gender isEqualToString:@"0"])
                {
                    _sexLabel.text=@"男";
                }
                else
                {
                    _sexLabel.text=@"女";
                }
                [_sexBtn addTarget:self action:@selector(changeSex) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:_sexBtn];
            }
                break;
            case 4:
            {
                _birthdayLabel=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1/3+10, 10,LBVIEW_WIDTH1/2-10, 40)];
                _birthdayLabel.textColor=[UIColor blackColor];
                _birthdayLabel.text=consumer.birthday;
                _birthdayLabel.font=[UIFont systemFontOfSize:14];
                [cell addSubview:_birthdayLabel];
                
                _birthdayBtn=[[UIButton alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1/3, 10,LBVIEW_WIDTH1/2, 40)];
                _birthdayBtn.layer.borderWidth=1;
                _birthdayBtn.layer.borderColor=[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1].CGColor;
                _birthdayBtn.layer.cornerRadius=5;
                _birthdayBtn.clipsToBounds=YES;
                [_birthdayBtn addTarget:self action:@selector(changeBirthday) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:_birthdayBtn];
            }
                break;
            default:
                break;
        }
        
    }
    
    return cell;
}

-(void)changeBirthday
{
    _timeView=[[UIView alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1*0.1, LBVIEW_HEIGHT1*0.25, LBVIEW_WIDTH1*0.8, LBVIEW_HEIGHT1*0.5)];
    _timeView.backgroundColor=[UIColor whiteColor];
    _timeView.layer.cornerRadius=10;
    _timeView.clipsToBounds=YES;
    
    _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, LBVIEW_WIDTH1*0.8, LBVIEW_HEIGHT1*0.05-1)];
    //_timeLabel.text=@"2015年1月3日周日";
    
    _timeLabel.textAlignment=NSTextAlignmentCenter;
    _timeLabel.font=[UIFont systemFontOfSize:19];
    _timeLabel.textColor=[UIColor blueColor];
    [_timeView addSubview:_timeLabel];
    
    UILabel*lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, LBVIEW_HEIGHT1*0.05-1, LBVIEW_WIDTH1*0.8, 1)];
    lineLabel.backgroundColor=[UIColor blueColor];
    [_timeView addSubview:lineLabel];
    
    _datePicker = [[ UIDatePicker alloc] initWithFrame:CGRectMake(0, LBVIEW_HEIGHT1*0.05-1, LBVIEW_WIDTH1*0.8, LBVIEW_HEIGHT1*0.4)];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    [_datePicker addTarget:self action:@selector(showTime) forControlEvents:UIControlEventValueChanged];
    //_datePicker.backgroundColor=[UIColor blueColor];
    [_timeView addSubview:_datePicker];
    
    UILabel*btnLineLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, LBVIEW_HEIGHT1*0.4-1, LBVIEW_WIDTH1*0.8, 1)];
    btnLineLabel.textColor=[UIColor grayColor];
    [_timeView addSubview:btnLineLabel];
    
    UIButton*timeBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, LBVIEW_HEIGHT1*0.45, LBVIEW_WIDTH1*0.8, LBVIEW_HEIGHT1*0.05)];
    [timeBtn setTitle:@"完成" forState:UIControlStateNormal];
    timeBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [timeBtn setTintColor:[UIColor blackColor]];
    [timeBtn setBackgroundColor:[UIColor redColor]];
    [timeBtn addTarget:self action:@selector(chooseTime) forControlEvents:UIControlEventTouchUpInside];
    [_timeView addSubview:timeBtn];
    
    
    _shadowView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _shadowView.backgroundColor=[UIColor lightGrayColor];
    _shadowView.alpha=1;
    
    //找window
    UIWindow *window=[[UIApplication sharedApplication]keyWindow];
    [window addSubview:_shadowView];
    [_shadowView addSubview:_timeView];
    
    
    
}
//时间显示
-(void)showTime
{
    NSDate*date=_datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString*timeStr=[formatter stringFromDate:date];
    _timeLabel.text=timeStr;
}

-(void)chooseTime
{
    [_shadowView removeFromSuperview];
    NSDate*date=_datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString*timeStr=[formatter stringFromDate:date];
    _birthdayLabel.text=timeStr;
    
}

-(void)changeSex
{
    ChangeSexViewController*changeSex=[[ChangeSexViewController alloc]init];
    changeSex.aboutMeVC=self;
    [self.navigationController pushViewController:changeSex animated:NO];
}

- (IBAction)saveBtn:(UIButton *)sender
{
    NSString*str=@"0";
    if ([_sexLabel.text isEqualToString:@"女"])
    {
       str=@"1";
    }
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定更新吗" preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction*defaultAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action)
                                 {
          [HttpEngine updataConsumerDetailData:_trueNameTFV.text with:str with:_birthdayLabel.text completion:^(NSString *str) {
              if ([str isEqualToString:@"succe"]) {
                  [self showMessge:@"更新成功"];
              } else {
                  [self showMessge:@"更新失败"];
              }
          }];
                                 }];
    UIAlertAction*cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction*action)
                          {
                              
                          }];
    [alert addAction:cancel];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)showMessge:(NSString *)MessgeStr {
    [WSProgressHUD showImage:nil status:MessgeStr];
    [self performSelector:@selector(dismisshud) withObject:nil afterDelay:3];
}
- (void)dismisshud {
    [WSProgressHUD dismiss];
}
//让view上去做动画 table上去
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
     _tableView.frame=CGRectMake(0, 0, LBVIEW_WIDTH1, LBVIEW_HEIGHT1-64-216);
    [UIView commitAnimations];
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //text==return  换行
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        _tableView.frame=CGRectMake(0, 0, LBVIEW_WIDTH1, LBVIEW_HEIGHT1-64);
        [UIView commitAnimations];
    }
    return YES;
}
-(void)dismissKeyboard
{
    [self.view endEditing:YES];
     _tableView.frame=CGRectMake(0, 0, LBVIEW_WIDTH1, LBVIEW_HEIGHT1-64);
}
@end
