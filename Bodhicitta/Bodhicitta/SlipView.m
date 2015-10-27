//
//  SlipView.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/26.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "SlipView.h"
#import  "HeaderFile.h"
@interface  SlipView()
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *contentLabel;
@property(nonatomic,strong) UILabel *resultLabel;
@property(nonatomic,strong) UIButton *btn;

@end
@implementation SlipView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // self.backgroundColor = [UIColor yellowColor];
        [self createSubViews];
    }
    return self;
}
-(void)createSubViews
{
    UIImageView  *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height - 50)];
    bgImageView.image = [UIImage imageNamed:@"please_buddha_rule_bg"];
    [self addSubview:bgImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,30,bgImageView.frame.size.width,20)];
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [bgImageView addSubview:self.titleLabel];
    
    UIImageView  *slipImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.15 * self.frame.size.width, self.titleLabel.frame.origin.x+20,0.1 * bgImageView.frame.size.width-10,bgImageView.frame.size.height- 15 - 10 - 60)];
    slipImageView.image = [UIImage imageNamed:@"sign_stick_stick"];
    [bgImageView addSubview:slipImageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(bgImageView.frame.size.width * 0.5 - 40,self.titleLabel.frame.size.height + self.titleLabel.frame.origin.y + 5,50,20)];
    label.text = @"签文:";
    label.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
    [bgImageView addSubview:label];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(label.frame.origin.x,label.frame.size.height+label.frame.origin.y-3,bgImageView.frame.size.width - label.frame.origin.x,(label.frame.size.height+label.frame.origin.y+10))];
    self.contentLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    self.contentLabel.numberOfLines=4;
    [bgImageView addSubview:self.contentLabel];
    
    self.resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(slipImageView.frame.origin.x+20,CGRectGetMaxY(slipImageView.frame)+10,bgImageView.frame.size.width - 2*slipImageView.frame.origin.x,40)];
    self.resultLabel.numberOfLines = 0;
    self.resultLabel.font=[UIFont systemFontOfSize:14];
    [bgImageView addSubview:self.resultLabel];
    
    self.btn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.5 - 50,CGRectGetMaxY(bgImageView.frame)+ 25, 100,30)];
    [self.btn setBackgroundImage:[UIImage imageNamed:@"bt_please_buddha_bg"] forState:UIControlStateNormal];
    [self.btn setTitleColor:Typeface forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn];
}
-(void)setModel:(SlipModel *)model
{
    _model = model;
    self.titleLabel.text =  model.title;
    self.contentLabel.text = model.content;
    self.resultLabel.text = model.result;
    [self.btn setTitle:model.btnTitle forState:UIControlStateNormal];
}
-(void)btnClick
{
    self.block(self.model);
    
}
@end

