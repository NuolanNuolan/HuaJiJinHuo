//
//  AssortPageViewController.m
//  HJApp
//
//  Created by Bruce He on 15/10/30.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "AssortPageViewController.h"
#import "AssortTableViewCell.h"
#import "RightAssortTableViewCell.h"
#import "HttpEngine.h"
#import "UIImageView+WebCache.h"
#import "MyBtn.h"
#import "MyPropBtn.h"
#import "ShopingPageViewController.h"
#import "LoginViewController.h"
#import "SVPullToRefresh.h"
#import "ChangCityViewController.h"
#import "SJAvatarBrowser.h"


@interface AssortPageViewController ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UIScrollViewDelegate,UIGestureRecognizerDelegate>
{

    //上个界面传来的搜索值
    NSString *search_str;
    //大图
    UIImageView *imageview_bigview;
}

@property (nonatomic, strong) UITableView *leftTableV;
@property (nonatomic, strong) UITableView *rightTableV;
@property (nonatomic, strong) UICollectionView *myCollecV;
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) NSMutableArray *beginArr;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSMutableDictionary *sendDic;
@property (nonatomic, strong) UILabel *hdViewLabel;
@property (nonatomic, strong) UIScrollView *myScrollV;
@property (nonatomic, strong) NSMutableArray *BtnArr;
@property(nonatomic,strong)UILabel*numLabel;
@property (nonatomic, strong) UIView *shopView;
@property (nonatomic, strong) UILabel *tomoniL;
@property (nonatomic, strong) UIButton *kessanBtn;
@property (nonatomic, strong) UILabel *okaneLabel;
@property (nonatomic, strong) UIImageView *shopCarIV;
@property(nonatomic,strong)NSArray*floerNameArray;
@property(nonatomic,strong)NSMutableArray*floerDetailArray;
@property(nonatomic,strong)UIView*headView;
@property(nonatomic,strong)NSArray*catalogueArray;
@property(nonatomic,strong)UILabel*colorLable;
@property(nonatomic,strong)MyBtn*chooseBtn;
@property (nonatomic,strong) UIView *assortTopView;
@property (nonatomic,strong) UIView *assortTopViewHide;
@property(nonatomic,strong)UIScrollView*titleBtnScrollView;
@property(nonatomic,strong)NSArray*carArray;
@property(nonatomic,strong)NSMutableArray*catalogueStrArray;
@property (nonatomic,unsafe_unretained)CGRect btnRect;
//添加减少按钮对应的购物车数组
@property(nonatomic,strong)NSArray*btnCarArray;
@property(nonatomic,strong)NSMutableArray *cartList;
@property(nonatomic,copy)NSString *sendArea;
@property(nonatomic,unsafe_unretained)NSInteger areaRow;
@property(nonatomic,unsafe_unretained)NSInteger areaSection;
@property (nonatomic,strong) MBProgressHUD *hud;

@property (nonatomic,retain) NSMutableArray *photos;

@end

#define VIEW_WIDTH self.view.bounds.size.width
#define VIEW_HEIGHT self.view.bounds.size.height

#define LBVIEW_WIDTH1 [UIScreen mainScreen].bounds.size.width
#define LBVIEW_HEIGHT1 [UIScreen mainScreen].bounds.size.height
#define LEFTTABLE_WITH self.view.frame.size.width/3.5

@implementation AssortPageViewController

NSInteger page;
NSString *cid;
NSString *locatioanStr;
NSInteger btnRow;
NSInteger btnSection;
static dispatch_once_t onceT;

//视图将要出现  刷新数据
-(void)viewWillAppear:(BOOL)animated
{
    
    
    self.sendArea = @"";
    
    
    //判断发货地
    NSString*str=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*code=[[NSUserDefaults standardUserDefaults]objectForKey:@"CODE"];
    if (str&&code)
    {
        self.sendArea = [[NSUserDefaults standardUserDefaults]objectForKey:@"AREA"];
        if (!self.sendArea) {
            [HttpEngine getConsumerData:^(NSDictionary*dataDic) {
                if (dataDic) {
                       NSString *defaultDelivery = dataDic[@"default_delivery"];
                if ([defaultDelivery isEqualToString:@"none"]) {
                    [HttpEngine getAreaDataLocation:code completion:^(NSArray *dataArray) {
                        [self choosePlaceAlert:dataArray];
                    }];
                } else {
                    if ([defaultDelivery isEqualToString:@"local"]) {
                        self.sendArea = @"本地";
                    } else {
                        self.sendArea = @"昆明";
                    }
                    [[NSUserDefaults standardUserDefaults]setObject:self.sendArea forKey:@"AREA"];
                }
            }
            }];
            
        }
    }

    //self.title=@"选择品类";
    [HttpEngine getAllFlower:^(NSArray *dataArray)
     {
         //左Uitableview
         _floerNameArray=dataArray;
         [self judgeIsTag];
         
     }];

    if(!_rightTableV)
    {
      [self performSelector:@selector(getRightData) withObject:nil afterDelay:1];
    }
    [HttpEngine getSimpleCart:^(NSArray *array)
     {
        _cartList = [array mutableCopy];
     }];
    //判断首页是否传了搜索值
    search_str = [[NSUserDefaults standardUserDefaults]objectForKey:@"SEARCH"];
    
    if (search_str!=nil) {
        //执行搜索
        [self Search:search_str];
    }

}


