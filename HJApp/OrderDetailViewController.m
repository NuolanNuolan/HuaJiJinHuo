//
//  OrderDetailViewController.m
//  HJApp
//
//  Created by Bruce He on 15/11/4.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "orderDetail.h"

@interface OrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView*tableView;
@end

//宏定义宽高
#define VIEW_WIDTH self.view.bounds.size.width
#define VIEW_HEIGHT self.view.bounds.size.height

#define LBVIEW_WIDTH1 [UIScreen mainScreen].bounds.size.width
#define LBVIEW_HEIGHT1 [UIScreen mainScreen].bounds.size.height
@implementation OrderDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBackBtn)];
    
    
    self.title=@"订单详情";
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, LBVIEW_WIDTH1, LBVIEW_HEIGHT1) style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
    
}

-(void)goBackBtn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    orderDetail*order=_dataArray[0];
    if (section==0)
    {
        return 1;
    }
    if (section==1)
    {
        return 3;
    }
    return order.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    orderDetail*order=_dataArray[0];
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
         cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section==0)
    {
        UILabel*nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, LBVIEW_WIDTH1-20, LBVIEW_HEIGHT1*0.05)];
        nameLabel.text=[NSString stringWithFormat:@"%@  %@",order.recvName,order.recvMobile];
        nameLabel.font=[UIFont systemFontOfSize:12];
        nameLabel.textColor=[UIColor grayColor];
        [cell addSubview:nameLabel];
        
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(10, LBVIEW_HEIGHT1*0.05, LBVIEW_WIDTH1-20, LBVIEW_HEIGHT1*0.05)];
        label.text=[NSString stringWithFormat:@"%@",order.recvAddress];
        label.font=[UIFont systemFontOfSize:12];
        label.textColor=[UIColor grayColor];
        [cell addSubview:label];
        
        return cell;
    }
    NSArray*nameArray=[[NSArray alloc]initWithObjects:@"总价",@"配送价",@"红包抵扣", nil];
    if (indexPath.section==1)
    {
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, LBVIEW_HEIGHT1*0.06)];
        label.text=nameArray[indexPath.row];
        label.font=[UIFont systemFontOfSize:12];
        label.textColor=[UIColor grayColor];
        [cell addSubview:label];
        
        UILabel*prcLabel=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-70, 0, 60, LBVIEW_HEIGHT1*0.06)];
        prcLabel.font=[UIFont systemFontOfSize:12];
        prcLabel.textColor=[UIColor grayColor];
        [cell addSubview:prcLabel];
        if (indexPath.row==0)
        {
            prcLabel.text=[NSString stringWithFormat:@"¥%@",order.orderPrice];
        }
        if (indexPath.row==1)
        {
            prcLabel.text=[NSString stringWithFormat:@"¥%@",order.preferMoney];
        }
        if (indexPath.row==2)
        {
            prcLabel.text=[NSString stringWithFormat:@"- ¥%@",order.discountPrice];
        }
        return cell;
    }
    
    NSDictionary*dic=order.dataArray[indexPath.row];
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 180, LBVIEW_HEIGHT1*0.08)];
    label.text=[NSString stringWithFormat:@"%@  %@",dic[@"merch_name"],dic[@"merch_desc"]];
    label.numberOfLines=2;
    label.font=[UIFont systemFontOfSize:12];
    label.textColor=[UIColor grayColor];
    [cell addSubview:label];
    
    UILabel*numLabel=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-110, 0, 40, LBVIEW_HEIGHT1*0.08)];
    numLabel.text=[NSString stringWithFormat:@"x%@",dic[@"merch_qty"]];;
    numLabel.textColor=[UIColor grayColor];
    numLabel.font=[UIFont systemFontOfSize:12];
    [cell addSubview:numLabel];
    
    
    UILabel*prcLabel=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-70, 0, 60, LBVIEW_HEIGHT1*0.08)];
//    float num=[dic[@"merch_qty"] floatValue];
//    float price=[dic[@"curr_price"] floatValue];
//    float allPrice=num*price;
//    prcLabel.text=[NSString stringWithFormat:@"¥%0.2f",allPrice];
    prcLabel.text=[NSString stringWithFormat:@"¥%@",dic[@"curr_price"]];
    prcLabel.textColor=[UIColor grayColor];
    prcLabel.font=[UIFont systemFontOfSize:12];
    [cell addSubview:prcLabel];
    
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return LBVIEW_HEIGHT1*0.1;
    }
    if (indexPath.section==1)
    {
        return LBVIEW_HEIGHT1*0.06;
    }
    return LBVIEW_HEIGHT1*0.08;;
}
//区头
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    orderDetail*order=_dataArray[0];
    UIView*view=[[UIView alloc]init];
    UIImageView*image=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    [view addSubview:image];
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(37, 10, 80, 20)];

    label.font=[UIFont systemFontOfSize:14];
    label.textColor=[UIColor blackColor];
    [view addSubview:label];
        if (section==0)
    {
        label.text=@"订单号 :";
        image.image=[UIImage imageNamed:@"order-ddh.png"];
        UILabel*numLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 10, 140, 20)];
        numLabel.text=order.orderNo;
        numLabel.font=[UIFont systemFontOfSize:14];
        numLabel.textColor=[UIColor blackColor];
        [view addSubview:numLabel];
    }
    if (section==1)
    {
        image.image=[UIImage imageNamed:@"order-ddjg.png"];
        label.text=@"订单价格";
    }
    if (section==2)
    {
         image.image=[UIImage imageNamed:@"order-spqd.png"];
        label.text=@"商品清单";
    }
    
    return view;
}
//区尾
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    return 40;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    orderDetail*order=_dataArray[0];
    NSArray*array=order.dataArray;
    UIView*view=[[UIView alloc]init];
    view.backgroundColor=[UIColor whiteColor];
    if (section==0)
    {
        return nil;
    }
    if (section==1)
    {
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-150, 10, 70, 20)];
        label.textColor=[UIColor blackColor];
        label.font=[UIFont systemFontOfSize:14];
        label.text=@"实际支付";
        [view addSubview:label];
        
        UILabel*picLabel=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-80, 10, 80, 20)];
        picLabel.textColor=[UIColor redColor];
        picLabel.font=[UIFont systemFontOfSize:14];
        picLabel.text=[NSString stringWithFormat:@"¥%@",order.paymentPrice];
        [view addSubview:picLabel];
        
        return view;
    }
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-200, 10, 120, 20)];
    label.textColor=[UIColor blackColor];
    label.font=[UIFont systemFontOfSize:14];
    label.text=[NSString stringWithFormat:@"共%lu件商品，合计",(unsigned long)array.count];
    [view addSubview:label];
    
    UILabel*picLabel=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-80, 10, 80, 20)];
    picLabel.textColor=[UIColor redColor];
    picLabel.font=[UIFont systemFontOfSize:14];
    picLabel.text=[NSString stringWithFormat:@"¥%@",order.paymentPrice];
    [view addSubview:picLabel];
    
    return view;
}
@end
