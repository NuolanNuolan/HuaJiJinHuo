//
//  HomeViewViewController.m
//  HJApp
//
//  Created by 袁联林 on 16/9/12.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "HomeViewViewController.h"
#import "HttpEngine.h"
#import "UIImageView+WebCache.h"
#import "IdeaBackViewController.h"
#import "CooperateViewController.h"
#import "ChangCityViewController.h"
#import "LoginViewController.h"
#import "GuessV.h"
#import "IkenV.h"
#import "SDCycleScrollView.h"
#import "HJFlowersTableViewCell.h"
#import "FeedbackAndCooperationTableViewCell.h"
#import "MJRefresh.h"
@interface HomeViewViewController ()<CLLocationManagerDelegate,
UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,HJHomePush_FeedbackDelegate,HJHomePush_ClassificationDelegate>
{

    //主屏幕Size
    CGSize main_size;
    //定位相关
    BOOL _changeCity;
    //表格
    UITableView *_detailTabView;
    //滚动轮播图数据
    NSArray *_picDataArray;
    //鲜花图标数据数组
    NSArray *_FlowersArray;
    //下部分4个imageviwew数据数组
    NSArray *_FootArrar;
    //鲜花图标坐标相关
    CGFloat iconW ;
    CGFloat firstColumnsY ;
    CGFloat secondColumnsY ;

    int _count;
    
}
//自定义的Nav
@property (nonatomic, strong) UIView *topView;
//自定义Nav上的相关控件
@property (nonatomic, strong) UIImageView *mapImageView;
@property (nonatomic, strong) UIButton *downButton;


@end

