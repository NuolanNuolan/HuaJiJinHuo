//
//  AdressTableViewCell.m
//  HJApp
//
//  Created by Bruce He on 15/11/6.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "AdressTableViewCell.h"

@implementation AdressTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.adressIV = [[UIImageView alloc] init];
        self.adressIV.image = [UIImage imageNamed:@"addr-num.png"];
        [self addSubview:self.adressIV];
        
        self.numAddressLabel=[[UILabel alloc]init];
        self.numAddressLabel.font=[UIFont systemFontOfSize:12];
        self.numAddressLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:self.numAddressLabel];
        
        self.nameL = [[UILabel alloc] init];
        //self.nameL.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:self.nameL];
        [self.nameL autoresizingMask];
        
        
        self.numberL = [[UILabel alloc] init];
        self.numberL.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:self.numberL];
        
        
        self.adressL = [[UILabel alloc] init];
        //self.adressL.font = [UIFont systemFontOfSize:13];
        self.adressL.numberOfLines = 2;
        [self.contentView addSubview:self.adressL];
        
        
        _morenBtn=[[UIButton alloc] init];
       
//        UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-LBVIEW_WIDTH1/3.5-90,40, 94, 34)];
//        //[btn setBackgroundImage:[UIImage imageNamed:@"category-arrow2.png"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"category-arrow2.png"] forState:UIControlStateNormal];
//        [btn setContentMode:UIViewContentModeCenter];
//        [btn setContentEdgeInsets:UIEdgeInsetsMake(10, 60, 0, 10)];
        [_morenBtn setContentMode:UIViewContentModeCenter];
        //40 60
        [_morenBtn setContentEdgeInsets:UIEdgeInsetsMake(13, 0, 7, 40)];
        //[_morenBtn setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:_morenBtn];
        
        
        
        
        self.bjIV = [[UIImageView alloc] init];
        self.bjIV.image = [UIImage imageNamed:@"ctrl-edit.png"];
        [self.contentView addSubview:self.bjIV];
        
        
        self.deleIV = [[UIImageView alloc] init];
        self.deleIV.image = [UIImage imageNamed:@"ctrl-delete.png"];
        [self.contentView addSubview:self.deleIV];
        
        
        self.bjBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //[self.bjBtn setTitle:@"编辑" forState:(UIControlStateNormal)];
        [self.bjBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        //self.bjBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        //self.bjBtn.alpha = 0.6;
        //[self.bjBtn setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:self.bjBtn];
        
        _bjLab=[[UILabel alloc]init];
        _bjLab.textColor=[UIColor grayColor];
        _bjLab.text=@"编辑";
        _bjLab.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_bjLab];
        
        
        self.deleBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //[self.deleBtn setTitle:@"删除" forState:(UIControlStateNormal)];
        [self.deleBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        //self.deleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        //self.deleBtn.alpha = 0.6;
        //[self.deleBtn setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:self.deleBtn];
        
        _deLab=[[UILabel alloc]init];
        _deLab.textColor=[UIColor grayColor];
        _deLab.text=@"删除";
        _deLab.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_deLab];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width / 5;
    CGFloat height = self.frame.size.height;
    
    self.adressIV.frame = CGRectMake(width / 1.5-44, height / 6, 32, 44);
    self.numAddressLabel.frame=CGRectMake(width / 1.5-44+8,height / 6+7, 16, 16);
    
    
    self.nameL.frame = CGRectMake(width / 1.5, height / 6, width*4, height / 5);
    self.numberL.frame = CGRectMake(width / 1.5+width /1.5, height / 6, width / 0.6, height / 5);
    
    self.adressL.frame = CGRectMake(width / 1.5, height / 2.7, self.frame.size.width-width/1.5, height / 3);
    
    self.morenBtn.frame = CGRectMake(width / 1.5, self.frame.size.height-40,60, 40);
    //self.choiceL.frame = CGRectMake(width / 1.1, height / 1.25, width *2, height / 7);
    
    self.bjIV.frame = CGRectMake(self.frame.size.width-125, self.frame.size.height-20, 15, 15);
    self.bjBtn.frame = CGRectMake(self.frame.size.width-125, self.frame.size.height-40, 45, 40);
    self.bjLab.frame=CGRectMake(self.frame.size.width-110, self.frame.size.height-20, 30, 15);

    self.deleIV.frame = CGRectMake(self.frame.size.width-55, self.frame.size.height-20, 15 ,15);
    self.deLab.frame = CGRectMake(self.frame.size.width-40, self.frame.size.height-20, 30 ,15);
    self.deleBtn.frame = CGRectMake(self.frame.size.width-55, self.frame.size.height-40, 45, 40);
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
