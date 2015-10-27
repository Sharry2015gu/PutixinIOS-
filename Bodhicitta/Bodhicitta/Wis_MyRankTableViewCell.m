//
//  Wis_MyRankTableViewCell.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/9/14.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "Wis_MyRankTableViewCell.h"
#import "HeaderFile.h"
@interface Wis_MyRankTableViewCell()
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UIImageView * rankImageView;
@property(nonatomic,strong)UILabel * rankLabel;

@end
@implementation Wis_MyRankTableViewCell

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
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.contentView.frame.size.width*0.4+300,47.5)];
    bgImageView.image =[UIImage imageNamed:@"putibj.jpg"];
    [self.contentView addSubview:bgImageView];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.01-5, SCREEN_WIDTH*0.2, 0.075*SCREEN_HEIGHT)];
    _nameLabel.text = @"佛学爱好者";
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.textColor = [UIColor redColor];
    [bgImageView addSubview:_nameLabel];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x+_nameLabel.frame.size.width+50, _nameLabel.frame.origin.y+15, 100,20)];
    _timeLabel.font = [UIFont systemFontOfSize:16];
    _timeLabel.textColor = [UIColor redColor];
    [bgImageView addSubview:_timeLabel];
    
    _rankImageView =[[UIImageView alloc]initWithFrame:CGRectMake(_timeLabel.frame.origin.x+_timeLabel.frame.size.width+55,_timeLabel.frame.origin.y-5, 30, 25)];
    _rankImageView.image = [UIImage imageNamed:@"rank_one.png"];
    [bgImageView addSubview:_rankImageView];
    
    _rankLabel =[[UILabel alloc]initWithFrame:CGRectMake(_timeLabel.frame.origin.x+_timeLabel.frame.size.width+65,_timeLabel.frame.origin.y-5, 30, 25)];
    _rankLabel.textColor = WorkDayColor;
    [bgImageView addSubview:_rankLabel];
    
    
}

-(void)setrankModel:(RankingModel *)rankmodel IndexPath:(NSIndexPath *) indexPath
{
    
    _rankmodel = rankmodel;
    _timeLabel.text = [NSString stringWithFormat:@"%ld字",_rankmodel.taskValues/60];
    
    NSInteger huaien = [[[NSUserDefaults standardUserDefaults] objectForKey:@"huaienID"] integerValue];
    if ([_rankmodel.nickName isEqualToString:@""]) {
        
        _nameLabel.text=[NSString stringWithFormat:@"%ld",_rankmodel.huaienID];
    }else{
        
        _nameLabel.text= _rankmodel.nickName;
    }
    
    if(_rankmodel.huaienID == huaien){
        _timeLabel.textColor = [UIColor redColor];
        _nameLabel.textColor = [UIColor redColor];
    }else{
        _timeLabel.textColor = WorkDayColor;
        _nameLabel.textColor = WorkDayColor;
    }
    
    if (indexPath.row==0) {
        _rankImageView.image = [UIImage imageNamed:@"rank_one.png"];
    } else if (indexPath.row==1){
        _rankImageView.image = [UIImage imageNamed:@"rank_two.png"];
        
    } else if (indexPath.row==2){
        _rankImageView.image = [UIImage imageNamed:@"rank_three.png"];
        
    }
    else{
        _rankImageView.hidden = YES;
        _rankLabel.text = [NSString stringWithFormat:@"%ld",(indexPath.row)+1];
    }
    
}
@end