//
//  PraticeViewCell.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/9/7.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "PraticeViewCell.h"
#import "HeaderFile.h"
@interface PraticeViewCell()

@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UIImageView * rankImageView;
@property(nonatomic,strong)UILabel * rankLabel;
@property(nonatomic,strong)UIImageView * headImageView;
@property(nonatomic,strong)UIImageView * gardImageView;
@property(nonatomic,strong)UILabel * gardLabel;
@end
@implementation PraticeViewCell

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
        font  = 16;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            width = 180;
            height = 95;
            font = 14;
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
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.contentView.frame.size.width*0.4+300,49)];
    bgImageView.image =[UIImage imageNamed:@"putibj.jpg"];
    [self.contentView addSubview:bgImageView];
    
    _rankLabel =[[UILabel alloc]initWithFrame:CGRectMake(width*0.15, height*0.1, 30, 25)];
    _rankLabel.textColor = WorkDayColor;
    [bgImageView addSubview:_rankLabel];
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_rankLabel.frame.origin.x+40, _rankLabel.frame.origin.y, 0.7 * bgImageView.frame.size.height,0.7 * bgImageView.frame.size.height)];
   
    _headImageView.image=[UIImage imageNamed:@"默认头像"];
    CALayer  *layerHeadImageViewLayer = _headImageView.layer;
    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
    layerHeadImageViewLayer.borderWidth = 1.5;
    layerHeadImageViewLayer.masksToBounds = YES;
    layerHeadImageViewLayer.cornerRadius = _headImageView.frame.size.height * 0.5;
    [bgImageView addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_headImageView.frame.origin.x+_rankLabel.frame.size.width+20, _rankLabel.frame.origin.y-10, SCREEN_WIDTH*0.2, 0.075*SCREEN_HEIGHT)];
    
    _nameLabel.text = @"佛学爱好者";
    _nameLabel.font = [UIFont systemFontOfSize:font];
    _nameLabel.textColor = [UIColor redColor];
    [bgImageView addSubview:_nameLabel];
    
    _gardImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_nameLabel.frame.origin.x+_nameLabel.frame.size.width+width*0.02, height*0.2, 30, 15)];
    _gardImageView.image = [UIImage imageNamed:@"LV背景"];
    [bgImageView addSubview:_gardImageView];
    
    _gardLabel = [[UILabel alloc]initWithFrame:CGRectMake(3, -2, 30, 20)];
    _gardLabel.text=@"LV12";
    _gardLabel.textColor=[UIColor whiteColor];
    _gardLabel.font=[UIFont systemFontOfSize:font-5];
    [_gardImageView addSubview:_gardLabel];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.9+width*0.55,height*0.15, 100,20)];
    _timeLabel.font = [UIFont systemFontOfSize:font];
    _timeLabel.textColor = [UIColor redColor];
    [bgImageView addSubview:_timeLabel];
    
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, bgImageView.frame.origin.y+bgImageView.frame.size.height, SCREEN_WIDTH, 1)];
    line.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"rank_line_divide"]];
    [self.contentView addSubview:line];
    
    
}

-(void)setPracticeModel:(PracticeModel *)pramodel IndexPath:(NSIndexPath *) indexPath
{
    
    _practicemodel = pramodel;
    _timeLabel.text = [NSString stringWithFormat:@"%ld",(long)_practicemodel.integral];
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSInteger huaienID = [huaien  integerValue];
    
    if ([_practicemodel.nickName isEqualToString:@""]) {
        
        _nameLabel.text=[NSString stringWithFormat:@"%ld",(long)_practicemodel.huaienID];
    }else{
        
        _nameLabel.text= _practicemodel.nickName;
    }
    if ([_practicemodel.headImg hasPrefix:@"http"]) {
        
          [_headImageView setImageWithURL:[NSURL URLWithString:_practicemodel.headImg]];
    }
    else{
         _headImageView.image=[UIImage imageNamed:@"默认头像"];
   
    }
    if(_practicemodel.huaienID == huaienID){
        _timeLabel.textColor = [UIColor redColor];
        _nameLabel.textColor = [UIColor redColor];
    }else{
        _timeLabel.textColor = WorkDayColor;
        _nameLabel.textColor = WorkDayColor;
    }
    _gardLabel.text = [NSString stringWithFormat:@"LV%ld",_practicemodel.userLevel];
    NSLog(@"_gardLabel.text=%@",_gardLabel.text);
    _rankImageView.hidden = YES;
    _rankLabel.text = [NSString stringWithFormat:@"%ld",(indexPath.row+3)+1];
    
}

@end
