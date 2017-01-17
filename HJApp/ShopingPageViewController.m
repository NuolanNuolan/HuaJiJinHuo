//
//  ShopingPageViewController.m
//  HJApp
//
//  Created by Bruce He on 15/10/30.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "ShopingPageViewController.h"
#import "HttpEngine.h"
#import "PayViewController.h"
#import "AssortPageViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ChangCityViewController.h"
#import "ShopV.h"

@interface ShopingPageViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSArray*dataArray;

@property (nonatomic, strong) UILabel *okaneL;
@property (nonatomic, strong) UIButton *kessanBtn;

//

@property(nonatomic,copy)NSString*totalPrice;
@property(nonatomic,copy)NSString*shippingFee;
@property(nonatomic,strong)UILabel*shippingFeeLabel;

@property(nonatomic,unsafe_unretained)BOOL isBool;
@property (nonatomic,unsafe_unretained)CGRect btnRect;
@property (nonatomic,unsafe_unretained)NSInteger btnRow;
@property (nonatomic,strong)ShopV *shopv;

@end



#define VIEW_WIDTH self.view.bounds.size.width
#define VIEW_HEIGHT self.view.bounds.size.height

#define LBVIEW_WIDTH1 [UIScreen mainScreen].bounds.size.width
#define LBVIEW_HEIGHT1 [UIScreen mainScreen].bounds.size.height
#define SIZE [UIScreen mainScreen].bounds.size

@implementation ShopingPageViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent =NO;
    
    if (!_isBool)
    {
        _isBool=YES;
        if ([self isLogin:self withTitle:@"登录后，可查看自己的购物车列表"  with:2])
        {
            return;
        }
    }
    
    if ([HJViewController needShowPage])
        return;

    [HttpEngine getSimpleCart:^(NSArray *array) {
        _dataArray=array;
        [self refreshCartCount:array];
        [self update];
        [_tableView removeFromSuperview];
        [self showTableView];
        [_tableView reloadData];
        
        if (_dataArray.count == 0) {
            _shopv = [[ShopV alloc]init];
            _shopv.frame = CGRectMake((LBVIEW_WIDTH1-100)/2, (LBVIEW_HEIGHT1-118-100)/2, 100, 100);
            _shopv.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
            [_shopv viewWithSuperSize:SIZE withTabVC:self.tbBarVC];
            [self.view addSubview:_shopv];
        }
    }];
    
    NSString*code=[[NSUserDefaults standardUserDefaults]objectForKey:@"CODE"];
    if(!code)
    {
        [self alert];
        return;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [self showTableView];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapClick)];
    [doubleTap setNumberOfTapsRequired:2];
    doubleTap.delegate = self;
    [self.view addGestureRecognizer:doubleTap];

}