-(void)judgeIsTag
{
    //获取上个页面所选取的种类
    NSString*isTagStr=[[NSUserDefaults standardUserDefaults]objectForKey:@"TWOTAG"];
    if (isTagStr)
    {
        cid = isTagStr;
        //_isTag=[isTagStr intValue];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"TWOTAG"];
        //MYLOG(@"_isTag===%@",cid);
        page = 1;
        
        NSInteger tag = 0;//[isTagStr integerValue];
        
        for(int i=0;i<[_floerNameArray count];i++){
            AllFlower *flower =_floerNameArray[i];
            NSInteger flowerId = [flower.flowerId integerValue];
            if(flowerId == [cid integerValue]){
                tag = i;
                MYLOG(@"selected %@ %@",flower.flowerId,cid);
                break;
            }
        }
        
        NSIndexPath *index1 = [NSIndexPath indexPathForItem:tag inSection:0];
        
        [self.leftTableV selectRowAtIndexPath:index1 animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self didSelectLeftTableView:tag];

    } else {
        AllFlower*flower=_floerNameArray[_isTag];
        [HttpEngine getProduct:flower.flowerId completion:^(NSArray *dataArray)
         {
             _catalogueArray=dataArray;
             [self updataCatalogueStrArray];
             [self setCatalogue];

         }];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     _hud = [BWCommon getHUD];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent =NO;
    self.navigationItem.hidesBackButton=YES;
     _catalogueStrArray=[[NSMutableArray alloc]init];
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    page=1;
    cid = @"1";
    _cartList = [[NSMutableArray alloc] init];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapClick)];
    [doubleTap setNumberOfTapsRequired:2];
    doubleTap.delegate = self;
    [self.view addGestureRecognizer:doubleTap];
    
    self.photos = [[NSMutableArray alloc] init];

    //search
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconfont_sou"] style:UIBarButtonItemStylePlain target:self action:@selector(rightSearchBtn)];
}
- (void)rightSearchBtn {
    
    NSString*locatioanStr=[[NSUserDefaults standardUserDefaults]objectForKey:@"CODE"];
    if (!locatioanStr) {
        [self alert];
        return;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入关键词查询:" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    }];
    UIAlertAction *defaul = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         NSString *str = alert.textFields[0].text;
        if (![str isEqualToString:@""]) {
            
            [self Search:str];
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    [alert addAction:defaul];
    [self presentViewController:alert animated:YES completion:nil];
}
//搜索
-(void)Search:(NSString *)str{

    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"SEARCH"];
    [HttpEngine goodsSearchWithLocation:[[NSUserDefaults standardUserDefaults]objectForKey:@"CODE"] withGoodsName:str with:^(NSArray *dataArray) {
        [self.photos removeAllObjects];
        _floerDetailArray = [dataArray mutableCopy];
        for(NSInteger i=0;i<[dataArray count];i++){
            FlowerDetail*flow = dataArray[i];
            NSString *image_url = flow.image;
            [self.photos addObject:image_url];
            
        }
        [_rightTableV reloadData];
        
    }];
}
//获取右边tableview数据
-(void)getRightData
{
    [self showRightTableView];
    page = 1;
    [self loadDetailData];
    [self showLeftTableView];
    [self.assortTopViewHide removeFromSuperview];
}

#pragma  mark-------分类栏设置
-(void)setCatalogue
{
    [_assortTopView removeFromSuperview];
    FlowerCatalogue*flower=_catalogueArray[0];
    
    _assortTopView=[[UIView alloc] initWithFrame:CGRectMake(90, 0, LBVIEW_WIDTH1-90, 70+10)];
    _assortTopView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_assortTopView];
    
    _colorLable=[[UILabel alloc] initWithFrame:CGRectMake(5, 15,60, 20)];
    _colorLable.text=flower.name;
    _colorLable.textAlignment=NSTextAlignmentCenter;
    _colorLable.textColor=NJFontColor;
    _colorLable.font=NJTitleFont;
    [_assortTopView addSubview:_colorLable];
    
    _titleBtnScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(70, 10, LBVIEW_WIDTH1-LBVIEW_WIDTH1/3.5-60, 30)];
    _titleBtnScrollView.contentSize=CGSizeMake(65*flower.catalogueArray.count+40, 20);
    _titleBtnScrollView.showsHorizontalScrollIndicator=NO;
    _titleBtnScrollView.bounces=NO;
    _titleBtnScrollView.tag=100;
    [_assortTopView addSubview:_titleBtnScrollView];
    
    for (NSInteger i=0; i<flower.catalogueArray.count; i++)
    {
        NSArray*array=flower.catalogueArray;
        NSDictionary*dic=array[i];
        MyPropBtn *btn=[[MyPropBtn alloc] initWithFrame:CGRectMake(65*i+5, 5, 60, 20)];
        [btn setTitle:dic[@"aliasname"] forState:UIControlStateNormal];
        [btn.layer setBorderColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1].CGColor];
        btn.section=0;
        btn.row=i;
        btn.tag=1000+i;
        [btn.titleLabel setTextColor:NJFontColor];
        [btn setTitleColor:[UIColor colorWithRed:84/255.0 green:159/255.0 blue:255/255.0 alpha:1] forState:UIControlStateSelected];
        [btn.titleLabel setFont:NJNameFont];
        btn.titleStr = dic[@"aliasname"];
        btn.selected=NO;
        
        
        NSString*propStr=[NSString stringWithFormat:@"%@:%@",dic[@"props"],dic[@"id"]];
        btn.accessibilityLabel=propStr;
        
        if ([dic[@"aliasname"]isEqualToString:_sendArea]) {
            btn.selected = YES;
            [btn changeStyle];
            self.areaSection = 100;
            self.areaRow = i+1000;
        }

        [btn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_titleBtnScrollView addSubview:btn];
    }
    
    
    _chooseBtn=[[MyBtn alloc]initWithFrame:CGRectMake((LBVIEW_WIDTH1-90-100)/2, 35, 100, 70-20)];
    [_chooseBtn setTitle:@"更多筛选" forState:UIControlStateNormal];
    _chooseBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [_chooseBtn setTitleColor:[UIColor colorWithRed:37/255.0 green:119/255.0 blue:188/255.0 alpha:1] forState:UIControlStateNormal];
    [_chooseBtn addTarget:self action:@selector(shouSuo) forControlEvents:UIControlEventTouchUpInside];
    _chooseBtn.isOpen=NO;
    [_assortTopView addSubview:_chooseBtn];
    
    
    for (int i=0; i<2; i++)
    {
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(5+((LBVIEW_WIDTH1-90)/2+45)*i, 60, (LBVIEW_WIDTH1-90-110)/2, 2)];
        label.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        [_assortTopView addSubview:label];
    }
    
    dispatch_once(&onceT, ^{
        self.assortTopViewHide = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LBVIEW_WIDTH1-90, 70+10)];
        self.assortTopViewHide.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        [self.assortTopView addSubview:self.assortTopViewHide];
    });
}
//分类栏收缩
-(void)shouSuo
{
    if (_chooseBtn.isOpen==NO)
    {
        [_headView removeFromSuperview];
        [_chooseBtn setTitle:@"收起筛选" forState:UIControlStateNormal];
        _headView=[[UIView alloc]initWithFrame:CGRectMake(90, 70, LBVIEW_WIDTH1-90, 30*_catalogueArray.count)];
        _headView.backgroundColor=[UIColor whiteColor];
        
        for (int i=1; i<_catalogueArray.count; i++)
        {
            UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(5, 10+30*(i-1), 60, 20)];
            label.font=[UIFont systemFontOfSize:14];
            label.textAlignment=NSTextAlignmentCenter;
            [_headView addSubview:label];
            FlowerCatalogue*flower=_catalogueArray[i];
            label.text=flower.name;
            
            UIScrollView*btnScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(70, 5+30*(i-1), LBVIEW_WIDTH1-90-60, 30)];
            btnScrollView.contentSize=CGSizeMake(65*flower.catalogueArray.count+40, 20);
            btnScrollView.showsHorizontalScrollIndicator=NO;
            btnScrollView.bounces=NO;
            btnScrollView.tag=100+i;
            [_headView addSubview:btnScrollView];
            
            for (int j=0; j<flower.catalogueArray.count; j++)
            {
                NSDictionary*dic=flower.catalogueArray[j];
                
                MyPropBtn *btn=[[MyPropBtn alloc] initWithFrame:CGRectMake(65*j+5, 5, 60, 20)];
                [btn setTitle:dic[@"aliasname"] forState:UIControlStateNormal];
                btn.titleStr = dic[@"aliasname"];
                [btn.layer setBorderColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1].CGColor];
                btn.section=i;
                btn.row=j;
                
                [btn.titleLabel setTextColor:NJFontColor];
                [btn  setTitleColor:[UIColor colorWithRed:84/255.0 green:159/255.0 blue:255/255.0 alpha:1] forState:UIControlStateSelected];
                [btn.titleLabel setFont:NJNameFont];
                
                btn.tag=1000+j;
                btn.selected=NO;
               
                NSString*propStr=[NSString stringWithFormat:@"%@:%@",dic[@"props"],dic[@"id"]];
                btn.accessibilityLabel=propStr;
                if ([dic[@"aliasname"]isEqualToString:_sendArea]) {
                    btn.selected = YES;
                    [btn changeStyle];
                    self.areaSection = i+100;
                    self.areaRow = j+1000;
                }
                [btn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [btnScrollView addSubview:btn];
            }
        }
        [self.view addSubview:_headView];
    
        _rightTableV.frame=CGRectMake(90, 70+30*_catalogueArray.count, 5*LBVIEW_WIDTH1/6,LBVIEW_HEIGHT1-60-113-30*_catalogueArray.count);
    }
    else
    {
        [_chooseBtn setTitle:@"更多筛选" forState:UIControlStateNormal];
        _rightTableV.frame=CGRectMake(90, 80, 5*LBVIEW_WIDTH1/6, LBVIEW_HEIGHT1-80-113);
        [_headView removeFromSuperview];
    }
    _chooseBtn.isOpen=!_chooseBtn.isOpen;
    
}

