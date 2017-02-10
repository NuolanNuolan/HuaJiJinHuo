//
//  HJBalanceViewController.m
//  HJApp
//
//  Created by 袁联林 on 16/9/2.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "HJBalanceViewController.h"
#import "BalanceTableViewCell.h"
#import "HjPaymentDetails.h"
#import "UserMoneyViewController.h"
#import "WithdrawalViewController.h"
#import "AddCardsViewController.h"

@interface HJBalanceViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    //表格
    UITableView *_tableview;
    //账户收支明细
    NSArray *Arr_data;
}

@end

@implementation HJBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    if(_integral==nil)
    {
        self.title=@"账户余额";
        [self LoadData];
        
    }
    else
    {
    
        self.title=@"我的积分";
        
    }
    
    // Do any additional setup after loading the view.
}
-(void)LoadData
{

    
    [HttpEngine getUserPaymentcompletion:^(NSArray *dataArray) {
        Arr_data=[NSArray arrayWithArray:dataArray];
        [_tableview reloadData];
    }];
}
-(void)CreateUI
{

    self.view.backgroundColor = RGB(225, 225, 232);
    _tableview = [[UITableView alloc]initWithFrame:CGMAKE(5, 5, SCREEN_WIDTH-10, SCREEN_HEIGHT-64-5) style:UITableViewStyleGrouped];
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.showsVerticalScrollIndicator = NO;
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return Arr_data.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 72;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *ID = @"Cell";
    BalanceTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BalanceTableViewCell" owner:self options:nil]lastObject];
    }
    if (Arr_data.count>0) {
        [cell SetArr_data:Arr_data[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 160;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    

    if(_integral==nil)
    {
        UIView *view = [[UIView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, 200)];
        view.backgroundColor = [UIColor clearColor];
        
        UIView *view1 = [[UIView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, 125)];
        view1.backgroundColor = [UIColor whiteColor];
        
        UILabel *lab_banlce = [[UILabel alloc]initWithFrame:CGMAKE(10, 15, 80, 20)];
        lab_banlce.text =@"当前余额";
        [lab_banlce setFont:[UIFont systemFontOfSize:12]];
        [lab_banlce setTextColor:[UIColor blackColor]];
        
        
        CGSize size =  [BWCommon sizeWithString:_HJBalance font:[UIFont systemFontOfSize:22] maxSize:CGSizeMake(500, 500)];
        UILabel *banlane = [[UILabel alloc]initWithFrame:CGMAKE(10, 45, size.width, size.height)];
        banlane.text = _HJBalance;
        [banlane setFont:[UIFont systemFontOfSize:22]];
        [banlane setTextColor:[UIColor redColor]];
        UILabel *lab_yuan = [[UILabel alloc]initWithFrame:CGMAKE(size.width+12, size.height+26, 20, 16)];
        [lab_yuan setFont:[UIFont systemFontOfSize:12]];
        [lab_yuan setText:@"元"];
        [lab_yuan setTextColor:[UIColor redColor]];
//        NSArray *btnarr = [[NSArray alloc]initWithObjects:@"提现",@"充值", nil];
//        for (int i=0; i<2; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//            btn.tag=10+i;
        btn.tag=11;
//            [btn setTitle:btnarr[i] forState:UIControlStateNormal];
        [btn setTitle:@"充值" forState:UIControlStateNormal];
            [btn setTintColor:[UIColor whiteColor]];
//            btn.frame = CGMAKE(10+((_tableview.frame.size.width-30)/2)*i+(i*10), size.height+55, (_tableview.frame.size.width-30)/2, 30);
        btn.frame = CGMAKE(10, size.height+55, SCREEN_WIDTH-30, 30);
//            if (i==0) {
                [btn setBackgroundColor:[UIColor redColor]];
//            }else
//            {
//                
//                [btn setBackgroundColor:[UIColor greenColor]];
//            }
            [btn addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
            [view1 addSubview:btn];
//        }
        UILabel *lab_ZJ= [[UILabel alloc]initWithFrame:CGMAKE(10, 140, 200, 16)];
        [lab_ZJ setTextColor:RGB(54, 54, 54)];
        [lab_ZJ setText:@"最近30天收支明细"];
        [lab_ZJ setFont:[UIFont systemFontOfSize:12]];
        
        
        [view1 addSubview:lab_yuan];
        [view1 addSubview:banlane];
        [view1 addSubview:lab_banlce];
        [view addSubview:lab_ZJ];
        [view addSubview:view1];
        
        
        return view;
        
    }
    else
    {
        
        UIView *view = [[UIView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, 200)];
        view.backgroundColor = [UIColor clearColor];
        
        UIView *view1 = [[UIView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, 125)];
        view1.backgroundColor = [UIColor whiteColor];
        
        UILabel *lab_banlce = [[UILabel alloc]initWithFrame:CGMAKE(10, 15, 80, 20)];
        lab_banlce.text =@"当前积分";
        [lab_banlce setFont:[UIFont systemFontOfSize:12]];
        [lab_banlce setTextColor:[UIColor blackColor]];
        
        
        CGSize size =  [BWCommon sizeWithString:[NSString stringWithFormat:@"%@",_integral] font:[UIFont systemFontOfSize:22] maxSize:CGSizeMake(500, 500)];
        UILabel *banlane = [[UILabel alloc]initWithFrame:CGMAKE(10, 45, size.width, size.height)];
        banlane.text = [NSString stringWithFormat:@"%@",_integral];
        [banlane setFont:[UIFont systemFontOfSize:22]];
        [banlane setTextColor:[UIColor redColor]];
        UILabel *lab_yuan = [[UILabel alloc]initWithFrame:CGMAKE(size.width+12, size.height+26, 20, 16)];
        [lab_yuan setFont:[UIFont systemFontOfSize:12]];
        [lab_yuan setText:@"分"];
        [lab_yuan setTextColor:[UIColor redColor]];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag=20;
        [btn setTitle:@"积分兑换礼品" forState:UIControlStateNormal];
        [btn setTintColor:[UIColor whiteColor]];
        btn.frame = CGMAKE(20, size.height+55, _tableview.frame.size.width-40, 30);

        [btn setBackgroundColor:[UIColor redColor]];
   
        [btn addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:btn];
        
        UILabel *lab_ZJ= [[UILabel alloc]initWithFrame:CGMAKE(10, 140, 200, 16)];
        [lab_ZJ setTextColor:RGB(54, 54, 54)];
        [lab_ZJ setText:@"最近30天积分明细"];
        [lab_ZJ setFont:[UIFont systemFontOfSize:12]];
        
        
        
        
        [view1 addSubview:lab_yuan];
        [view1 addSubview:banlane];
        [view1 addSubview:lab_banlce];
        [view addSubview:lab_ZJ];
        [view addSubview:view1];
        
        
        return view;
        
    }
    
   

    
}
-(void)Click:(UIButton *)sender
{

    if (sender.tag==10) {
//        WithdrawalViewController *view = [[WithdrawalViewController alloc]init];
//        view.balance =_HJBalance;
//        [self.navigationController pushViewController:view animated:YES];
        
        AddCardsViewController *addview = [[AddCardsViewController alloc]init];
        [self.navigationController pushViewController:addview animated:YES];
    }else if(sender.tag==11)
    {
    
        UserMoneyViewController *view = [[UserMoneyViewController alloc]init];
        [self.navigationController pushViewController:view animated:YES];
    }else
    {
    
        MYLOG(@"积分");
    }
}
@end
