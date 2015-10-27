//
//  ScribeViewCell.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/25.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "ScribeViewCell.h"
#import "HeaderFile.h"
@interface ScribeViewCell()
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UIImageView * rankImageView;
@property(nonatomic,strong)UILabel * rankLabel;

@end
@implementation ScribeViewCell

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
    CGFloat font;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        width = 215;
        height =  140;
        font = 16;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            width = 100;
            height = 115;
            font = 14;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            width = 300;
            height = 100;
            font = 18;
        }
        else
        {
            width = 121;
            height  = 100;
            font = 14;
        }
    }
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.contentView.frame.size.width*0.4+300,48.5)];
    bgImageView.image =[UIImage imageNamed:@"putibj.jpg"];
    [self.contentView addSubview:bgImageView];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(width*0.15, height*0.07, SCREEN_WIDTH*0.2, 0.075*SCREEN_HEIGHT)];
    _nameLabel.text = @"佛学爱好者";
    _nameLabel.font = [UIFont systemFontOfSize:font];
    _nameLabel.textColor = [UIColor redColor];
    [bgImageView addSubview:_nameLabel];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x+_nameLabel.frame.size.width+55, _nameLabel.frame.origin.y+10, 100,20)];
    _timeLabel.font = [UIFont systemFontOfSize:font];
    _timeLabel.textColor = [UIColor redColor];
    [bgImageView addSubview:_timeLabel];
    
    _rankImageView =[[UIImageView alloc]initWithFrame:CGRectMake(_timeLabel.frame.origin.x+_timeLabel.frame.size.width+35,_timeLabel.frame.origin.y-5, 30, 25)];
    _rankImageView.image = [UIImage imageNamed:@"rank_one.png"];
    [bgImageView addSubview:_rankImageView];
    _rankLabel =[[UILabel alloc]initWithFrame:CGRectMake(_timeLabel.frame.origin.x+_timeLabel.frame.size.width+65,_timeLabel.frame.origin.y-5, 30, 25)];
    _rankLabel.textColor = WorkDayColor;
    [bgImageView addSubview:_rankLabel];

    
}

-(void)setrankModel:(RankingModel *)rankmodel IndexPath:(NSIndexPath *) indexPath
{
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * huaienID = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    _rankmodel = rankmodel;
    _timeLabel.text = [NSString stringWithFormat:@"%ld字",(long)_rankmodel.taskValues];
    if ([_rankmodel.nickName isEqualToString:@""]) {
        _nameLabel.text=[NSString stringWithFormat:@"%ld",(long)_rankmodel.huaienID];
    }else{
        _nameLabel.text= _rankmodel.nickName;
    }
    
    NSInteger huaien = [huaienID integerValue];
    if(_rankmodel.huaienID == huaien){
        _timeLabel.textColor = [UIColor redColor];
        _nameLabel.textColor = [UIColor redColor];
    }else{
        _timeLabel.textColor = WorkDayColor;
        _nameLabel.textColor = WorkDayColor;
    }
    
    if (indexPath.row==0) {
        _rankImageView.hidden = NO;
        _rankImageView.image = [UIImage imageNamed:@"rank_one.png"];
        _rankLabel.text=@"";
    } else if (indexPath.row==1){
        _rankImageView.hidden = NO;
        _rankImageView.image = [UIImage imageNamed:@"rank_two.png"];
        _rankLabel.text=@"";
        
    } else if (indexPath.row==2){
        _rankImageView.hidden = NO;
        _rankImageView.image = [UIImage imageNamed:@"rank_three.png"];
        _rankLabel.text=@"";
    }
    else{
        _rankImageView.hidden = YES;
        _rankLabel.text = [NSString stringWithFormat:@"%ld",(long)(indexPath.row)+1];
    }
}

@end