-(void) setBottomBorder:(UIView *)view color:(UIColor *)color{
    
    [view sizeToFit];
    CALayer* layer = [view layer];
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderWidth = 1;
    bottomBorder.frame = CGRectMake(-1, layer.frame.size.height, layer.frame.size.width, 1);
    [bottomBorder setBorderColor:color.CGColor];
    [layer addSublayer:bottomBorder];
}

#pragma  mark ----- leftTableView
-(void)showLeftTableView
{
    //MYLOG(@"_floerNameArray==%@",_floerNameArray);
    self.leftTableV=[[UITableView alloc] initWithFrame:CGRectMake(0,0, 90,  self.view.bounds.size.height * 0.70) style:UITableViewStylePlain];
    self.leftTableV.delegate=self;
    self.leftTableV.dataSource=self;
    self.leftTableV.showsVerticalScrollIndicator = NO;
    //self.leftTableV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.leftTableV.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.leftTableV];
    
    UIImageView*downImage=[[UIImageView alloc]initWithFrame:CGRectMake(25, self.view.bounds.size.height * 0.70 + 15, 40, 20)];
    downImage.image=[UIImage imageNamed:@"swiper-market-btn-b.png"];
    [self.view addSubview:downImage];
  
}

#pragma  mark ----- rightTableView
//右视图
-(void)showRightTableView
{
    self.rightTableV=[[UITableView alloc] initWithFrame:CGRectMake(90, 10+70, 5*LBVIEW_WIDTH1/6, LBVIEW_HEIGHT1-80-113) style:UITableViewStyleGrouped];
    self.rightTableV.delegate=self;
    self.rightTableV.dataSource=self;
    [self.view addSubview:self.rightTableV];
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.rightTableV setTableFooterView:v];
    
    __weak AssortPageViewController *weakSelf = self;
    [self.rightTableV addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    }];
    
    
}

