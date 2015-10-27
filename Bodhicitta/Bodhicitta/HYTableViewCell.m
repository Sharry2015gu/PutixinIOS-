//
//  HYTableViewCell.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/6.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "HYTableViewCell.h"
#import "HeaderFile.h"

@interface HYTableViewCell()
@property(nonatomic,strong)UIImageView *iconView;
@property(nonatomic,strong)UILabel * nameText;
@property(nonatomic,strong)UILabel * fistTimeLabel;
@property(nonatomic,strong)UILabel * lastTimeLabel;
@property(nonatomic,strong)UILabel * contentText;
@property(nonatomic,strong)UILabel * fangshiText;
@property(nonatomic,strong)UILabel * fulfildateLabel;

@property(nonatomic,strong)NSArray  *waysArray;
@end

@implementation HYTableViewCell
-(NSArray *) waysArray
{
    if (_waysArray == nil) {
        _waysArray = @[@"[10祈福币]",@"[100祈福币]",@"[1000祈福币]"];
    }
    return _waysArray;
}
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
    layer.masksToBounds = YES;
    self.backgroundColor = [UIColor redColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,114)];
    bgImageView.image =[UIImage imageNamed:@"putibj.jpg"];
    [self.contentView addSubview:bgImageView];
    
    CGFloat  marginX  =  15;
    CGFloat  marginTop  = (115 - 4* 25) / 2;
    UILabel *l1 = [[UILabel alloc]initWithFrame:CGRectMake(marginX,marginTop, 70, 25)];
    l1.text = @"为谁许愿:";
    l1.font = [UIFont systemFontOfSize:16];
    l1.textColor = [UIColor brownColor];
    [bgImageView addSubview:l1];
    
    _nameText = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(l1.frame), l1.frame.origin.y,SCREEN_WIDTH - CGRectGetMaxX(l1.frame) - 80,25)];
    _nameText.font = [UIFont systemFontOfSize:16];
    _nameText.textColor = [UIColor brownColor];
    [bgImageView addSubview:_nameText];
    
    UILabel *l2 = [[UILabel alloc] initWithFrame:CGRectMake(marginX,l1.frame.origin.y+l1.frame.size.height,l1.frame.size.width, 25)];
    l2.textColor = [UIColor brownColor];
    l2.text = @"许愿内容:";
    l2.font = [UIFont systemFontOfSize:16];
    [bgImageView addSubview:l2];
    
    _contentText = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(l2.frame), l2.frame.origin.y,_nameText.frame.size.width, 25)];
    _contentText.textColor = [UIColor brownColor];
    _contentText.font = [UIFont systemFontOfSize:16];
    [bgImageView addSubview:_contentText];
    
    UILabel *l3 = [[UILabel alloc] initWithFrame:CGRectMake(l2.frame.origin.x,l2.frame.origin.y+l2.frame.size.height,l1.frame.size.width,25)];
    l3.text = @"还愿方式:";
    l3.textColor = [UIColor brownColor];
    l3.font = [UIFont systemFontOfSize:16];
    [bgImageView addSubview:l3];
    
    _fangshiText = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(l3.frame), l3.frame.origin.y, _nameText.frame.size.width, 25)];
    _fangshiText.textColor = [UIColor redColor];
//    _fangshiText.text=@"[敬香]";
    _fangshiText.font = [UIFont systemFontOfSize:16];
    [bgImageView addSubview:_fangshiText];
    
    UILabel *l4 = [[UILabel alloc] initWithFrame:CGRectMake(l3.frame.origin.x,l3.frame.origin.y+l3.frame.size.height,50,25)];
    l4.text = @"许愿日:";
    l4.textColor = [UIColor lightGrayColor];
    l4.font = [UIFont systemFontOfSize:14];
    [bgImageView addSubview:l4];
    
    _fistTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(l4.frame),l4.frame.origin.y, 100, 25)];
    _fistTimeLabel.textColor = [UIColor lightGrayColor];
    _fistTimeLabel.font = [UIFont systemFontOfSize:14];
    [bgImageView addSubview:_fistTimeLabel];
    
    UILabel *l5 = [[UILabel alloc] initWithFrame:CGRectMake(_fistTimeLabel.frame.origin.x+_fistTimeLabel.frame.size.width+50,_fistTimeLabel.frame.origin.y,50,25)];
    l5.text = @"还愿日:";
    l5.textColor = [UIColor lightGrayColor];
    l5.font = [UIFont systemFontOfSize:14];
//    [bgImageView addSubview:l5];
    
    _lastTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(l5.frame),l4.frame.origin.y, 100, 25)];
    _lastTimeLabel.textColor = [UIColor lightGrayColor];
    _lastTimeLabel.font = [UIFont systemFontOfSize:14];
//    [bgImageView addSubview:_lastTimeLabel];

    _vowBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH- 90, ( 115 - 30) / 2,80, 30)];
    // [_vowBtn setTitle:@"前去许愿" forState:UIControlStateNormal];
    _vowBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [_vowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_vowBtn setBackgroundImage:[UIImage imageNamed:@"go_votive_bg"] forState:UIControlStateNormal];
    [_vowBtn addTarget:self action:@selector(vowBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_vowBtn];

    self.fulfildateLabel = [[UILabel alloc]initWithFrame:CGRectMake(_vowBtn.frame.origin.x-45,_fistTimeLabel.frame.origin.y,150,25)];
    self.fulfildateLabel.textAlignment = NSTextAlignmentLeft;
    self.fulfildateLabel.font = [UIFont systemFontOfSize:14];
    self.fulfildateLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.fulfildateLabel];
}
-(void)vowBtnClick
{
    self.redeemVowBlock(self.templemodel);
}
-(void)setModel:(TempleVow *)temodel
{
    
    _templemodel = temodel;
    _nameText.text= temodel.wishFor;
    NSInteger  styleId  = [temodel.fulfileTaskType integerValue];
    _fangshiText.text = self.waysArray[styleId];
    _contentText.text = temodel.wishContent;
    _fistTimeLabel.text= temodel.createDate;
//    _lastTimeLabel.text = temodel.fulfildate;
    if (temodel.fulfilID == 0) {
        [_vowBtn setTitle:@"前去许愿" forState:UIControlStateNormal];
        [_vowBtn setBackgroundImage:[UIImage imageNamed:@"go_votive_bg"] forState:UIControlStateNormal];
        self.fulfildateLabel.text = @"";
    }
    else
    {
        [_vowBtn setTitle:@"还愿成功" forState:UIControlStateNormal];
        [_vowBtn setBackgroundImage:[UIImage imageNamed:@"has_votive_bg"] forState:UIControlStateNormal];
        self.fulfildateLabel.text = [NSString stringWithFormat:@"还愿日: %@",temodel.fulfildate];
    }
}
@end
