//
//  BuddhaCollectionViewCell.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/11.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "BuddhaCollectionViewCell.h"
#import "HeaderFile.h"
@interface BuddhaCollectionViewCell()
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIImageView *buddhaImageView;
@property(nonatomic,strong)UIImageView *lightImageView;
@property(nonatomic,strong)UILabel * huoLabel;
@property(nonatomic,strong)UILabel * meaningLabel;
@property(nonatomic,strong)UIImageView * huoImageView;
@property(nonatomic,strong)UIImageView * nameBGImageView;
@property(nonatomic,strong)UIImageView * nameLightImageView;
@end
@implementation BuddhaCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        [self createSubView];
    }
    return self;
}
-(void)createSubView
{
    self.lightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,5,self.frame.size.width,self.frame.size.height)];
    self.lightImageView.image = [UIImage imageNamed:@"Glow"];
    
    self.nameBGImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0.2*self.frame.size.width,self.frame.size.height-20,0.6*self.frame.size.width,20)];
    self.nameBGImageView.image=[UIImage imageNamed:@"RedBlock1"];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.2 *self.frame.size.width,self.frame.size.height-20,0.6*self.frame.size.width,20)];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont boldSystemFontOfSize:10];
    //    self.nameLabel.numberOfLines = 8;
    self.nameLabel.textColor = TempleNameLa;
    
    self.meaningLabel = [[UILabel alloc] initWithFrame: CGRectMake(0.88*self.bounds.size.width, 1,20,self.bounds.size.height-2)];
    self.meaningLabel.textColor=TempleNameLa;
    self.meaningLabel.font=[UIFont systemFontOfSize:11];
    //    self.meaningLabel.numberOfLines=8;
    
    [self.meaningLabel setNumberOfLines:0];
    
    self.frameWorkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
    [self addSubview:self.frameWorkImageView];
    
    [self addSubview:self.lightImageView];
    self.lightImageView.hidden = YES;
    
    UIControl *ctrl = [[UIControl alloc]init];
    //ctrl.backgroundColor = [UIColor yellowColor];
    ctrl.frame = self.frameWorkImageView.frame;
    [ctrl addTarget:self action:@selector(ctrlClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.huoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 165, 8, 16)];
    self.huoImageView.image=[UIImage imageNamed:@"huo"];
    [self addSubview:self.huoImageView];
    
    self.huoLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 165, 100, 20)];
    //    self.huoLabel.text=@"102";
    self.huoLabel.font=[UIFont systemFontOfSize:12];
    self.huoLabel.textColor=TypefaceName;
    [self addSubview:self.huoLabel];
    
    self.buddhaImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(0.1 *self.frame.size.width,0.2*self.frame.size.height,0.8*self.frame.size.width,0.8*self.frame.size.height)];
    [self addSubview:self.buddhaImageView];
    self.buddhaImageView.userInteractionEnabled  = YES;
    
    [self.buddhaImageView addSubview:ctrl];
    
    [self addSubview:self.nameBGImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.meaningLabel];
    
}
-(void)setModel:(TempleImage *)model
{
    _model = model;
    [self.buddhaImageView setImageWithURL:[NSURL URLWithString:model.materialImageUrl]];
    NSLog(@"model.materialImageUrl=%@",model.materialImageUrl);
    self.nameLabel.text = model.taskName;
    self.meaningLabel.text=model.meaning;
    self.huoLabel.text=[NSString stringWithFormat:@"%@", model.TotalQty];
    
}
-(void)ctrlClick
{
    self.selectBlock(self.model,self.lightImageView,self.nameBGImageView,self.nameLabel);
    self.lightImageView.hidden = NO;
}
@end