- (void) loadDetailData{
    
     [_hud removeFromSuperview];
    if (search_str==nil) {
        
        locatioanStr=[[NSUserDefaults standardUserDefaults]objectForKey:@"CODE"];
        
        if (!locatioanStr)
            return;
        
        NSString *onlyOne = [[NSUserDefaults standardUserDefaults]objectForKey:@"ONLYONE"];
        if (onlyOne) {
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"ONLYONE"];
            NSString *path = NSHomeDirectory();
            path = [path stringByAppendingString:@"/Documents/onlyDic"];
            NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:path];
            [[NSFileManager defaultManager]removeItemAtPath:path error:nil];
            NSMutableArray *mutArray = [[NSMutableArray alloc]init];
            FlowerDetail *flow=[FlowerDetail getAllFlowerDictionary:dic];
            [mutArray addObject:flow];
            _floerDetailArray = mutArray;
            [_rightTableV reloadData];
            return;
        }
        
        [HttpEngine getProductDetail:cid withLocation:locatioanStr withProps:_catalogueStrArray withPage:[NSString stringWithFormat:@"%ld",(long)page] withPageSize:@"10" completion:^(NSArray *dataArray)
         {
             //右uitableview
             if(page == 1){
                 self.photos = [[NSMutableArray alloc] init];
                 _floerDetailArray = [dataArray mutableCopy];
                 
             }else{
                 [_floerDetailArray addObjectsFromArray:[dataArray mutableCopy]];
             }
             
             for(NSInteger i=0;i<[dataArray count];i++){
                 FlowerDetail*flow = dataArray[i];
                 NSString *image_url = flow.image;
                [self.photos addObject:image_url];
                 
             }
             
             [_rightTableV reloadData];
         }];
        
    }
    

   
}

- (void)insertRowAtBottom
{
    __weak AssortPageViewController *weakSelf = self;
    if (_floerDetailArray.count==0)
    {
        [weakSelf.rightTableV.infiniteScrollingView stopAnimating];
        return;
    }
    
    [weakSelf.rightTableV beginUpdates];
    page++;
    [self loadDetailData];
    
    [weakSelf.rightTableV endUpdates];
    [weakSelf.rightTableV.infiniteScrollingView stopAnimating];
    
}

//条件按钮
-(void)selectBtnClick:(MyPropBtn *)sender
{
    
    //判断有没有选择城市
    NSString*code=[[NSUserDefaults standardUserDefaults]objectForKey:@"CODE"];
    if (!code)
    {
        [self alert];
        return;
    }
    
    //移除内定的
    NSString*tokenStr=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    if (tokenStr) {
    UIView *superView =self.areaSection==100 ?_assortTopView:_headView;
        
        if (sender.section==(self.areaSection-100)&&sender.tag!=self.areaRow) {
            UIScrollView*scrollView=[superView viewWithTag:self.areaSection];
            MyPropBtn*mbtn=[scrollView viewWithTag:self.areaRow];
            mbtn.selected=NO;
            [mbtn removeSelectedStyle];
        }
    
    if ([sender.titleStr isEqualToString:@"本地"]) {
        self.sendArea = @"本地";
    }
    else if ([sender.titleStr isEqualToString:@"昆明"]) {
        self.sendArea = @"昆明";
    }
    [[NSUserDefaults standardUserDefaults]setObject:self.sendArea forKey:@"AREA"];
    }
    
    AllFlower*flower=_floerNameArray[_isTag];
    
    cid = flower.flowerId;
    
    NSString*str=sender.accessibilityLabel;
    
    //移除前后两次点击相同的
    for (int i=0; i<_catalogueStrArray.count; i++)
    {
        if ([str isEqualToString:_catalogueStrArray[i]])
        {
            [_catalogueStrArray removeObjectAtIndex:i];
            
            sender.selected=!sender.selected;
            
            [sender changeStyle];
            
            page = 1;
            [self loadDetailData];
            
            return;
        }
    }
    
    
    //将点击的不同行加到数组中
    
    if (_catalogueStrArray.count==0)
    {
        [_catalogueStrArray addObject:str];
    }
    else
    {
        for (int i=0; i<_catalogueStrArray.count; i++)
        {
            
            NSString*str1=[str substringToIndex:1];
            //MYLOG(@"str1===%@",str1);
            NSString*str2=[_catalogueStrArray[i] substringToIndex:1];
 
            if ([str1 isEqualToString:str2])
            {
                [_catalogueStrArray removeObjectAtIndex:i];
                [_catalogueStrArray addObject:str];
            }
            else
            {
                if (i==_catalogueStrArray.count-1)
                {
                    [_catalogueStrArray addObject:str];
                }
            }
        }
    }

    page = 1;
    [self loadDetailData];
    
    //选中状态与非选中的区别
    if (sender.tag==_lastTag[sender.section])
    {
        sender.selected=!sender.selected;
        [sender changeStyle];
        return;
    }
    if (sender.section==0)
    {
        if (_lastTag[0]!=0)
        {
            UIScrollView*scrollView=[_assortTopView viewWithTag:sender.section+100];
            MyPropBtn*btn=[scrollView viewWithTag:_lastTag[0]];
            btn.selected=NO;
            [btn removeSelectedStyle];
            
        }
        _lastTag[0]=(int)sender.tag;
    }
    else
    {
        if (_lastTag[sender.section]!=0)
        {
            UIScrollView*scrollView=[_headView viewWithTag:sender.section+100];
            MyPropBtn*btn=[scrollView viewWithTag:_lastTag[sender.section]];
            btn.selected=NO;
            [btn removeSelectedStyle];
            
        }
        _lastTag[sender.section]=(int)sender.tag;
    }
    sender.selected=!sender.selected;
    [sender changeStyle];
}

//左按钮
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.leftTableV]) {
        cell.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        UIColor *color = [[UIColor alloc] init];//通过RGB来定义自己的颜色
        color = [UIColor whiteColor];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        
        [cell.textLabel setTextColor:NJFontColor];
         [cell.textLabel setHighlightedTextColor:[UIColor colorWithRed:37/255.0 green:119/255.0 blue:188/255.0 alpha:1]];
        [cell.textLabel setFont:NJTitleFont];
        
    } else if ([tableView isEqual:self.rightTableV]) {
        cell.backgroundColor = [UIColor whiteColor];
        UIColor *color = [[UIColor alloc] init];//通过RGB来定义自己的颜色
        color = [UIColor whiteColor];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        
    }
}


//cell的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([tableView isEqual:self.leftTableV])
    {
        return _floerNameArray.count;
    }
    
    else if ([tableView isEqual:self.rightTableV])
    {
//        if (_isOpen[section]==NO)
//        {
//            return 0;
//        }
        FlowerDetail*dFlower=_floerDetailArray[section];
        
        return dFlower.dataArray.count;
    }
    return 0;
}