@implementation HomeViewViewController
-(void)viewWillAppear:(BOOL)animated
{

    //刷新操作
    self.navigationController.navigationBarHidden=YES;
    self.cityLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"CITYNAME"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建相关UI
    [self CreateUI];
    //地图定位
    [self MapLocation];
    //隐藏Nav自定义Nav
    [self CustomNavigationController];
    //创建表格以及滚动视图
    [self CreateTableview];
    //滚动视图
//    [self CreateScrollview];
    //加载数据
    [self LoadData];
    //添加下拉刷新
    [self Refresh];
}
-(void)Refresh
{

    
    _detailTabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 获取网络类型
        MSCNetworkType type = [MSCNetworkTypeMonitor sharedInstance].networkType;
        if ([[self networkTypeName:type] isEqualToString:@"NotReachable"]) {
             [_detailTabView.mj_header endRefreshing];
        }
        else
        {
            [self LoadData];
        }
        
    }];
    
}
#pragma mark 加载数据
-(void)LoadData{

    
    //GCD 当网络数据全部请求完成时再加载数据
//    dispatch_queue_t queue = dispatch_g et_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_group_t group = dispatch_group_create();
//    
//    dispatch_group_async(group, queue, ^{
//        [NSThread sleepForTimeInterval:1];
//        MYLOG(@"group1");
//    });
//    dispatch_group_async(group, queue, ^{
//        [NSThread sleepForTimeInterval:2];
//        MYLOG(@"group2");
//    });
//    dispatch_group_async(group, queue, ^{
//        [NSThread sleepForTimeInterval:9];
//        MYLOG(@"group3");
//    });
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        MYLOG(@"updateUi");  
//    });
    
    //滑动轮播图部分
    [HttpEngine getPictureWithTime:@"YES" with:^(NSArray *dataArray)
     {
         _picDataArray=[NSArray arrayWithArray:dataArray];
         [_detailTabView reloadData];
         [_detailTabView.mj_header endRefreshing];
//         [self CreateScrollview];
         
     }];
    //鲜花图标等
    [HttpEngine getHomeNav:^(NSArray *dataArray) {
        
        _FlowersArray = [NSArray arrayWithArray:dataArray];
        [_detailTabView reloadData];
        
    }];
    //4个imageview数据
    [HttpEngine getAdvertisingFigurecompletion:^(NSArray *dataArray) {
        if (dataArray.count>0) {
            _FootArrar = [NSArray arrayWithArray:dataArray];
//            GetAdvertising *model = dataArray[0];
            [_detailTabView reloadData];
            
        }
    }];
    //如果登录,获取购物车信息并改变tabbar值
    NSString*login=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    if (login )
    {
        [HttpEngine getSimpleCart:^(NSArray *array) {
            
            NSInteger number = 0;
            for (NSInteger i=0; i<array.count; i++) {
                ShopingCar*shCa=array[i];
                number += [shCa.number integerValue];
            }
            if(number>0)
            {
                [self updateCartCount:[NSString stringWithFormat:@"%ld",(long)number]];
            }
        }];
    }
    
    
    
}
#pragma mark 页面布局相关
-(void)CreateUI
{

    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    self.title=@"首页";
    self.view.backgroundColor=RGB(230, 233, 236);
    //鲜花坐标相关
    CGRect rect = [[UIScreen mainScreen] bounds];
    main_size = rect.size;
    iconW = main_size.width/15 * 2;
    firstColumnsY = main_size.height * 0.02;
    secondColumnsY = iconW + 20 + firstColumnsY * 2;

    _count = 1;
    
    
    
    
}
#pragma mark 自定义Nav
-(void)CustomNavigationController
{

    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, main_size.width, 64)];
    
    self.topView.backgroundColor = RGB(42, 125, 227);
    [self.view addSubview:self.topView];
    
    self.mapImageView = [[UIImageView alloc] init];
    self.mapImageView.image = [UIImage imageNamed:@"Map.png"];
    self.mapImageView.frame = CGRectMake(main_size.width * 0.035, 34, 15, 20);
    [self.topView addSubview:self.mapImageView];
    
    self.cityLabel = [[UILabel alloc] init];
    self.cityLabel.frame = CGRectMake(main_size.width * 0.085, 32, main_size.width * 0.21, 20);
    
    NSString*cityName=[[NSUserDefaults standardUserDefaults]objectForKey:@"CITYNAME"];
    if (cityName!=NULL)
    {
        self.cityLabel.text = cityName;
    }
    else
        self.cityLabel.text = @"获取中";
    
    self.cityLabel.textColor = [UIColor whiteColor];
    self.cityLabel.backgroundColor = [UIColor clearColor];
    //self.cityLabel.font = [UIFont systemFontOfSize:14];
    self.cityLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.topView addSubview:self.cityLabel];
    
    self.downButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.downButton.frame = CGRectMake(0, 38, 80, 30);
    UIImage *downImage = [UIImage imageNamed:@"swiper-market-btn-b.png"];
    downImage = [downImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.downButton setImage:downImage forState:UIControlStateNormal];
    [self.downButton setContentEdgeInsets:UIEdgeInsetsMake(0, 65, 22, 0)];
    //[self.downButton setBackgroundColor:[UIColor redColor]];
    [self.downButton addTarget:self action:@selector(changeCityBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.downButton];
    //添加右上角搜索按钮
    UIButton *btn = [[UIButton alloc]initWithFrame:CGMAKE(SCREEN_WIDTH-24-18, 29, 24, 24)];
    [btn setImage:[UIImage imageNamed:@"iconfont_sou"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:btn];

}
#pragma mark 创建表格以及滚动视图
-(void)CreateTableview
{

    _detailTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)style:UITableViewStyleGrouped];
    _detailTabView.backgroundColor = [UIColor clearColor];
    _detailTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _detailTabView.showsVerticalScrollIndicator =NO;
    _detailTabView.delegate = self;
    _detailTabView.dataSource = self;
    [self.view addSubview:_detailTabView];
    
    
    
}
#pragma mark 表格相关delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0)
    {
    
        static NSString *identifer=@"cell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_FlowersArray.count>0) {
            for (int i=0; i<[_FlowersArray count]-4; i++) {
                NSString *icon = [_FlowersArray[i] objectForKey:@"alias"];
                NSInteger category = [[_FlowersArray[i] objectForKey:@"id"] integerValue];
                NSString *title = [_FlowersArray[i] objectForKey:@"name"];
                UIButton *navButton = [self createFlowerIcon:icon category:category title:title];
                
                if(i < 4){
                    NSInteger pos = i * 3 + 1 ;
                    navButton.frame = CGRectMake(pos * main_size.width/13, firstColumnsY, iconW, iconW);
                }else{
                    NSInteger pos = (i-4) * 3 + 1 ;
                    navButton.frame = CGRectMake(pos * main_size.width/13, secondColumnsY, iconW, iconW);
                }
                cell.backgroundColor = [UIColor whiteColor];
                [cell addSubview:navButton];
            }
        }
        return cell;

    }else if (indexPath.row==1)
    {
        static NSString *identifer=@"cell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        if (_FlowersArray.count>0) {
            for (int i=4; i<[_FlowersArray count]; i++) {
                NSString *icon = [_FlowersArray[i] objectForKey:@"alias"];
                NSInteger category = [[_FlowersArray[i] objectForKey:@"id"] integerValue];
                NSString *title = [_FlowersArray[i] objectForKey:@"name"];
                UIButton *navButton = [self createFlowerIcon:icon category:category title:title];
                
                if(i < 4){
                    NSInteger pos = i * 3 + 1 ;
                    navButton.frame = CGRectMake(pos * main_size.width/13, firstColumnsY, iconW, iconW);
                }else{
                    NSInteger pos = (i-4) * 3 + 1 ;
                    navButton.frame = CGRectMake(pos * main_size.width/13, firstColumnsY, iconW, iconW);
                }
                
                cell.backgroundColor = [UIColor whiteColor];
                [cell addSubview:navButton];
            }
        }
        
        return cell;
        

    }
    else if(indexPath.row==2)
    {
    
        static NSString *ID = @"Flowers";
        HJFlowersTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:ID];
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HJFlowersTableViewCell" owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate =self;
        //传入数据进入cell
        [cell GetDataArr:_FootArrar];
        //模拟cell之间的间隔
        UIView *view = [[UIView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, 10)];
        view.backgroundColor = RGB(230, 233, 236);
        [cell addSubview:view];
        return cell;
    }
    else
    {
    
        static NSString *ID = @"cell";
        FeedbackAndCooperationTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:ID];
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FeedbackAndCooperationTableViewCell" owner:self options:nil]lastObject];
        cell.delegate=self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row==0)
    {
        
        return iconW+firstColumnsY+(secondColumnsY-firstColumnsY-iconW);
    }
    else if(indexPath.row==1)
    {
    
        return iconW+firstColumnsY+(secondColumnsY-firstColumnsY-iconW);

    }
    else if(indexPath.row==2)
    {
    
        return SCREEN_HEIGHT/3.68+10;
    }
    else
    {
    
        return 46;
        
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return SCREEN_HEIGHT/4.5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    NSMutableArray *imageurl = [[NSMutableArray alloc]initWithCapacity:0];
    if (_picDataArray.count>0) {
        
        for (GetPic *pic  in _picDataArray) {
            [imageurl addObject:pic.pictureUrlStr];
        }
    }
    UIView *adView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/4.5)];
    adView.backgroundColor = [UIColor clearColor];
    SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, adView.frame.size.width, adView.frame.size.height) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"pic_banner_pre"];
    cycleScrollView3.pageDotImage = [UIImage imageNamed:@"pic_banner"];
        cycleScrollView3.placeholderImage = [UIImage imageNamed:@"WechatIMG97"];
    cycleScrollView3.imageURLStringsGroup = imageurl;
    cycleScrollView3.autoScrollTimeInterval = 3;
    [adView addSubview:cycleScrollView3];
    
    
    return adView;
}

