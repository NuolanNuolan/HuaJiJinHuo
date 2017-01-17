//
//  GoodsCollectionViewCell.m
//  HJApp
//
//  Created by 袁联林 on 16/9/5.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "GoodsCollectionViewCell.h"

@implementation GoodsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)SetHjSeedsGoodsDetail:(HjSeedsGoodsDetail *)model
{

    _name.text= [NSString stringWithFormat:@"%@",model.name] ;
    _price.text =[NSString stringWithFormat:@"花籽 %@",model.price];
    [_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.imageurl]] placeholderImage:[UIImage imageNamed:@"nopic"]];
}
@end
