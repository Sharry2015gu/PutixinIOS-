//
//  TeaView.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/13.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "TeaView.h"
#import "HeaderFile.h"
@interface TeaView()
@property(nonatomic,strong)UIImageView *teaImageView;
@property(nonatomic,strong)UIButton *questionBtn;
@property(nonatomic,strong)UIImageView *flowerImageView;
@property(nonatomic,strong)UILabel *coinLabel;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIImageView * fugeiImageView;
@end
@implementation TeaView
-(instancetype)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        
        
        [self createSubViews];
    }
    return self;
}
-(void)createSubViews
{
    
    
    self.teaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.2*self.frame.size.width,self.frame.size.height*0.25,0.35*self.frame.size.width,self.frame.size.height* 0.8 - 20)];
    [self addSubview:self.teaImageView];
    
    self.questionBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.55 *self.frame.size.width,self.frame.size.height*0.3,20,20)];
    [self.questionBtn setImage:[UIImage imageNamed:@"thing_detail"] forState:UIControlStateNormal];
    [self.questionBtn addTarget:self action:@selector(questionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.flowerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.55 * self.frame.size.width,CGRectGetMaxY(self.teaImageView.frame) - 22,0.2*self.frame.size.height,20)];
    self.flowerImageView.image = [UIImage imageNamed:@"price_icon"];
    [self addSubview:self.flowerImageView];
    
    self.coinLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.flowerImageView.frame),CGRectGetMaxY(self.teaImageView.frame) - 20,self.frame.size.width - CGRectGetMaxX(self.flowerImageView.frame),20)];
    self.coinLabel.font = [UIFont systemFontOfSize:10];
    self.coinLabel.textColor = majorityColor;
    [self addSubview:self.coinLabel];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width,20)];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.textColor= [UIColor whiteColor];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.nameLabel];
    
    UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
    [control addTarget:self action:@selector(SelectTributeClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:control];
    [self addSubview:self.questionBtn];
}
-(void)SelectTributeClick
{
    self.selectBlock(self.model);
}
-(void)questionBtnClick
{
    self.questionBlock(self.model.meaning);
}
-(void)setModel:(TributeModel *)model
{
    _model = model;
    self.coinLabel.text = [NSString stringWithFormat:@"%ld",(long)model.prayMoney];
    [self.teaImageView setImageWithURL:[NSURL URLWithString:model.materialImageUrl]];
    self.nameLabel.text = model.tasklName;
    
}
@end