#pragma mark 滚动视图
-(void)CreateScrollview
{

    NSMutableArray *imageurl = [[NSMutableArray alloc]initWithCapacity:0];
    if (_picDataArray.count>0) {
        
        for (GetPic *pic  in _picDataArray) {
            [imageurl addObject:pic.pictureUrlStr];
        }
    }
    
    UIView *adView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/4.5)];
    adView.backgroundColor = [UIColor whiteColor];
    SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, adView.frame.size.width, adView.frame.size.height) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"pic_banner_pre"];
    cycleScrollView3.pageDotImage = [UIImage imageNamed:@"pic_banner"];
//    cycleScrollView3.placeholderImage = [UIImage imageNamed:@"bg_home_banner"];
    cycleScrollView3.imageURLStringsGroup = imageurl;
    cycleScrollView3.autoScrollTimeInterval = 3;
    [adView addSubview:cycleScrollView3];
    
    _detailTabView.tableHeaderView = adView;

}
#pragma mark - SDCycleScrollViewDelegate广告循环代理

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    NSString*isTag=@"1";
    [[NSUserDefaults standardUserDefaults]setObject:isTag forKey:@"TWOTAG"];
    self.tabBarVC.selectedIndex=1;
    
}


#pragma mark 地图定位
-(void)MapLocation
{

    self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;
    self.manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.manager.distanceFilter = 5.0f;
    
    if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.manager requestWhenInUseAuthorization];
        
    }
    if([CLLocationManager locationServicesEnabled]){
        [self.manager startUpdatingLocation];
    }else{
        MYLOG(@"Please enable location service.");
    }

    
}
#pragma mark 地图定位相关delegate
-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *newLocation = [locations lastObject];
    CLLocation *oldLocation;
    if (locations.count > 1)
    {
        oldLocation = [locations objectAtIndex:locations.count-2];
    }
    else
    {
        oldLocation = nil;
    }
    MYLOG(@"didUpdateToLocation %@ from %@", newLocation, oldLocation);
    
    NSString*cityName=[[NSUserDefaults standardUserDefaults]objectForKey:@"CITYNAME"];
    if(cityName != nil){
        [self.manager stopUpdatingLocation];
        return;
    }
    //额外开辟一块线程,单独处理数据   用于处理耗时操作
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //获取城市定位
        NSString *lat = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
        NSString *lng = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
        [HttpEngine convertCityName:lat withLng:lng complete:^(NSDictionary *dataDic) {
            MYLOG(@"%@",dataDic);
            
            [[NSUserDefaults standardUserDefaults]setObject:dataDic[@"code"] forKey:@"CODE"];
            [[NSUserDefaults standardUserDefaults]setObject:dataDic[@"name"] forKey:@"CITYNAME"];
            [[NSUserDefaults standardUserDefaults]setObject:dataDic[@"allowed_regions"] forKey:@"ALLOWED_REGIONS"];
            [[NSUserDefaults standardUserDefaults]setObject:dataDic[@"allowed_regions_name"] forKey:@"ALLOWED_REGIONS_NAME"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.cityLabel.text = dataDic[@"name"];
            });
            
            
        } failure:^(NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               if (_changeCity==NO)
                               {
                                   [self changeCityBtn];
                                   _changeCity=YES;
                               }
                               
                               
                           });
            
        }];
        
        
    });
    
    // 停止位置更新
    [self.manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    MYLOG(@"地图定位错误--%@",error);
}


