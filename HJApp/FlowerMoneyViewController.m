//
//  FlowerMoneyViewController.m
//  HJApp
//
//  Created by Bruce He on 15/11/6.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "FlowerMoneyViewController.h"
#import "FlowerTableViewCell.h"
#import "HttpEngine.h"

@interface FlowerMoneyViewController ()
{

    NSArray *HasBeenUsedArr;
    NSArray *expiredUsedArr;
}

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIButton *madaBtn;
@property (nonatomic, strong) UIButton *dattaBtn;
@property (nonatomic, strong) UIButton *mouBtn;

@property (nonatomic, strong) UITableView *flowerTV;
@property (nonatomic, strong) NSMutableArray *flowerArr;
@property (nonatomic, strong) NSMutableDictionary *flowerDic;


@property (nonatomic,unsafe_unretained)NSInteger status;
//当前被选中按钮
@property(nonatomic,strong)UIButton *selectdBtn;
@end

@implementation FlowerMoneyViewController

//宏定义宽高
#define VIEW_WIDTH self.view.bounds.size.width
#define VIEW_HEIGHT self.view.bounds.size.height

#define LBVIEW_WIDTH1 [UIScreen mainScreen].bounds.size.width
#define LBVIEW_HEIGHT1 [UIScreen mainScreen].bounds.size.height