//行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.leftTableV]) {
        return 50;
    }
    
    else if ([tableView isEqual:self.rightTableV]) {
        
        return 45;
    }
    return 0;
}

//区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  
    if ([tableView isEqual:self.leftTableV])
    {
        return 1;
    }
    
    else if ([tableView isEqual:self.rightTableV]) {
        
        return _floerDetailArray.count;
    }
    return 0;
}

#pragma mark ------cellDetail

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView isEqual:self.leftTableV]) {
        
        AllFlower*flower=_floerNameArray[indexPath.row];
        
        AssortTableViewCell *cell= [tableView cellForRowAtIndexPath:indexPath];
        if (cell==nil) {
            cell=[[AssortTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
        }
        cell.textLabel.text=flower.name;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        //cell.textLabel.adjustsFontSizeToFitWidth=YES;
        cell.textLabel.textColor=NJFontColor;
        cell.textLabel.font=NJNameFont;
        
        return cell;
    }
    else if ([tableView isEqual:self.rightTableV]){
        
        FlowerDetail*dFlower=_floerDetailArray[indexPath.section];
        
        RightAssortTableViewCell *cell= [tableView cellForRowAtIndexPath:indexPath];
        if (cell==nil) {
            cell=[[RightAssortTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            UILabel*nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 20)];
            NSDictionary*dic=dFlower.dataArray[indexPath.row];
            nameLabel.text=dic[@"supplier_name"];
            //MYLOG(@"supplier_name===%@",dic[@"supplier_name"]);
            nameLabel.font=[UIFont systemFontOfSize:14];
            [cell addSubview:nameLabel];
            
            UILabel*priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 25, 50, 20)];
            priceLabel.font=[UIFont systemFontOfSize:12];
            priceLabel.text=[NSString stringWithFormat:@"¥%@",dic[@"price"]];
            priceLabel.textColor=[UIColor redColor];
            [cell addSubview:priceLabel];
            
            UILabel*detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 25, 100, 20)];
            detailLabel.font=[UIFont systemFontOfSize:12];
            detailLabel.text=[NSString stringWithFormat:@"库存:%@",dic[@"stocks"]];
            detailLabel.textColor=[UIColor grayColor];
            [cell addSubview:detailLabel];
            
            //添加按钮
            MyBtn*btn=[[MyBtn alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-90-45, 5, 44, 44)];
            [btn setImage:[UIImage imageNamed:@"AddGoods"] forState:UIControlStateNormal];
            [btn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
            [btn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=indexPath.section+100;
            btn.row=indexPath.row;
            [cell addSubview:btn];
            
           
            
            //获取购物车信息
            NSString*flowerStr=[NSString stringWithFormat:@"%@",dFlower.Id];
            
                 for (int i=0; i<_cartList.count; i++)
                 {
                     ShopingCar*shopCar=_cartList[i];
                     NSString*shopCarStr=[NSString stringWithFormat:@"%@",shopCar.skuId];
                     if ([flowerStr isEqualToString:shopCarStr])
                     {
                         NSDictionary*dic=dFlower.dataArray[indexPath.row];
                         NSString*str11=[NSString stringWithFormat:@"%@",dic[@"supplier"]];
                         NSString*str22=[NSString stringWithFormat:@"%@",shopCar.supplierId];
                         if ([str11 isEqualToString:str22])
                        {
                            //减少按钮
                            MyBtn*btn=[[MyBtn alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-90-95, 5, 44, 44)];
                            [btn setImage:[UIImage imageNamed:@"jian.png"] forState:UIControlStateNormal];
                            [btn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
                            
                            [btn addTarget:self action:@selector(subBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                            btn.tag=indexPath.section+500;
                            btn.row=indexPath.row;
                            [cell addSubview:btn];
                            
                            UILabel*numLabel=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-90-65, 15, 30, 20)];
                            numLabel.text=[NSString stringWithFormat:@"%@",shopCar.number];
                            numLabel.textColor=[UIColor blackColor];
                            numLabel.font=[UIFont systemFontOfSize:15];
                            numLabel.textAlignment=NSTextAlignmentCenter;
                            [cell addSubview:numLabel];
                        }
                         
                     }
                     
                 }
        }
        
        return cell;
    }
    return nil;
}

