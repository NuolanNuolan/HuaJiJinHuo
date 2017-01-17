//
//  GuessV.m
//  HJApp
//
//  Created by Bruce He on 16/2/1.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "GuessV.h"
#import "UIImageView+WebCache.h"
#import "MyButton.h"

@implementation GuessV

#define NJTitleFont [UIFont systemFontOfSize:14]
#define NJNameFont [UIFont systemFontOfSize:12]
#define NJTextFont [UIFont systemFontOfSize:10.5]
#define NJFontColor [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]

- (id) init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)superWidth:(float) width withArray:(NSArray *)array withTabVC:(UITabBarController *)tabVC {
    _tabVC = tabVC;
    _dataArray = array;
    MYLOG(@"%@",_dataArray);
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
    titleView.backgroundColor = [UIColor whiteColor];
    [self addSubview:titleView];
    
    NSString *strTitle = @"猜你喜欢";
    CGSize size = [strTitle boundingRectWithSize:CGSizeMake(200, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:NJNameFont} context:nil].size;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, size.width, 30)];
    titleLabel.text = strTitle;
    titleLabel.font = NJNameFont;
    [titleView addSubview:titleLabel];
    
    UIImageView *xiaoImage = [[UIImageView alloc] initWithFrame:CGRectMake(20+size.width, 10, 20, 20)];
    xiaoImage.image = [UIImage imageNamed:@"xiao.png"];
    [titleView addSubview:xiaoImage];
    
    for (int i = 0; i<array.count; i++) {
        
        NSDictionary *guessDic = array[i];
        
        int X = i%2;
        int Y = i/2;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(X*width/2, 42+82*Y, width/2, 80)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        //按钮
        MyButton *btn = [[MyButton alloc]initWithFrame:CGRectMake(0, 0, width/2, 80)];
        btn.tag = [guessDic[@"category_id"] intValue];
        btn.status = i+10;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
        //图片
        UIImageView*image=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10,60, 60)];
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@@!l120",guessDic[@"image"]]]];
        [view addSubview:image];
        
        //名字
        UILabel*nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(75, 10,width/2-65, 30)];
        nameLabel.text = guessDic[@"goods_name"];
        nameLabel.numberOfLines=0;
        nameLabel.font=NJTitleFont;
        nameLabel.textColor=NJFontColor;
        [view addSubview:nameLabel];
        
        //属性
        UILabel*unitLabel=[[UILabel alloc]initWithFrame:CGRectMake(75, 40,45, 20)];
        unitLabel.text=[NSString stringWithFormat:@"%@/扎",guessDic[@"standard_number"]];
        unitLabel.font=NJTextFont;
        unitLabel.textColor=[UIColor grayColor];
        [view addSubview:unitLabel];
        
        NSArray*attributeArray=[guessDic[@"prop_value"]componentsSeparatedByString:@","];
        if (attributeArray.count>=2)
        {
            for (int j=0; j<2; j++)
            {
                UILabel*detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(65+j*35+45,40, 30, 20)];
                detailLabel.text=attributeArray[j];
                detailLabel.textAlignment=NSTextAlignmentCenter;
                detailLabel.layer.cornerRadius=5;
                detailLabel.clipsToBounds=YES;
                detailLabel.adjustsFontSizeToFitWidth=YES;
                detailLabel.font=[UIFont systemFontOfSize:12];
                detailLabel.textColor=[UIColor whiteColor];
                if (j==0)
                {
                    detailLabel.backgroundColor=[UIColor colorWithRed:244/255.0 green:100/255.0 blue:108/255.0 alpha:1];
                }
                if (j==1)
                {
                    detailLabel.backgroundColor=[UIColor colorWithRed:104/255.0 green:179/255.0 blue:255/255.0 alpha:1];
                }
                
                [view addSubview:detailLabel];
            }
        }
        else
        {
            for (int j=0; j<attributeArray.count; j++)
            {
                UILabel*detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(65+j*35+45, 40, 30, 20)];
                detailLabel.text=attributeArray[j];
                detailLabel.textAlignment=NSTextAlignmentCenter;
                detailLabel.layer.cornerRadius=5;
                detailLabel.clipsToBounds=YES;
                detailLabel.font=[UIFont systemFontOfSize:12];
                detailLabel.textColor=[UIColor whiteColor];
                detailLabel.adjustsFontSizeToFitWidth=YES;
                detailLabel.backgroundColor=[UIColor colorWithRed:244/255.0 green:100/255.0 blue:108/255.0 alpha:1];
                [view addSubview:detailLabel];
            }
        }
        
        //价格
        NSString*login=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
        if (login)
        {
            UILabel*picLabel=[[UILabel alloc]initWithFrame:CGRectMake(75, 60, 100, 20)];
            NSArray *priceListArray=guessDic[@"price_list"];
            NSDictionary *dic = priceListArray[0];
            if (priceListArray.count>1)
            {
                picLabel.text=[NSString stringWithFormat:@"¥%@ 起",dic[@"price"]];
            }
            else
            {
                picLabel.text=[NSString stringWithFormat:@"¥%@",dic[@"price"]];
            }
            picLabel.textColor=[UIColor redColor];
            picLabel.font=[UIFont systemFontOfSize:13];
            [view addSubview:picLabel];
        }
    }
}
-(void)btnClick:(MyButton*)sender
{
    NSString*isTag=[NSString stringWithFormat:@"%lu",(long)sender.tag];
    [[NSUserDefaults standardUserDefaults]setObject:isTag forKey:@"TWOTAG"];
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"ONLYONE"];
    NSDictionary *dic = _dataArray[sender.status-10];
    
    NSDictionary *dataDic = [[NSDictionary alloc]init];
    dataDic = @{@"goods_name":dic[@"goods_name"],@"image":dic[@"image"],@"prop_value":dic[@"prop_value"],@"standard_number":dic[@"standard_number"],@"id":dic[@"id"],@"price_list":dic[@"price_list"]};
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingString:@"/Documents/onlyDic"];
    [dataDic writeToFile:path atomically:YES];
    _tabVC.selectedIndex=1;
}

@end