-(void)viewWillAppear:(BOOL)animated
{
     self.navigationController.navigationBarHidden=NO;
     self.navigationController.navigationBar.translucent =NO;
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self CresteUI];
    [self LoadData];
    
}
//UI相关
-(void)CresteUI{

    self.view.backgroundColor =[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.title = @"花集红包";
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LBVIEW_WIDTH1, LBVIEW_HEIGHT1 / 15)];
    [self.view addSubview:self.topView];
    
    //待使用按钮
    self.madaBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.madaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.madaBtn.backgroundColor = [UIColor whiteColor];
    self.madaBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.madaBtn.frame = CGRectMake(0, 0, LBVIEW_WIDTH1 / 3-1, LBVIEW_HEIGHT1 / 15);
    [self.madaBtn setTitle:[NSString stringWithFormat:@"待使用(%lu)",_ToBeUsedarr.count] forState:UIControlStateNormal];
    [self.madaBtn addTarget:self action:@selector(lookRedBagBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self lookRedBagBtn:self.madaBtn];
    self.madaBtn.tag=1;
    [self.topView addSubview:self.madaBtn];
    //已使用按钮
    self.dattaBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.dattaBtn setTitle:@"已使用(0)" forState:UIControlStateNormal];

    [self.dattaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.dattaBtn.backgroundColor = [UIColor whiteColor];
    self.dattaBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.dattaBtn.frame = CGRectMake(LBVIEW_WIDTH1 / 3+2, 0, LBVIEW_WIDTH1/3-1, LBVIEW_HEIGHT1 / 15);
    self.dattaBtn.tag=2;
    [self.dattaBtn addTarget:self action:@selector(lookRedBagBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.dattaBtn];
    
    //已过期
    self.mouBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.mouBtn setTitle:@"已过期(0)" forState:UIControlStateNormal];

    [self.mouBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.mouBtn.backgroundColor = [UIColor whiteColor];
    self.mouBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.mouBtn.frame = CGRectMake(2*LBVIEW_WIDTH1/3+3, 0, LBVIEW_WIDTH1 / 3-1, LBVIEW_HEIGHT1 / 15);
    self.mouBtn.tag=3;
    [self.mouBtn addTarget:self action:@selector(lookRedBagBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.mouBtn];
    
    //表格
    self.flowerTV = [[UITableView alloc] initWithFrame:CGRectMake(0,self.topView.frame.size.height, LBVIEW_WIDTH1, LBVIEW_HEIGHT1-self.topView.frame.size.height-64) style:UITableViewStylePlain];
    self.flowerTV.delegate = self;
    self.flowerTV.dataSource = self;
    self.flowerTV.showsVerticalScrollIndicator=NO;
    self.flowerTV.backgroundColor =[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    _flowerTV.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.flowerTV];
    
}
//请求数据
-(void)LoadData{

        [HttpEngine getRedBagStatus:@"3" completion:^(NSArray *dataArray)
         {
             expiredUsedArr = [NSArray arrayWithArray:dataArray];
             [self.mouBtn setTitle:[NSString stringWithFormat:@"已过期(%lu)",(unsigned long)dataArray.count] forState:UIControlStateNormal];
             
         }];

        [HttpEngine getRedBagStatus:@"2" completion:^(NSArray *dataArray)
         {
             HasBeenUsedArr = [NSArray arrayWithArray:dataArray];
             [self.dattaBtn setTitle:[NSString stringWithFormat:@"已使用(%lu)",(unsigned long)dataArray.count] forState:UIControlStateNormal];
         }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_selectdBtn.tag==1) {
        
        return _ToBeUsedarr.count;
    }else if(_selectdBtn.tag==2)
    {
        return HasBeenUsedArr.count;
        
    }else
    {
        
        return expiredUsedArr.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return (LBVIEW_WIDTH1-40)/5.6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectdBtn.tag==1) {
        NSDictionary*dic=_ToBeUsedarr[indexPath.row];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            UIImageView*redPageImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, 3, LBVIEW_WIDTH1-40, (LBVIEW_WIDTH1-40)/5.6-6)];
            redPageImage.image=[UIImage imageNamed:@"hongbao_bg.png"];
            [cell addSubview:redPageImage];
            
            NSString*strTime=dic[@"end_time"];
            NSInteger intTime=[strTime integerValue];
            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:intTime];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"YYYY-MM-dd"];
            NSString*strtt=[formatter stringFromDate:confromTimesp];
            
            NSString *validDate = [NSString stringWithFormat:@"有效期到:%@",strtt];
            UIFont *validFont = [UIFont systemFontOfSize:12];
            CGSize size = [validDate boundingRectWithSize:CGSizeMake(300, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:validFont} context:nil].size;
            
            UILabel*timeEndLabel=[[UILabel alloc]initWithFrame:CGRectMake(redPageImage.frame.size.width/11, (LBVIEW_WIDTH1-40)/5.6-22,size.width, 20)];
            timeEndLabel.text= validDate;
            timeEndLabel.font=validFont;
            timeEndLabel.textColor=[UIColor grayColor];
            [cell addSubview:timeEndLabel];
            
            UILabel*valueLabel=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-20-redPageImage.frame.size.width/3, 3, redPageImage.frame.size.width/3, 30)];
            valueLabel.text=[NSString stringWithFormat:@"¥ %@",dic[@"price"]];
            valueLabel.textColor=[UIColor whiteColor];
            valueLabel.textAlignment=NSTextAlignmentCenter;
            valueLabel.font=[UIFont systemFontOfSize:19];
            [cell addSubview:valueLabel];
            
            UILabel*fullLabel=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-20-redPageImage.frame.size.width/3,(LBVIEW_WIDTH1-40)/5.6-22, redPageImage.frame.size.width/3, 20)];
            fullLabel.text=[NSString stringWithFormat:@"满%@元使用",dic[@"term_price"]];
            fullLabel.textColor=[UIColor whiteColor];
            fullLabel.textAlignment=NSTextAlignmentCenter;
            fullLabel.font=[UIFont systemFontOfSize:12];
            [cell addSubview:fullLabel];
            
            switch (_status) {
                case 2:
                {
                    UIImageView*statusImage=[[UIImageView alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1/2, 5, (LBVIEW_WIDTH1-40)/5.6+5, (LBVIEW_WIDTH1-40)/5.6-10)];
                    statusImage.image=[UIImage imageNamed:@"hongbao_0.png"];
                    [cell addSubview:statusImage];
                }
                    break;
                case 3:
                {
                    UIImageView*statusImage=[[UIImageView alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1/2, 5, (LBVIEW_WIDTH1-40)/5.6+5, (LBVIEW_WIDTH1-40)/5.6-10)];
                    statusImage.image=[UIImage imageNamed:@"hongbao_1.png"];
                    [cell addSubview:statusImage];
                }
                    break;
                default:
                    break;
            }
            
        }
        
        return cell;
        
    }else if(_selectdBtn.tag==2)
    {
    
        NSDictionary*dic=HasBeenUsedArr[indexPath.row];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            UIImageView*redPageImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, 3, LBVIEW_WIDTH1-40, (LBVIEW_WIDTH1-40)/5.6-6)];
            redPageImage.image=[UIImage imageNamed:@"hongbao_bg.png"];
            [cell addSubview:redPageImage];
            
            NSString*strTime=dic[@"end_time"];
            NSInteger intTime=[strTime integerValue];
            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:intTime];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"YYYY-MM-dd"];
            NSString*strtt=[formatter stringFromDate:confromTimesp];
            
            NSString *validDate = [NSString stringWithFormat:@"有效期到:%@",strtt];
            UIFont *validFont = [UIFont systemFontOfSize:12];
            CGSize size = [validDate boundingRectWithSize:CGSizeMake(300, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:validFont} context:nil].size;
            
            UILabel*timeEndLabel=[[UILabel alloc]initWithFrame:CGRectMake(redPageImage.frame.size.width/11, (LBVIEW_WIDTH1-40)/5.6-22,size.width, 20)];
            timeEndLabel.text= validDate;
            timeEndLabel.font=validFont;
            timeEndLabel.textColor=[UIColor grayColor];
            [cell addSubview:timeEndLabel];
            
            UILabel*valueLabel=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-20-redPageImage.frame.size.width/3, 3, redPageImage.frame.size.width/3, 30)];
            valueLabel.text=[NSString stringWithFormat:@"¥ %@",dic[@"price"]];
            valueLabel.textColor=[UIColor whiteColor];
            valueLabel.textAlignment=NSTextAlignmentCenter;
            valueLabel.font=[UIFont systemFontOfSize:19];
            [cell addSubview:valueLabel];
            
            UILabel*fullLabel=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-20-redPageImage.frame.size.width/3,(LBVIEW_WIDTH1-40)/5.6-22, redPageImage.frame.size.width/3, 20)];
            fullLabel.text=[NSString stringWithFormat:@"满%@元使用",dic[@"term_price"]];
            fullLabel.textColor=[UIColor whiteColor];
            fullLabel.textAlignment=NSTextAlignmentCenter;
            fullLabel.font=[UIFont systemFontOfSize:12];
            [cell addSubview:fullLabel];
            
            switch (_status) {
                case 2:
                {
                    UIImageView*statusImage=[[UIImageView alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1/2, 5, (LBVIEW_WIDTH1-40)/5.6+5, (LBVIEW_WIDTH1-40)/5.6-10)];
                    statusImage.image=[UIImage imageNamed:@"hongbao_0.png"];
                    [cell addSubview:statusImage];
                }
                    break;
                case 3:
                {
                    UIImageView*statusImage=[[UIImageView alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1/2, 5, (LBVIEW_WIDTH1-40)/5.6+5, (LBVIEW_WIDTH1-40)/5.6-10)];
                    statusImage.image=[UIImage imageNamed:@"hongbao_1.png"];
                    [cell addSubview:statusImage];
                }
                    break;
                default:
                    break;
            }
            
        }
        
        return cell;

        
    }else
    {
    
        NSDictionary*dic=expiredUsedArr[indexPath.row];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            UIImageView*redPageImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, 3, LBVIEW_WIDTH1-40, (LBVIEW_WIDTH1-40)/5.6-6)];
            redPageImage.image=[UIImage imageNamed:@"hongbao_bg.png"];
            [cell addSubview:redPageImage];
            
            NSString*strTime=dic[@"end_time"];
            NSInteger intTime=[strTime integerValue];
            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:intTime];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"YYYY-MM-dd"];
            NSString*strtt=[formatter stringFromDate:confromTimesp];
            
            NSString *validDate = [NSString stringWithFormat:@"有效期到:%@",strtt];
            UIFont *validFont = [UIFont systemFontOfSize:12];
            CGSize size = [validDate boundingRectWithSize:CGSizeMake(300, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:validFont} context:nil].size;
            
            UILabel*timeEndLabel=[[UILabel alloc]initWithFrame:CGRectMake(redPageImage.frame.size.width/11, (LBVIEW_WIDTH1-40)/5.6-22,size.width, 20)];
            timeEndLabel.text= validDate;
            timeEndLabel.font=validFont;
            timeEndLabel.textColor=[UIColor grayColor];
            [cell addSubview:timeEndLabel];
            
            UILabel*valueLabel=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-20-redPageImage.frame.size.width/3, 3, redPageImage.frame.size.width/3, 30)];
            valueLabel.text=[NSString stringWithFormat:@"¥ %@",dic[@"price"]];
            valueLabel.textColor=[UIColor whiteColor];
            valueLabel.textAlignment=NSTextAlignmentCenter;
            valueLabel.font=[UIFont systemFontOfSize:19];
            [cell addSubview:valueLabel];
            
            UILabel*fullLabel=[[UILabel alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-20-redPageImage.frame.size.width/3,(LBVIEW_WIDTH1-40)/5.6-22, redPageImage.frame.size.width/3, 20)];
            fullLabel.text=[NSString stringWithFormat:@"满%@元使用",dic[@"term_price"]];
            fullLabel.textColor=[UIColor whiteColor];
            fullLabel.textAlignment=NSTextAlignmentCenter;
            fullLabel.font=[UIFont systemFontOfSize:12];
            [cell addSubview:fullLabel];
            
            switch (_status) {
                case 2:
                {
                    UIImageView*statusImage=[[UIImageView alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1/2, 5, (LBVIEW_WIDTH1-40)/5.6+5, (LBVIEW_WIDTH1-40)/5.6-10)];
                    statusImage.image=[UIImage imageNamed:@"hongbao_0.png"];
                    [cell addSubview:statusImage];
                }
                    break;
                case 3:
                {
                    UIImageView*statusImage=[[UIImageView alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1/2, 5, (LBVIEW_WIDTH1-40)/5.6+5, (LBVIEW_WIDTH1-40)/5.6-10)];
                    statusImage.image=[UIImage imageNamed:@"hongbao_1.png"];
                    [cell addSubview:statusImage];
                }
                    break;
                default:
                    break;
            }
            
        }
        
        return cell;

        
    }
    
}

//查看红包
-(void)lookRedBagBtn:(UIButton*)sender
{
    self.selectdBtn = sender;
    [self.flowerTV reloadData];

}
@end