//添加按钮
-(void)addBtnClick:(MyBtn*)sender
{
    btnRow = sender.tag;
    btnSection = sender.row;
    
    //CGRect rect=[sender convertRect: sender.bounds toView:self.view];
    _btnRect = [sender convertRect:sender.bounds toView:self.view];
    
   
    
    for (int i=0; i<20; i++)
    {
        _addNum[i]=0;
    }
    [HttpEngine getSimpleCart:^(NSArray *array)
     {
        _cartList = [array mutableCopy];
         
         [self addFlower:sender];
    }];
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

#pragma mark  ------添加flower按钮
-(void)addFlower:(MyBtn*)sender
{
    
    FlowerDetail*dFlower=_floerDetailArray[sender.tag-100];
    NSDictionary*dic=dFlower.dataArray[sender.row];
    NSString*locatioanStr=[[NSUserDefaults standardUserDefaults]objectForKey:@"CODE"];
    NSString*flowerStr=[NSString stringWithFormat:@"%@",dic[@"sku"]];
    
    if (_cartList.count==0)
    {
        [HttpEngine addGoodsLocation:locatioanStr withSku:dic[@"sku"] withSupplier:dic[@"supplier"] withNumber:@"1" complete:^(NSString *error, NSString *errorStr) {
            if (error) {
                [self showError:errorStr];
            }else {
                [self showAnimationB:sender withF:dFlower];
            }
        }];
    }
    else
    {
        for (int i=0; i<_cartList.count; i++)
        {
            ShopingCar*shopCar=_cartList[i];
            NSString*shopCarStr=[NSString stringWithFormat:@"%@",shopCar.skuId];
           
            //区分同一类花的不同来源
            if ([flowerStr isEqualToString:shopCarStr])
            {
                    NSString*str1=[NSString stringWithFormat:@"%@",dic[@"supplier"]];
                    NSString*str2=[NSString stringWithFormat:@"%@",shopCar.supplierId];
                    if ([str1 isEqualToString:str2])
                    {
                        _addNum[sender.row]=[shopCar.number intValue]+1;
                        NSString*addStr=[NSString stringWithFormat:@"%d",_addNum[sender.row]];
                        [HttpEngine addGoodsLocation:locatioanStr withSku:dic[@"sku"] withSupplier:dic[@"supplier"] withNumber:addStr complete:^(NSString *error, NSString *errorStr) {
                            if (error) {
                                [self showError:errorStr];
                            }else {
                                [self showAnimationB:sender withF:dFlower];
                            }
                        }];
                        break;
                    }
                    else
                    {
                        //再次筛选
                        for (int j=0; j<_cartList.count; j++)
                        {
                            ShopingCar*shopCar1=_cartList[j];
                            NSString*shopCarStr1=[NSString stringWithFormat:@"%@",shopCar1.skuId];
                            NSString*str21=[NSString stringWithFormat:@"%@",shopCar1.supplierId];
                            if ([str1 isEqualToString:str21]&&[flowerStr isEqualToString:shopCarStr1])
                            {
                                _addNum[sender.row]=[shopCar1.number intValue]+1;
                                NSString*addStr=[NSString stringWithFormat:@"%d",_addNum[sender.row]];
                                [HttpEngine addGoodsLocation:locatioanStr withSku:dic[@"sku"] withSupplier:dic[@"supplier"] withNumber:addStr complete:^(NSString *error, NSString *errorStr) {
                                    if (error) {
                                     [self showError:errorStr];
                                    }else {
                                     [self showAnimationB:sender withF:dFlower];
                                    }
                                }];
                                break;
                            }
                            else
                                if(j==_cartList.count-1)
                            {
                                [HttpEngine addGoodsLocation:locatioanStr withSku:dic[@"sku"] withSupplier:dic[@"supplier"] withNumber:@"1" complete:^(NSString *error, NSString *errorStr) {
                                    if (error) {
                                      [self showError:errorStr];
                                    }else {
                                      [self showAnimationB:sender withF:dFlower];
                                    }
                                }];
                            }
                        }
                    }
                break;
            }
            else
            {
                if (i==_cartList.count-1)
                {
                    [HttpEngine addGoodsLocation:locatioanStr withSku:dic[@"sku"] withSupplier:dic[@"supplier"] withNumber:@"1" complete:^(NSString *error, NSString *errorStr) {
                        if (error) {
                           [self showError:errorStr];
                        }else {
                           [self showAnimationB:sender withF:dFlower];
                        }
                    }];
                }
            }
        }
    }
    
        [self performSelector:@selector(refreshData) withObject:nil afterDelay:0.5];
}

//减少按钮
-(void)subBtnClick:(MyBtn*)sender
{
    
    FlowerDetail*dFlower=_floerDetailArray[sender.tag-500];
    NSDictionary*dic=dFlower.dataArray[sender.row];
    NSString*flowerStr=[NSString stringWithFormat:@"%@",dFlower.Id];
    
    NSString*locatioanStr=[[NSUserDefaults standardUserDefaults]objectForKey:@"CODE"];
    
    _btnRect = [sender convertRect:sender.bounds toView:self.view];
    
    for (int i=0; i<_cartList.count; i++)
    {
        ShopingCar*shopCar=_cartList[i];
        NSString*shopCarStr=[NSString stringWithFormat:@"%@",shopCar.skuId];
        if ([flowerStr isEqualToString:shopCarStr])
        {
            NSString*str11=[NSString stringWithFormat:@"%@",dic[@"supplier"]];
            NSString*str22=[NSString stringWithFormat:@"%@",shopCar.supplierId];
            if ([str11 isEqualToString:str22])
            {
            _addNum[sender.row]=[shopCar.number intValue]-1;
            NSString*addStr=[NSString stringWithFormat:@"%d",_addNum[sender.row]];
                [HttpEngine addGoodsLocation:locatioanStr withSku:dic[@"sku"] withSupplier:dic[@"supplier"] withNumber:addStr complete:^(NSString *error, NSString *errorStr) {
                    if (error) {
                        [self showError:errorStr];
                    }
                }];
            }
        }
    }
    //更新数量
    [self performSelector:@selector(refreshData) withObject:nil afterDelay:0.5];
}
#pragma mark -----------------------showError
- (void)showError:(NSString *)errorStr {
    [WSProgressHUD showImage:nil status:errorStr];
    [self performSelector:@selector(dismisshud) withObject:nil afterDelay:3];

}
- (void)dismisshud {
    [WSProgressHUD dismiss];
}

#pragma mark ----------------------showAnimation
- (void)showAnimationB:(UIButton *)sender withF:(FlowerDetail *)dFlower {
    //找到当前点击的位置
    CGRect rect=[sender convertRect: sender.bounds toView:self.view];
    UIImageView*anImage=[[UIImageView alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-50, rect.origin.y, 20, 20)];
    [anImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@@!l60",dFlower.image]]];
    //anImage.backgroundColor=[UIColor redColor];
    anImage.layer.cornerRadius=10;
    anImage.clipsToBounds=YES;
    [self.view addSubview:anImage];
    
    //关键帧动画
//    CALayer *chLayer = [[CALayer alloc] init];
//    chLayer.frame = CGRectMake(rect.origin.x, rect.origin.y, 20, 20);
//    chLayer.backgroundColor = [UIColor colorWithPatternImage:anImage.image].CGColor;
//    chLayer.cornerRadius = 10;
//    [self.view.layer addSublayer:chLayer];
//    
//    CAKeyframeAnimation *CHAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, LBVIEW_WIDTH1-50, rect.origin.y);
//    CGPathAddQuadCurveToPoint(path, NULL, 3.5*LBVIEW_WIDTH1/5, rect.origin.y, 3.5*LBVIEW_WIDTH1/5, LBVIEW_HEIGHT1-54);
//    CHAnimation.path = path;
//    CHAnimation.removedOnCompletion = YES;
//    CHAnimation.duration = 2;
//    [chLayer addAnimation:CHAnimation forKey:nil];
    
    //动画
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubicPaced animations:^
     {
         //anImage.frame=CGRectMake(4*LBVIEW_WIDTH1/5, 6*rect.origin.y/5, 10, 10);
         anImage.frame=CGRectMake(3.5*LBVIEW_WIDTH1/5, LBVIEW_HEIGHT1-54, 20, 20);
         anImage.transform=CGAffineTransformMakeRotation((90.0f*M_PI) / 180.0f);
     } completion:^(BOOL finished)
     {
         [anImage removeFromSuperview];
     }];
}

//刷新表
-(void)refreshData
{
    [HttpEngine getSimpleCart:^(NSArray *array) {
        _cartList = [array mutableCopy];
        
        NSInteger number = 0;
        for (NSInteger i=0; i<array.count; i++) {
            ShopingCar*shCa=array[i];
            number += [shCa.number integerValue];
        }
        if(number>0){
            [self updateCartCount:[NSString stringWithFormat:@"%ld",(long)number]];
        }
        else{
            [self updateCartCount:nil];
        }
        
        [_rightTableV reloadData];
    }];
    
}

-(void) didSelectLeftTableView:(NSInteger) tag{
    if (search_str!=nil) {
        search_str=nil;
    }
    //判断有没有选择城市
    NSString*code=[[NSUserDefaults standardUserDefaults]objectForKey:@"CODE"];
    if (!code)
    {
        [self alert];
    }
    
    //隐藏分类栏
    [_catalogueStrArray removeAllObjects];
    _chooseBtn.isOpen=YES;
    [self shouSuo];
    
    _isTag=(int)tag;
    
    //重置row状态
//    for (int i=0; i<_floerDetailArray.count; i++)
//    {
//        _isOpen[i]=YES;
//    }
    
    if([_floerNameArray count]>tag){
        AllFlower*flower=_floerNameArray[tag];
        cid = flower.flowerId;
    }
    
    page = 1;
   
    
    //获取产品分类
    [HttpEngine getProduct:cid completion:^(NSArray *dataArray)
     {
         _catalogueArray=dataArray;
         [self updataCatalogueStrArray];
         [self setCatalogue];
         [self loadDetailData];
     }];
}
- (void)updataCatalogueStrArray {
    for (int i=0; i<_catalogueArray.count; i++) {
        FlowerCatalogue *flower = _catalogueArray[i];
        for (int j=0; j<flower.catalogueArray.count; j++) {
            NSDictionary *dic = flower.catalogueArray[j];
            if ([dic[@"aliasname"] isEqualToString:_sendArea]) {
                NSString*propStr=[NSString stringWithFormat:@"%@:%@",dic[@"props"],dic[@"id"]];
                [self.catalogueStrArray addObject:propStr];
            }
        }
    }
}
#pragma mark ------选中调用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.leftTableV])
    {
        NSInteger ClickLastTime =  [[NSUserDefaults standardUserDefaults]integerForKey:@"ClickLastTime"];
        if (ClickLastTime==indexPath.row+1) {
            
            return;

        }else
        {
            [self didSelectLeftTableView:indexPath.row];
            [[NSUserDefaults standardUserDefaults]setInteger:indexPath.row+1 forKey:@"ClickLastTime"];
        }
           }
    else if ([tableView isEqual:self.rightTableV])
    {
        
    }
}
#pragma mark ------区尾
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if([tableView isEqual:self.rightTableV])
    {
       return 4;
    }
    
    return 0;
}

