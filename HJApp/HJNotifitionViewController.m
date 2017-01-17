//
//  HJNotifitionViewController.m
//  HJApp
//
//  Created by 袁联林 on 16/9/19.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "HJNotifitionViewController.h"
#import "TodayShopViewController.h"

#define tableviewCellIdentifier  @"tableviewCellIdentifier"
@interface HJNotifitionViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    //数据数组
    NSArray *_dataArr;
    //title数据数组
    NSMutableArray *_titleArr;
}

@property (nonatomic, weak) UITableView *tableview;


@end

@implementation HJNotifitionViewController
-(void)viewWillAppear:(BOOL)animated
{

    self.navigationController.navigationBar.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    [self LoadData];
    // Do any additional setup after loading the view.
}

-(void)CreateUI{

    self.view.backgroundColor = RGB(230, 233, 236);
    self.title=@"公告列表";
    [self.view addSubview:self.tableview];
    //设置下个页面返回按钮的title为返回
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    
    backItem.title = @"返回";
    
    self.navigationItem.backBarButtonItem = backItem;
}
-(void)LoadData
{

    [HttpEngine getNotifition:^(NSArray *dataArray)
     {
         _dataArr = [NSArray arrayWithArray:dataArray];
         _titleArr = [[NSMutableArray alloc]initWithCapacity:0];
         for (int i=0; i<_dataArr.count; i++)
                 {
                     HJNotifiton*hjn=_dataArr[i];
                     [_titleArr addObject:hjn.title];
                 }

         [_tableview reloadData];
     }];
}
#pragma mark - tableView 数据源代理方法 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:tableviewCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_titleArr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *view = [[UIView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, 1)];
    view.backgroundColor=RGB(230, 233, 236);
    [cell addSubview:view];
    return cell;
}
//MARK: - 点击 cell 的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HJNotifiton*hjn=_dataArr[indexPath.row];
    TodayShopViewController*todayVC=[[TodayShopViewController alloc]init];
    todayVC.tag=(int)hjn.article_id.integerValue;
    [self.navigationController pushViewController:todayVC animated:YES];

    
}
//采用懒加载
-(UITableView *)tableview
{

    if (!_tableview) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        [self.view addSubview:tableView];
        
        _tableview= tableView;
        
        tableView.dataSource = self;
        tableView.delegate = self;
        
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableviewCellIdentifier];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
    
}

@end
