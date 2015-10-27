//
//  HomeWorkViewCell.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/19.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "HomeWorkViewCell.h"
#import "HeaderFile.h"
@interface HomeWorkViewCell()
@property(nonatomic,strong)UIImageView * titleImageView;
@property(nonatomic,strong)UIButton * completeBtn;
@property(nonatomic,strong)UILabel * numberLabel;
@property(nonatomic,strong)UILabel * explainLabel;
@property(nonatomic,strong)UILabel * nameLabel;
@end

@implementation HomeWorkViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}
-(void)createSubViews{
    
    //用于判断设备
    CGFloat width;
    CGFloat height;
    CGFloat font;
    if (fabs(SCREEN_HEIGHT-667) < 1)
    {
        width = 215;
        height =  280;
        font=16;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            width = 180;
            height = 280;
            font=14;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            width = 245;
            height = 280;
            font=16;
        }
        else
        {
            width = 180;
            height = 280;
            font=14;
        }
    }
    
    CALayer *layer = self.contentView.layer;
    //    layer.cornerRadius = 3;
    layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"putibj.jpg"]];
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.contentView.frame.size.width*0.4+300,height*0.2)];
    bgImageView.image =[UIImage imageNamed:@"04"];
    [self.contentView addSubview:bgImageView];
    
    _titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(width*0.1, 8, width*0.2, height*0.15)];
    _titleImageView.image = [UIImage imageNamed:@"08"];
    [bgImageView addSubview:_titleImageView];
    
    _nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(_titleImageView.frame.origin.x+_titleImageView.frame.size.height+10, 8, width*0.4, 20)];
    _nameLabel.text=@"妙音法洗";
    _nameLabel.font=[UIFont systemFontOfSize:font];
    [bgImageView addSubview:_nameLabel];
    
    _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleImageView.frame.origin.x+_titleImageView.frame.size.height+78, 8, width*0.9, 20)];
    _numberLabel.text=@"抄经抄了5分钟";
    _numberLabel.textColor=WorkDayColor;
    _numberLabel.font=[UIFont systemFontOfSize:font-4];
    [bgImageView addSubview:_numberLabel];
    
    _explainLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleImageView.frame.origin.x+_titleImageView.frame.size.height+10, 30, width*0.9, 20)];
    _explainLabel.text=@"积德福，受庇佑，消天灾";
    _explainLabel.font=[UIFont systemFontOfSize:font-4];
    _explainLabel.textColor=WorkDayColor;
    [bgImageView addSubview:_explainLabel];
    
    _completeBtn = [[UIButton alloc]initWithFrame:CGRectMake(_numberLabel.frame.origin.x+_numberLabel.frame.size.width+width*0.01-37, height*0.06, width*0.3, height*0.09)];
    [_completeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _completeBtn.titleLabel.font=[UIFont systemFontOfSize:font-2];
    [_completeBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_completeBtn];
}
-(void)completeBtnClick{
    
    self.redeemVowBlock(self.homemodel);
}
-(void)setHomeWorkModel:(HomeWorkModel *)homemodel
{
    
    _homemodel = homemodel;
    _nameLabel.text= _homemodel.taskName;
    _numberLabel.text=_homemodel.achieveCond;
    _explainLabel.text = _homemodel.taskDesc;
    [_titleImageView setImageWithURL:[NSURL URLWithString:_homemodel.logoUrl]];
    
    if([_homemodel.achieveFlag isEqualToString:@"N"]){
        
        [_completeBtn setBackgroundImage:[UIImage imageNamed:@"05"] forState:UIControlStateNormal];
        [_completeBtn setTitle:@"前往" forState:UIControlStateNormal];
        [_completeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else if([_homemodel.achieveFlag isEqualToString:@"Y"]){
        
        [_completeBtn setBackgroundImage:[UIImage imageNamed:@"03"] forState:UIControlStateNormal];
        [_completeBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_completeBtn setTitleColor:majorityColor forState:UIControlStateNormal];
        
    }else if([_homemodel.achieveFlag isEqualToString:@"E"]){
        
        [_completeBtn setBackgroundImage:[UIImage imageNamed:@"kong"] forState:UIControlStateNormal];
        _completeBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        [_completeBtn setTitle:@"尚未开放" forState:UIControlStateNormal];
        [_completeBtn setTitleColor:[[UIColor alloc]initWithRed:170.0f/255.0f green:170.0f/255.0f blue:170.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
    }
    
    
}

@end