-(void)showTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, LBVIEW_WIDTH1, LBVIEW_HEIGHT1-54-LBVIEW_HEIGHT1 / 13-64)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    UIView*priceView=[[UIView alloc]initWithFrame:CGRectMake(0, LBVIEW_HEIGHT1-165, VIEW_WIDTH , LBVIEW_HEIGHT1 / 13)];
    priceView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:priceView];
    
    self.okaneL = [[UILabel alloc] init];
    self.okaneL.textColor = [UIColor whiteColor];
    self.okaneL.backgroundColor=[UIColor blackColor];
    [priceView addSubview:self.okaneL];
    
    _shippingFeeLabel=[[UILabel alloc]init];
    _shippingFeeLabel.textColor=[UIColor whiteColor];
    [priceView addSubview:_shippingFeeLabel];
    
    
    self.kessanBtn=[[UIButton alloc]init];
    self.kessanBtn.frame = CGRectMake(LBVIEW_WIDTH1 * 0.665, 0, LBVIEW_WIDTH1-LBVIEW_WIDTH1 * 0.665, priceView.frame.size.height);
    [self.kessanBtn setBackgroundColor:[UIColor colorWithRed:0/255.0 green:136/255.0 blue:215/255.0 alpha:1]];
    [self.kessanBtn setTitle:@"去结算" forState:UIControlStateNormal];
    [self.kessanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.kessanBtn.titleLabel.font=[UIFont systemFontOfSize:17];
    [self.kessanBtn addTarget:self action:@selector(gotopayAction) forControlEvents:UIControlEventTouchUpInside];
    [priceView addSubview:self.kessanBtn];
    
    [self update];
    
}
-(void)update
{
    float sum=0;
    if (_dataArray.count==0)
    {
        _totalPrice=[NSString stringWithFormat:@"0.00"];
    }
    else
    {
        for (int i=0; i<_dataArray.count; i++)
        {
            ShopingCar*shopCar=_dataArray[i];
            NSString*numberStr=[NSString stringWithFormat:@"%@",shopCar.number];
            float num=[numberStr floatValue];
            NSString*priceStr=[NSString stringWithFormat:@"%@",shopCar.price];
            float price=[priceStr floatValue];
            sum=sum+price*num;
            _totalPrice=[NSString stringWithFormat:@"%0.2f",sum];
        }
    }
    NSString*allPrice=[NSString stringWithFormat:@"总计%@",_totalPrice];
    UIFont*font=[UIFont systemFontOfSize:17];
    CGSize size=[allPrice boundingRectWithSize:CGSizeMake(LBVIEW_WIDTH1, LBVIEW_HEIGHT1 / 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    self.okaneL.text =allPrice;
    self.okaneL.font = font;
    self.okaneL.frame = CGRectMake(5, (LBVIEW_HEIGHT1/13-LBVIEW_HEIGHT1/15)/2, size.width, LBVIEW_HEIGHT1 / 15);
    
    int value=[_totalPrice intValue];
    if (value>99)
    {
        _shippingFee=@"免运费";
    }
    else
    {
        NSString*valueStr=[NSString stringWithFormat:@"%d",100-value];
        _shippingFee=[NSString stringWithFormat:@"运费10元(差%@元免配送)",valueStr];
    }
    //临时先去除运费显示
//    _shippingFee = @"";
    
    UIFont*font1=[UIFont systemFontOfSize:12];
    CGSize size1=[_shippingFee boundingRectWithSize:CGSizeMake(LBVIEW_WIDTH1, LBVIEW_HEIGHT1 / 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font1} context:nil].size;
    _shippingFeeLabel.frame=CGRectMake(10+size.width, (LBVIEW_HEIGHT1/13-LBVIEW_HEIGHT1/15)/2, size1.width, LBVIEW_HEIGHT1/15);
    _shippingFeeLabel.font=font1;
    _shippingFeeLabel.text=_shippingFee;
    
}


-(void)gotopayAction
{
    NSString*str=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    if (!str)
    {
        LoginViewController*loginVC=[[LoginViewController alloc]init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:navigationController animated:YES completion:nil];
        return;
    }
    
    [HttpEngine checkout:^(NSDictionary *dict) {
        
        MYLOG(@"checkout : %@",dict);
        
        NSArray *array = [dict objectForKey:@"cart_list"];
        
        NSString *warning_message = [dict objectForKey:@"warning_message"];
        if(![warning_message isEqualToString:@""]){
            
            [self customAlert:warning_message];
            return;
        }
        
        if (array.count==0)
        {
            self.tbBarVC.selectedIndex=1;
        }
        else
        {
            PayViewController*payVC=[[PayViewController alloc]init];
            payVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:payVC animated:YES];
        }
    } failure:^(NSError *error) {
        
        MYLOG(@"checkout error: %@",error);
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //amount
    ShopingCar*spCa=_dataArray[indexPath.row];
    NSArray*detailArray=spCa.props;
    NSMutableArray*attributeArray=[[NSMutableArray alloc]init];
    for (int i=0; i<detailArray.count; i++)
    {
        NSDictionary*dic=detailArray[i];
        NSString*str=[dic[@"visible"] stringValue];
        if ([str isEqualToString:@"1"])
        {
            [attributeArray addObject:dic[@"prop_value"]];
        }
    }
    NSString*attributeStr=@"";
    for (int i=0; i<attributeArray.count; i++)
    {
        attributeStr=[NSString stringWithFormat:@"%@ %@",attributeStr,attributeArray[i]];
    }
    
    UITableViewCell*cell=[tableView cellForRowAtIndexPath:indexPath];
    
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        UILabel*nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, LBVIEW_WIDTH1*0.5-10, 60)];
        nameLabel.text=[NSString stringWithFormat:@"%@ %@",spCa.skuName,attributeStr] ;
        nameLabel.numberOfLines=2;
        [nameLabel setFont:NJTitleFont];
        [nameLabel setTextColor:NJFontColor];
        [cell addSubview:nameLabel];
        
        NSString*str=[NSString stringWithFormat:@"¥%@",spCa.price];
        UIFont*font=NJTitleFont;
        CGSize size=[str boundingRectWithSize:CGSizeMake(100, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        
        UILabel*picLabel=[[UILabel alloc]initWithFrame:CGRectMake(10+LBVIEW_WIDTH1*0.5, 20, size.width, 30)];
        picLabel.text=[NSString stringWithFormat:@"¥%@",spCa.price];
        picLabel.textColor=[UIColor redColor];
        [picLabel setFont:font];
        [cell addSubview:picLabel];
        
        UILabel*numLabel=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-70, 25, 30, 20)];
        numLabel.text=[NSString stringWithFormat:@"%@",spCa.number];
        numLabel.textAlignment=NSTextAlignmentCenter;
        numLabel.font=NJTitleFont;
        [cell addSubview:numLabel];
        
        UIButton*addBtn=[[UIButton alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-40, 20, 30, 30)];
        [addBtn setImage:[UIImage imageNamed:@"AddGoods"] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
        addBtn.tag=indexPath.row;
        [cell addSubview:addBtn];
        
        
        UIButton*subBtn=[[UIButton alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-100, 20, 30, 30)];
        [subBtn setImage:[UIImage imageNamed:@"jian.png"] forState:UIControlStateNormal];
        subBtn.tag=indexPath.row+1000;
        [subBtn addTarget:self action:@selector(subBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:subBtn];
        
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
}
//增加按钮
-(void)addBtn:(UIButton*)sender
{
//    btnRow = sender.tag;
//    btnSection = sender.row;
    
    //CGRect rect=[sender convertRect: sender.bounds toView:self.view];
    _btnRect = [sender convertRect:sender.bounds toView:self.view];
    _btnRow = sender.tag;

    ShopingCar*spCa=_dataArray[sender.tag];
    NSString*numer=spCa.number;
    numer=[NSString stringWithFormat:@"%ld",[numer integerValue]+1];
    NSString*str=[[NSUserDefaults standardUserDefaults]objectForKey:@"CODE"];
    [HttpEngine addGoodsLocation:str withSku:spCa.skuId withSupplier:spCa.supplierId withNumber:numer complete:^(NSString *error, NSString *errorStr) {
        if (error) {
            [self showError:errorStr];
        }
    }];
    [self performSelector:@selector(shuaiXin) withObject:numer afterDelay:0.1];
}
- (void)doubleTapClick {
    
    [self alertMoreGoods];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    CGPoint location = [touch locationInView:self.view];
    if (CGRectContainsPoint(_btnRect, location)) {
        return YES;
    }
    return NO;
}

-(void) refreshCartCount:(NSArray *)array
{
    UITabBarItem *item = [self.tbBarVC.tabBar.items objectAtIndex:3];
    NSInteger number = 0;
    for (NSInteger i=0; i<array.count; i++) {
        ShopingCar*shCa=array[i];
        number += [shCa.number integerValue];
    }
    if(number>0){
        //[self updateCartCount:[NSString stringWithFormat:@"%ld",number]];
        item.badgeValue = [NSString stringWithFormat:@"%ld",(long)number];
    }else{
        //[self updateCartCount:nil];
        item.badgeValue=nil;
    }
}

//删除按钮
-(void)subBtn:(UIButton*)sender
{
    
    _btnRect = [sender convertRect:sender.bounds toView:self.view];
    
[HttpEngine getSimpleCart:^(NSArray *array)
 {
    _dataArray=array;
     [self refreshCartCount:array];
    [self sub:(sender.tag-1000)];
    
 }];
    
}
//删除
-(void)sub:(NSInteger)tag
{
    if (_dataArray.count==0)
    {
        return;
    }
    ShopingCar*spCa=_dataArray[tag];
    NSString*numer=spCa.number;
    numer=[NSString stringWithFormat:@"%ld",[numer integerValue]-1];
    //添加
    //MYLOG(@"===%@,===%@",spCa.skuId,spCa.supplierId);
    NSString*str=[[NSUserDefaults standardUserDefaults]objectForKey:@"CODE"];
    [HttpEngine addGoodsLocation:str withSku:spCa.skuId withSupplier:spCa.supplierId withNumber:numer complete:^(NSString *error, NSString *errorStr) {
        if (error){
            [self showError:errorStr];
        }
    }];
    [self performSelector:@selector(shuaiXin) withObject:numer afterDelay:0.1];
}
#pragma mark -----------------------showError
- (void)showError:(NSString *)errorStr {
    [WSProgressHUD showImage:nil status:errorStr];
    [self performSelector:@selector(dismisshud) withObject:nil afterDelay:3];
}
- (void)dismisshud {
    [WSProgressHUD dismiss];
}
//刷新表
-(void)shuaiXin
{
    [HttpEngine getSimpleCart:^(NSArray *array)
     {
         _dataArray=array;
         [self refreshCartCount:array];
         
         float sum=0;
         if (_dataArray.count==0)
         {
             _totalPrice=[NSString stringWithFormat:@"0.00"];
         }
         else
         {
             for (int i=0; i<_dataArray.count; i++)
             {
                 ShopingCar*shopCar=_dataArray[i];
                 NSString*numberStr=[NSString stringWithFormat:@"%@",shopCar.number];
                 float num=[numberStr floatValue];
                 NSString*priceStr=[NSString stringWithFormat:@"%@",shopCar.price];
                 float price=[priceStr floatValue];
                 sum=sum+price*num;
                 _totalPrice=[NSString stringWithFormat:@"%0.2f",sum];
             }
         }
         //总价格刷新
         NSString*allPrice=[NSString stringWithFormat:@"总计%@",_totalPrice];
         UIFont*font=[UIFont systemFontOfSize:18];
         CGSize size=[allPrice boundingRectWithSize:CGSizeMake(LBVIEW_WIDTH1, LBVIEW_HEIGHT1 / 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
         self.okaneL.text =allPrice;
         self.okaneL.frame = CGRectMake(5, (LBVIEW_HEIGHT1/13-LBVIEW_HEIGHT1/15)/2, size.width, VIEW_HEIGHT / 15);
         
         //运费刷新
         int price=[_totalPrice intValue];
         if (price>99)
         {
             _shippingFee=@"免运费";
         }
         else
         {
             NSString*valueStr=[NSString stringWithFormat:@"%d",100-price];
             _shippingFee=[NSString stringWithFormat:@"运费10元(差%@元免配送)",valueStr];
         }
         
         //临时先去除运费显示
//         _shippingFee = @"";
         
         UIFont*font1=[UIFont systemFontOfSize:12];
         CGSize size1=[_shippingFee boundingRectWithSize:CGSizeMake(LBVIEW_WIDTH1, LBVIEW_HEIGHT1 / 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font1} context:nil].size;
         self.shippingFeeLabel.text=_shippingFee;
         //MYLOG(@"_shippingFeeLabel===%@",_shippingFeeLabel.text);
         self.shippingFeeLabel.frame=CGRectMake(10+size.width, (LBVIEW_HEIGHT1/13-LBVIEW_HEIGHT1/15)/2, size1.width, LBVIEW_HEIGHT1/15);
         
         [_tableView reloadData];
     }];
    
}
//选择默认城市
-(void)alert
{
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您还未选择城市" preferredStyle: UIAlertControllerStyleAlert];
//    UIAlertAction*cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction*action)
//                          {
//                              
//                          }];
    UIAlertAction*defaultAction=[UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action)
                                 {
                                     ChangCityViewController*changVC=[[ChangCityViewController alloc]init];
                                     changVC.hidesBottomBarWhenPushed=YES;
                                     [self.navigationController pushViewController:changVC animated:YES];
                                 }];
//  [alert addAction:cancel];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void) customAlert:(NSString *)message{
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction*defaultAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action){}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)alertMoreGoods {
    
    
    ShopingCar*spCa=_dataArray[_btnRow];
    NSString*strCode=[[NSUserDefaults standardUserDefaults]objectForKey:@"CODE"];
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"快速抢购" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    UIAlertAction *defaul = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *str = alert.textFields[0].text;
        [HttpEngine addGoodsLocation:strCode withSku:spCa.skuId withSupplier:spCa.supplierId withNumber:str complete:^(NSString *error, NSString *errorStr) {
            if (error) {
                [self showError:errorStr];
            }
            [self shuaiXin];
        }];

        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:defaul];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end
