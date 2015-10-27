
//
//  TempleImageViewCell.m
//  Bodhicitta
//
//  Created by 怀恩11 on 15/8/11.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "TempleImageViewCell.h"
#import "TempleImage.h"
#import "UIImageView+WebCache.h"
@interface TempleImageViewCell ()
@property (nonatomic,strong)UIImageView *bgImageView;
@property (nonatomic,strong)UIImageView *templeImageView;
@property (nonatomic,strong)UILabel *nameLabel;
@end
@implementation TempleImageViewCell
- (instancetype)init  //这个初始化方法可以吗？
{
    if (self =[super init])
    {
        [self createSubView];
    }
    return self;
    
}
- (void)createSubView
{
    self.bgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,(self.frame.size.width-3*5)/2 , 200)];
    self.bgImageView.image =[UIImage imageNamed:@"Glow.png"];
    self.templeImageView =[[UIImageView alloc]initWithFrame:CGRectMake(30, 30, 90, self.bgImageView.frame.origin.y-30)];
    self.nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(self.bgImageView.frame.size.width-30, 0, 30, 100)];
    //这里自已钥匙竖着放
    
    [self.contentView addSubview:self.bgImageView];
    [self.contentView addSubview:self.templeImageView];
    [self.contentView addSubview:self.nameLabel];
    
}
- (void)setModel:(TempleImage *)model
{
    self.bgImageView.image =[UIImage imageNamed:@"Glow.png"];
    [self.templeImageView setImageWithURL:[NSURL URLWithString:model.materialImageUrl]];
    self.nameLabel.text=model.taskName;
    
}
@end