-(UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerBorder=[[UIView alloc] init];
    
    [footerBorder setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]];
    //[self setBottomBorder:footerBorder color:[UIColor grayColor]];
    return footerBorder;
}
#pragma mark ------区头
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.leftTableV])
    {
        return 0;
    }
    return 80;
}


-(void) imageTouched:(UIButton *) sender{
    if(!imageview_bigview){
    imageview_bigview = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2-SCREEN_HEIGHT/4, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    }
    
    [MBProgressHUD showMessage:@"加载中" toView:self.view];
    [imageview_bigview sd_setImageWithURL:[NSURL URLWithString:self.photos[sender.tag]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [MBProgressHUD hideHUDForView:self.view];
        [SJAvatarBrowser showImage:imageview_bigview];
    }];
    
    

}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if([tableView isEqual:self.leftTableV])
    {
        return nil;
    }
    if ([tableView isEqual:self.rightTableV])
    {
        FlowerDetail*flow=_floerDetailArray[section];
        UIView*view=[[UIView alloc]init];
        view.backgroundColor=[UIColor whiteColor];
        
        //图片
        UIImageView*image=[[UIImageView alloc]initWithFrame:CGRectMake(10, LBVIEW_HEIGHT1*0.01,LBVIEW_WIDTH1/6, LBVIEW_WIDTH1/6)];
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@@!l120",flow.image]]];
        [view addSubview:image];
        
        UIButton *imageButton = [[UIButton alloc] initWithFrame:CGRectMake(10, LBVIEW_HEIGHT1*0.01,LBVIEW_WIDTH1/6, LBVIEW_WIDTH1/6)];
        
        [view addSubview:imageButton];
        imageButton.tag = section;
        [imageButton addTarget:self action:@selector(imageTouched:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //名字
        UILabel*nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(15+LBVIEW_WIDTH1/6, 0,LBVIEW_WIDTH1/2+10, 30)];
        nameLabel.text=flow.goodsName;
        nameLabel.numberOfLines=0;
        nameLabel.font=NJTitleFont;
        nameLabel.textColor=NJFontColor;
        [view addSubview:nameLabel];
        
        //属性
        UILabel*unitLabel=[[UILabel alloc]initWithFrame:CGRectMake(15+LBVIEW_WIDTH1/6, 30,45, 20)];
        unitLabel.text=[NSString stringWithFormat:@"%@/扎",flow.standardNumber];
        unitLabel.font=NJTextFont;
        unitLabel.textColor=[UIColor grayColor];
        [view addSubview:unitLabel];
        
        NSArray*attributeArray=[flow.propValue componentsSeparatedByString:@","];
        if (attributeArray.count>=3)
        {
            for (int i=0; i<3; i++)
            {
                UILabel*detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(15+LBVIEW_WIDTH1/6+50+35*i,30, 30, 20)];
                detailLabel.text=attributeArray[i];
                detailLabel.textAlignment=NSTextAlignmentCenter;
                detailLabel.layer.cornerRadius=5;
                detailLabel.clipsToBounds=YES;
                detailLabel.adjustsFontSizeToFitWidth=YES;
                detailLabel.font=[UIFont systemFontOfSize:12];
                detailLabel.textColor=[UIColor whiteColor];
                if (i==0)
                {
                    detailLabel.backgroundColor=[UIColor colorWithRed:244/255.0 green:100/255.0 blue:108/255.0 alpha:1];
                }
                if (i==1)
                {
                     detailLabel.backgroundColor=[UIColor colorWithRed:104/255.0 green:179/255.0 blue:255/255.0 alpha:1];
                }
                if (i==2)
                {
                    detailLabel.backgroundColor=[UIColor colorWithRed:255/255.0 green:45/255.0 blue:75/255.0 alpha:1];
                }
                [view addSubview:detailLabel];
            }
        }
        else
        {
        for (int i=0; i<attributeArray.count; i++)
        {
            UILabel*detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(15+LBVIEW_WIDTH1/6+50+35*i, 30, 30, 20)];
            detailLabel.text=attributeArray[i];
            detailLabel.textAlignment=NSTextAlignmentCenter;
            detailLabel.layer.cornerRadius=5;
            detailLabel.clipsToBounds=YES;
            detailLabel.font=[UIFont systemFontOfSize:12];
            detailLabel.textColor=[UIColor whiteColor];
            detailLabel.adjustsFontSizeToFitWidth=YES;
            detailLabel.backgroundColor=[UIColor colorWithRed:245/255.0 green:i*87/255.0 blue:105/255.0 alpha:1];
            [view addSubview:detailLabel];
        }
        }

        //价格
        NSString*login=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
        if (login)
        {
            UILabel*picLabel=[[UILabel alloc]initWithFrame:CGRectMake(15+LBVIEW_WIDTH1/6, 50, 100, 20)];
            NSDictionary*dic=flow.dataArray[0];
            CGFloat price = 99999.0f;
            for(int i=0;i<[flow.dataArray count];i++){
                price = MIN(price,[[flow.dataArray[i] objectForKey:@"price"] floatValue]);
            }
            if (flow.dataArray.count>1)
            {
                picLabel.text=[NSString stringWithFormat:@"¥%0.2f 起",price];
            }
            else
            {
                picLabel.text=[NSString stringWithFormat:@"¥%@",dic[@"price"]];
            }
            picLabel.textColor=[UIColor redColor];
            picLabel.font=[UIFont systemFontOfSize:13];
            [view addSubview:picLabel];
        }