//右上角搜索事件
- (void)rightSearchBtn {
    
    NSString*locatioanStr=[[NSUserDefaults standardUserDefaults]objectForKey:@"CODE"];
    if (!locatioanStr) {
        //选择城市
        [self alert];
        return;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入关键词查询:" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    }];
    UIAlertAction *defaul = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *str = alert.textFields[0].text;
        if (![str isEqualToString:@""]) {
            //将值存入
            [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"SEARCH"];
            //跳到分类执行搜索
            self.tabBarVC.selectedIndex=1;
            
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    [alert addAction:defaul];
    [self presentViewController:alert animated:YES completion:nil];
}
//选择城市
-(void)alert
{
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您还未选择城市" preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction*cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction*action)
                          {
                              
                          }];
    UIAlertAction*defaultAction=[UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action)
                                 {
                                     ChangCityViewController*changVC=[[ChangCityViewController alloc]init];
                                     changVC.hidesBottomBarWhenPushed=YES;
                                     [self.navigationController pushViewController:changVC animated:YES];
                                 }];
    [alert addAction:cancel];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
//城市切换按钮
-(void)changeCityBtn
{
    ChangCityViewController*changVC=[[ChangCityViewController alloc]init];
    changVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:changVC animated:YES];
    
}
//改变购物车tabbar值
-(void) updateCartCount:(NSString *) number{
    
    UITabBarItem *item = [self.tabBarVC.tabBar.items objectAtIndex:3];
    
    if(number){
        item.badgeValue = number;
    }
    else
    {
        item.badgeValue = nil;
    }
}
//创建按钮
- (UIButton*) createFlowerIcon:(NSString *)image category:(NSInteger) cid title:(NSString *) title
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    NSURL*urlStr=[NSURL URLWithString:[NSString stringWithFormat:@"http://jinhuo.huaji.com/static/images/index-%@.png",image]];
    [button sd_setBackgroundImageWithURL:urlStr forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = NJNameFont;
    [button setTitleColor:NJFontColor forState:UIControlStateNormal];
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.tag = cid;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -5.0, -20.0, -5.0)];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
//鲜花按钮点击事件
-(void)btnClick:(UIButton *)sender
{

    NSString*isTag=[NSString stringWithFormat:@"%lu",(long)sender.tag];
    [[NSUserDefaults standardUserDefaults]setObject:isTag forKey:@"TWOTAG"];
    self.tabBarVC.selectedIndex=1;
    
}
//4个imageview点击事件
-(void)HomePushClassification
{

    self.tabBarVC.selectedIndex=1;
}
//按钮跳转至意见反馈商务合作页面
-(void)HomePushFeed:(NSString *)tag
{

    if ([tag isEqualToString:@"1"]) {
        
        IdeaBackViewController*ideaVC=[[IdeaBackViewController alloc]init];
       ideaVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ideaVC animated:YES];
    }else
    {
    
        CooperateViewController*cooperateVC=[[CooperateViewController alloc]init];
        cooperateVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cooperateVC animated:YES];

        
    }
}
@end
