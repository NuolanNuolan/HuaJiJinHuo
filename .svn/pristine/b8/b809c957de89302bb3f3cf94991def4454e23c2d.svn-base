//
//  SeedsViewController.m
//  HJApp
//
//  Created by 袁联林 on 16/9/5.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "SeedsViewController.h"
#import "GoodsCollectionViewCell.h"
#import "GoodsdetailsViewController.h"

@interface SeedsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{

    //排序相关
    BOOL isscreening;
    UICollectionView *_colltionView;
    //总数组
    NSArray *Dataarr;
    //筛选数组
    NSArray *Dataarr_screening;
    UIButton *btn;
}

@end

@implementation SeedsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    [self Loaddata];
    // Do any additional setup after loading the view.
}
-(void)Loaddata
{
    [MBProgressHUD showMessage:@"加载中" toView:self.view];
    [HttpEngine getUserSeedsGoodscompletion:^(NSArray *dataArray) {
        [MBProgressHUD hideHUDForView:self.view];
        Dataarr = [NSArray arrayWithArray:dataArray];
        Dataarr_screening =[NSArray arrayWithArray:dataArray];
        if (Dataarr.count>0) {
            [_colltionView reloadData];
        }
    }];

}
-(void)CreateUI
{

    self.view.backgroundColor = RGB(230, 233, 236);
    self.title=@"花籽兑换礼品";
    UIImageView *imageSorting = [[UIImageView alloc]initWithFrame:CGMAKE(27, 19, 19, 21)];
    imageSorting.userInteractionEnabled =YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1Click:)];
    [imageSorting addGestureRecognizer:tap1];
    imageSorting.image = [UIImage imageNamed:@"Sorting"];
    UILabel * lab= [[UILabel alloc]initWithFrame:CGMAKE(50, 23, 80, 15)];
    lab.userInteractionEnabled =YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1Click:)];
    [lab addGestureRecognizer:tap2];
    [lab setTextColor:RGB(88, 88, 88) ];
    [lab setText:@"兑换花籽数"];
    [lab setFont:[UIFont systemFontOfSize:15]];
    NSArray *arr = [[NSArray alloc]initWithObjects:@"500以下",@"500-12000",@"12000-30000",@"30000-50000",@"50000以上", nil];
    for (int i=0; i<5; i++) {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag =100+i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:RGB(149, 149, 149) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        if (i<3) {
            btn.frame=CGMAKE(27+((SCREEN_WIDTH-54-14)/3)*i+i*7, 48, (SCREEN_WIDTH-54-14)/3, 27);
        }
        else
        {
        
            btn.frame=CGMAKE(27+((SCREEN_WIDTH-54-14)/3)*(i-3)+(i-3)*7, 81, (SCREEN_WIDTH-54-14)/3, 27);
        }
        [self.view addSubview:btn];
    }
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    //    创建流式布局图
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((SCREEN_WIDTH-34)/3, 171);
    layout.minimumInteritemSpacing = 3.5;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(7, 7, 0, 7);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _colltionView= [[UICollectionView alloc]initWithFrame:CGRectMake(0, 130, SCREEN_WIDTH, SCREEN_HEIGHT-194)collectionViewLayout:layout];
    _colltionView.delegate = self;
    _colltionView.dataSource = self;
    _colltionView.backgroundColor = [UIColor clearColor];
    _colltionView.showsVerticalScrollIndicator =NO;
    [self.view addSubview:_colltionView];
    UINib *cellNib = [UINib nibWithNibName:@"GoodsCollectionViewCell" bundle:nil];
    [_colltionView registerNib:cellNib forCellWithReuseIdentifier:@"Cellname"];
    
    
    
    
    
    [self.view addSubview:imageSorting];
    [self.view addSubview:lab];

    
}
#pragma mark - UiColltionView的代理
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return Dataarr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdenttifer = @"Cellname";
    GoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdenttifer forIndexPath:indexPath];
    cell.layer.borderWidth=1;
    cell.layer.borderColor = RGB(202, 202, 202).CGColor;
    [cell SetHjSeedsGoodsDetail:Dataarr[indexPath.row]];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HjSeedsGoodsDetail *model =[Dataarr objectAtIndex:indexPath.row];
    GoodsdetailsViewController *goods = [[GoodsdetailsViewController alloc]init];
    goods.model =model;
    goods.seeds =_Seeds;
    [self.navigationController pushViewController:goods animated:YES];

}

-(void)click:(UIButton *)sender
{
   
    
    
    NSInteger tag = [[NSUserDefaults standardUserDefaults]integerForKey:@"SENDERTAG"];
    if (tag==0) {
        [[NSUserDefaults standardUserDefaults]setInteger:sender.tag forKey:@"SENDERTAG"];
        sender.selected=YES;
        [sender setBackgroundColor:RGB(52, 147, 233)];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      
        
        
    }else if(tag==sender.tag)
    {
    
        if (sender.selected) {
            
            [sender setBackgroundColor:[UIColor whiteColor]];
            [sender setTitleColor:RGB(149, 149, 149) forState:UIControlStateNormal];
            sender.selected=NO;
            Dataarr =Dataarr_screening;
            [_colltionView reloadData];
            return;
        }
        else
        {
        
            sender.selected=YES;
            [sender setBackgroundColor:RGB(52, 147, 233)];
            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
        
        
    }else
    {
    
        for (int i =0; i<5; i++) {
            UIButton *btn_SX = [self.view viewWithTag:100+i];
            [btn_SX setBackgroundColor:[UIColor whiteColor]];
            [btn_SX setTitleColor:RGB(149, 149, 149) forState:UIControlStateNormal];
            btn_SX.selected=NO;
        }
        [[NSUserDefaults standardUserDefaults]setInteger:sender.tag forKey:@"SENDERTAG"];
        sender.selected=YES;
        [sender setBackgroundColor:RGB(52, 147, 233)];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    NSMutableArray *arr = [BWCommon SenderTag:sender.tag withArr:Dataarr_screening];
    Dataarr =[[NSArray alloc]initWithArray:arr];
    [_colltionView reloadData];
    
    
}
- (void)tap1Click:(UITapGestureRecognizer*)sender{
    if(isscreening==NO)
    {
    
        //这里类似KVO的读取属性的方法，直接从字符串读取对象属性，注意不要写错
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"price" ascending:YES];
        //这个数组保存的是排序好的对象
        NSArray *tempArray = [Dataarr sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        Dataarr =[[NSArray alloc]init];
        Dataarr =tempArray;
        isscreening=YES;
        [_colltionView reloadData];
        
    }else
    {
    
         Dataarr = [[Dataarr reverseObjectEnumerator] allObjects];
         isscreening=NO;
        [_colltionView reloadData];
    }
    
}
@end
