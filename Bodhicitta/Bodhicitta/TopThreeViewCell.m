
//
//  TopThreeViewCell.m
//  Bodhicitta
//
//  Created by 怀恩11 on 15/10/19.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "TopThreeViewCell.h"
#import "HeaderFile.h"
#import "CheckBuddhaHallLevel.h"
#import "BuddhaLevel.h"
@interface TopThreeViewCell()
@property(nonatomic,strong)UIImageView *rankImageView;
@property(nonatomic,strong)UILabel *valueLabel;
@property(nonatomic,strong)UIImageView *levelImageView;
@property(nonatomic,strong)UILabel *levelLabel;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@end
@implementation TopThreeViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}
-(void)createSubViews
{
    CALayer *layer = self.contentView.layer;
    //    layer.cornerRadius = 3;
    layer.masksToBounds = YES;
    self.backgroundColor = [UIColor redColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    CGFloat width;
    CGFloat height ;
    CGFloat font ;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        width = 230;
        height =  100;
        //font  = 18;
        font=14;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            width = 180;
            height = 95;
            font = 12;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            width = 230;
            height = 100;
            font = 16;
        }
        else
        {
            width = 180;
            height  = 100;
            font = 14;
        }
    }
    UIImageView *bgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    bgImageView.image=[UIImage imageNamed:@"temple_rank_items_topthree_bg.jpg"];
    [self.contentView addSubview:bgImageView];
    self.rankImageView=[[UIImageView  alloc]initWithFrame:CGRectMake(25, 0, 35, 60)];
    [bgImageView addSubview:self.rankImageView];
    self.valueLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.rankImageView.frame.size.width+self.rankImageView.frame.origin.x+width*0.1+15, 25, 50, 20)];
    self.valueLabel.textColor=WorkDayColor;
    self.valueLabel.font=[UIFont systemFontOfSize:font];
    [bgImageView addSubview:self.valueLabel];
    self.levelImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.valueLabel.frame.size.width+self.valueLabel.frame.origin.x+width*0.1, self.valueLabel.frame.origin.y-3, 40, 20)];
    self.levelImageView.image=[UIImage imageNamed:@"top_three_temple_level_bg.png"];
    [bgImageView addSubview:self.levelImageView];
    self.levelLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.levelImageView.frame.size.width, 20)];
    self.levelLabel.textAlignment=NSTextAlignmentCenter;
    self.levelLabel.textColor= WorkDayColor;
    self.levelLabel.font=[UIFont systemFontOfSize:font];
    [self.levelImageView addSubview:self.levelLabel];
    self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.levelImageView.frame.size.width+self.levelImageView.frame.origin.x+width*0.1+10, 0, 45, 45)];
    CALayer  *layerHeadImageViewLayer = self.headImageView.layer;
    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
    layerHeadImageViewLayer.borderWidth = 1.5;
    layerHeadImageViewLayer.masksToBounds = YES;
    layerHeadImageViewLayer.cornerRadius = self.headImageView.frame.size.height * 0.5;
    [bgImageView addSubview:self.headImageView];
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.headImageView.frame.origin.x-8, self.headImageView.frame.size.height+self.headImageView.frame.origin.y, self.headImageView.frame.size.width+20, 10)];
    self.nameLabel.textColor=WorkDayColor;
    self.nameLabel.font=[UIFont systemFontOfSize:font];
    [bgImageView addSubview:self.nameLabel];
    
}
- (void)setBuddhaModel:(BuddhaLevel *)model IndexPath:(NSIndexPath *)indexPath
{
    _model=model;
    self.valueLabel.text=[NSString stringWithFormat:@"%ld",model.templeIntegral];
    NSInteger value=model.templeIntegral;
  
    CheckBuddhaHallLevel *levelManager = [CheckBuddhaHallLevel   shareCheckBuddhaHallLevel];
    NSInteger   levelInteger = [levelManager checkBuddhaHallLevelWithValue:value];
    self.levelLabel.text=[NSString stringWithFormat:@"%ld级",levelInteger];
    if ([ model.headImg hasPrefix:@"http"]){
       [self.headImageView setImageWithURL:[NSURL URLWithString:model.headImg]];
    }else{
        self.headImageView.image=[UIImage imageNamed:@"默认头像.png"];
    }
    if (indexPath.row==0){
        self.rankImageView.image=[UIImage imageNamed:@"temple_rank_1.png"];
       
    }else if (indexPath.row==1){
        self.rankImageView.image=[UIImage imageNamed:@"temple_rank_2.png"];
    }else if (indexPath.row==2){
        self.rankImageView.image=[UIImage imageNamed:@"temple_rank_3.png"];
    }
    if ([model.nickName isEqualToString:@""]){
       
        self.nameLabel.text=[NSString stringWithFormat:@"%ld",model.huaienID];
        self.nameLabel.textAlignment=NSTextAlignmentLeft;
    }else{
      
        self.nameLabel.text=model.nickName;
        self.nameLabel.textAlignment=NSTextAlignmentCenter;
    }
   
}


@end