//        //展开按钮
//        UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-90-95,40, 94, 34)];
//        //[btn setBackgroundImage:[UIImage imageNamed:@"category-arrow2.png"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"category-arrow2.png"] forState:UIControlStateNormal];
////      [btn setImage:[UIImage imageNamed:@"category-arrow1.png"] forState:UIControlStateSelected];
//        btn.selected=NO;
//        [btn setContentMode:UIViewContentModeCenter];
//        [btn setContentEdgeInsets:UIEdgeInsetsMake(10, 60, 0, 10)];
//        btn.tag=section;
//        [btn addTarget:self action:@selector(showDetail:) forControlEvents:UIControlEventTouchUpInside];
//        [view addSubview:btn];
        
        return view;
        
    }
    return nil;
    
}
////区间开合按钮
//-(void)showDetail:(UIButton*)sender
//{
//    NSString*login=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
//    if (!login)
//    {
//        LoginViewController*loginVC=[[LoginViewController alloc]init];
//        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginVC];
//        [self presentViewController:navigationController animated:YES completion:nil];
//    }
////    _isOpen[sender.tag]=!_isOpen[sender.tag];
//    [_rightTableV reloadData];
//}

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
- (void)alertMoreGoods {

    
    FlowerDetail*dFlower=_floerDetailArray[btnRow-100];
    NSDictionary*dic=dFlower.dataArray[btnSection];
    
    NSString*locatioanStr=[[NSUserDefaults standardUserDefaults]objectForKey:@"CODE"];
  
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"快速抢购" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    UIAlertAction *defaul = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *str = alert.textFields[0].text;
        [HttpEngine addGoodsLocation:locatioanStr withSku:dic[@"sku"] withSupplier:dic[@"supplier"] withNumber:str complete:^(NSString *error, NSString *errorStr) {
            if (error) {
                [self showError:errorStr];
            }
            [self refreshData];
        }];
      
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:defaul];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];

}
- (void)choosePlaceAlert:(NSArray *)array {
    NSString *bStr = @"";
    NSString *kStr = @"";
    for (int i=0;i<array.count; i++) {
        NSDictionary *dic = array[i];
        NSInteger bol = [dic[@"is_origin"] integerValue];
        if (bol==0) {
            if ([bStr isEqualToString:@""]) {
                bStr = dic[@"name"];
            }else
            bStr = [NSString stringWithFormat:@"%@、%@",bStr,dic[@"name"]];
        }else {
            if ([kStr isEqualToString:@""]) {
                kStr = dic[@"name"];
            }else
            kStr = [NSString stringWithFormat:@"%@、%@",kStr,dic[@"name"]];
        }
    }
    NSString *str = [NSString stringWithFormat:@"本地供应商:\n%@\n昆明供应商:\n%@",bStr,kStr];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择发货地" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaul = [UIAlertAction actionWithTitle:@"本地" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.sendArea = @"本地";
        [[NSUserDefaults standardUserDefaults]setObject:@"本地" forKey:@"AREA"];
        [self setCatalogue];
        [self saveData];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"昆明" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //修改信息接口
        self.sendArea = @"昆明";
        [[NSUserDefaults standardUserDefaults]setObject:@"昆明" forKey:@"AREA"];
        [self setCatalogue];
        [self saveData];
    }];
    [alert addAction:defaul];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
