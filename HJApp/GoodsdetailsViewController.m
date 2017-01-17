//
//  GoodsdetailsViewController.m
//  HJApp
//
//  Created by 袁联林 on 16/9/5.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "GoodsdetailsViewController.h"
#import "SeedsGoodsTableViewCell.h"
#import "Exchange ViewController.h"
@interface GoodsdetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    //表格
    UITableView *_tableview;
    //
    UITextField *_textfild;
}

@end

@implementation GoodsdetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    // Do any additional setup after loading the view.
}
-(void)CreateUI{

    self.view.backgroundColor = [UIColor whiteColor];
    self.title=@"礼品详情";
    _tableview = [[UITableView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.showsVerticalScrollIndicator = NO;
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    
  
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 450;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"Cell";
    SeedsGoodsTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell = [[[NSBundle mainBundle]loadNibNamed:@"SeedsGoodsTableViewCell" owner:self options:nil]lastObject];
    cell.desc.text = [NSString stringWithFormat:@"%@",_model.desc];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 218*SCREEN_HEIGHT/iphone6p_height;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, 218*SCREEN_HEIGHT/iphone6p_height)];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGMAKE(20, 20, 177*SCREEN_WIDTH/iphone6p_width, 177*SCREEN_HEIGHT/iphone6p_height)];
    [imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_model.imageurl]]];
    
    UILabel *labone = [[UILabel alloc]initWithFrame:CGMAKE(20+imageview.frame.size.width+10, 29, 200, 20)];
    [labone setFont:[UIFont systemFontOfSize:15]];
    labone.text=[NSString stringWithFormat:@"%@",_model.name];
    NSArray *arr = [[NSArray alloc]initWithObjects:@"商品编号:",@"花籽兑换:",@"兑换数量:",@"当前库存:", nil];
    for (int i=0; i<4; i++) {
        UILabel *labtwo = [[UILabel alloc]initWithFrame:CGMAKE(labone.frame.origin.x, 55+i*22, 60, 16)];
        [labtwo setText:arr[i]];
        [labtwo setFont:[UIFont systemFontOfSize:12]];
        [labtwo setTextColor:RGB(85, 85, 85)];
        
        
        if (i<3) {
            UILabel *labthere = [[UILabel alloc]initWithFrame:CGMAKE(labone.frame.origin.x+60, 55+i*22, 100, 16)];
            [labthere setFont:[UIFont systemFontOfSize:12]];
            [labthere setTextColor:RGB(85, 85, 85)];
            if (i==0) {
                [labthere setText:[NSString stringWithFormat:@"%@",_model.Goodsid]];
            }else if (i==1)
            {
                
                [labthere setText:[NSString stringWithFormat:@"%@",_model.price]];
                
            }else
            {
                labthere.frame = CGMAKE(labone.frame.origin.x+60, 55+66, 100, 16);
                [labthere setText:[NSString stringWithFormat:@"%@件",_model.num1]];
                _textfild = [[UITextField alloc]initWithFrame:CGMAKE(labone.frame.origin.x+60, 99, 50, 16)];
                _textfild.text=@"1";
                _textfild.layer.borderWidth=1;
                _textfild.layer.borderColor = [UIColor grayColor].CGColor;
                [_textfild setFont:[UIFont systemFontOfSize:12]];
                _textfild.keyboardType = UIKeyboardTypeNumberPad;
            }
            
            [view addSubview:labthere];
        }
        
        [view addSubview:_textfild];
        [view addSubview:labtwo];
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTintColor:[UIColor whiteColor]];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"兑换" forState:UIControlStateNormal];
    btn.frame = CGMAKE(labone.frame.origin.x, 140, 139*SCREEN_WIDTH/iphone6p_width, 29*SCREEN_HEIGHT/iphone6p_height);
    [btn addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:btn];
    [view addSubview:imageview];
    [view addSubview:labone];
    return view;
    
}
-(void)Click
{
    if([_model.price intValue]>[_seeds intValue])
    {
        [MBProgressHUD showError:@"对不起您的花籽不足"];
        return;
    }else if([_textfild.text intValue]>[_model.num1 intValue])
    {
        
         [MBProgressHUD showError:@"对不起当前库存不足"];
        return;
    }
    Exchange_ViewController *view = [[Exchange_ViewController alloc ]init];
    view.model = _model;
    view.count =[_textfild.text intValue];
    [self.navigationController pushViewController:view animated:YES];
    
}

@end
