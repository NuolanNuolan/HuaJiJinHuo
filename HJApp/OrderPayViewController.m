//
//  OrderPayViewController.m
//  HJApp
//
//  Created by Bruce He on 15/12/2.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "OrderPayViewController.h"

@interface OrderPayViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray*array;
@property(nonatomic,unsafe_unretained)int lastTag;
@property(nonatomic,strong)UITableView*tableView;
@end
#define LBVIEW_WIDTH1 [UIScreen mainScreen].bounds.size.width
#define LBVIEW_HEIGHT1 [UIScreen mainScreen].bounds.size.height
@implementation OrderPayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITableView*tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,LBVIEW_WIDTH1 , LBVIEW_HEIGHT1) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.rowHeight=50;
    [self.view addSubview:tableView];
    _array=[[NSArray alloc]initWithObjects:@"花集余额",@"微信支付",@"支付宝", nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 5;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row==0)
    {
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, LBVIEW_WIDTH1-20, 30)];
        label.text=[NSString stringWithFormat:@"选择支付方式 支付金额为:元"];
        [cell addSubview:label];
    }
    else
        if (indexPath.row==4)
        {
            UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, LBVIEW_WIDTH1-20, 30)];
            label.text=@"去支付";
            label.textAlignment=NSTextAlignmentCenter;
            [cell addSubview:label];
        }
        else
        {
            cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"pay1-%lu.png",(long)indexPath.row]];
            cell.textLabel.text=_array[indexPath.row-1];
            UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-25, 27.5, 15, 15)];
            [btn setBackgroundImage:[UIImage imageNamed:@"maru.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"Dg.png"] forState:UIControlStateSelected];
            [cell addSubview:btn];
            
            
        }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
           }

    else
        if (indexPath.row==4)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            UIButton*btt=[_tableView viewWithTag:indexPath.row];
            
            if (_lastTag!=0)
            {
                UIButton*btn=[_tableView viewWithTag:_lastTag];
                btn.selected=NO;
            }
            _lastTag=(int)btt.tag;
            btt.selected=!btt.selected;

        }
    
}
@end
