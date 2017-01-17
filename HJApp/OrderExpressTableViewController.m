//
//  OrderExpressTableViewController.m
//  HJApp
//
//  Created by Bruce on 16/3/23.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "OrderExpressTableViewController.h"
#import "OrderExpressTableViewFrame.h"
#import "OrderExpressTableViewCell.h"
#import "BWCommon.h"

@interface OrderExpressTableViewController ()

@property(nonatomic,assign) NSArray *routeList;

@property (nonatomic, strong) NSArray *statusFrames;

@end

#define VIEW_WIDTH self.view.bounds.size.width
#define VIEW_HEIGHT self.view.bounds.size.height

@implementation OrderExpressTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self pageLayout];
}

-(void)pageLayout{

    
    self.navigationController.navigationBarHidden=NO;

    self.title=@"物流信息";
    
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]init];
    backItem.title=@"";
    backItem.image=[UIImage imageNamed:@""];
    self.navigationItem.backBarButtonItem=backItem;
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
    
    [self loadData];
}

-(void) loadData{
    
    [HttpEngine queryOrderExpress:self.order_no complete:^(NSArray *array) {
        
        self.routeList = array;
        self.statusFrames = nil;
        [self.tableView reloadData];

    } failure:^(NSError *error) {

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.routeList count] <= 0)
        return 1;
    
    return [self.routeList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.routeList count] <= 0)
        return 0;
    
    return [[self.routeList[section] objectForKey:@"traces"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    OrderExpressTableViewCell *cell = [OrderExpressTableViewCell cellWithTableView:tableView];
    
    cell.viewFrame = self.statusFrames[indexPath.section][indexPath.row];
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);

    return cell;
}



-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *orderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 50)];
    [orderView setBackgroundColor:[BWCommon getRGBColor:0xffffff]];
    
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order-ddh"]];
    iconView.frame = CGRectMake(10, 10, 24, 24);
    
    [orderView addSubview:iconView];
    
    UILabel *orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 15, VIEW_WIDTH-50, 20)];
    
    if(self.routeList.count > 0){
        NSString *orderText = [NSString stringWithFormat:@"物流单号：%@",[self.routeList[section] objectForKey:@"mailno"]];
        orderLabel.text = orderText;
    }
    else{
        NSString *orderText = @"暂无物流信息";
        orderLabel.text = orderText;
    }
    
    
    [orderView addSubview:orderLabel];
    
    return orderView;
}
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OrderExpressTableViewFrame *vf = self.statusFrames[indexPath.section][indexPath.row];
    
    return vf.cellHeight;
}

- (NSArray *)statusFrames
{
    if (_statusFrames == nil) {
        
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:self.routeList.count];
        
        for (NSDictionary *dict in self.routeList) {
            // 创建模型
            NSMutableArray *traceModels = [NSMutableArray arrayWithCapacity:[[dict objectForKey:@"traces"] count]];
            for (NSDictionary *traceDict in [dict objectForKey:@"traces"]){
                OrderExpressTableViewFrame *vf = [[OrderExpressTableViewFrame alloc] init];
                vf.data = traceDict;
                [traceModels addObject:vf];
            }
            [models addObject:traceModels];
        }
        self.statusFrames = [models copy];
    }
    
    return _statusFrames;
}
@end
