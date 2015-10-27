//
//  TintView.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/25.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "TintView.h"
#import "HeaderFile.h"
@interface TintView()
{
    CGFloat btnHeight;
    CGFloat marginForX;
    CGFloat titleSize;
    CGFloat fontSize;
}
@property(nonatomic,strong)UIView *tintView;
@property(nonatomic,strong)UIImageView *topImageView;
@end
@implementation TintView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    return self;
}
-(void)createSubViews
{
    
    if (fabs(SCREEN_HEIGHT-667) < 1)
    {
        btnHeight = 30;
        fontSize  = 16;
        titleSize = 20;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            btnHeight = 28;
            titleSize = 19;
            fontSize  = 15;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            btnHeight = 35;
            titleSize = 20;
            fontSize  = 15;
        }
        else
        {
            btnHeight = 25;
            titleSize = 18;
            fontSize  = 13;
        }
    }
#pragma mark  -------高度要调
    
    UIView *tintView = [[UIView alloc] initWithFrame:CGRectMake(0.1 *SCREEN_WIDTH,0.2 *SCREEN_HEIGHT, SCREEN_WIDTH - 0.1 * 2 * SCREEN_WIDTH,0.28* SCREEN_HEIGHT)];
    self.tintView = tintView;
    [self addSubview:tintView];
    
    
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,tintView.frame.size.width,0.2 * tintView.frame.size.height)];
    self.topImageView = topImageView;
    topImageView.image = [UIImage imageNamed:@"offer_top_bg_dialog"];
    [self.tintView addSubview:topImageView];
    
    UIImageView * bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,topImageView.frame.size.height,tintView.frame.size.width, 0.8 *tintView.frame.size.height)];
    bottomImageView.image = [UIImage imageNamed:@"offer_bottom_bg_dialog"];
    [self.tintView addSubview:bottomImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,(0.2 * tintView.frame.size.height - 20) / 2,topImageView.frame.size.width,20)];
    titleLabel.text = @"随喜提示";
    titleLabel.textAlignment =  NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:titleSize];
    titleLabel.textColor = [UIColor whiteColor];
    [topImageView addSubview:titleLabel];
    //设置内容
    
    CGFloat  marginX =  0.2 * tintView.frame.size.height;
    CGFloat  relativeMarginX = 0.15 * tintView.frame.size.height;
    CGFloat  width  = (tintView.frame.size.width - 2 * marginX - relativeMarginX) / 2;
    UIButton * resignBtn = [[UIButton alloc] initWithFrame:CGRectMake(marginX,tintView.frame.size.height - btnHeight-18,width,btnHeight)];
    [resignBtn setBackgroundImage:[UIImage imageNamed:@"bt_cancel_offer_bg"] forState:UIControlStateNormal];
    [resignBtn  setTitle:@"取消" forState:UIControlStateNormal];
    resignBtn.titleLabel.font = [UIFont systemFontOfSize:titleSize - 2];
    [resignBtn  setTitleColor:cancelColor forState:UIControlStateNormal];
    [resignBtn addTarget:self action:@selector(resignBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tintView addSubview:resignBtn];
    
    UIButton  *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(marginX+ width +relativeMarginX,tintView.frame.size.height - btnHeight -18,width,btnHeight)];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"bt_sure_offer_bg"] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:titleSize - 2];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.tintView addSubview:submitBtn];
}
-(void)resignBtnClick
{
    self.resignBlock(self.model);
}
-(void)submitBtnClick
{
    self.submitBlock(self.model);
    
    
}
-(void)setModel:(TributeModel *)model
{
    _model = model;
    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    NSString *name  = [NSString stringWithFormat:@" %@ ",model.tasklName];
    CGFloat width = [name sizeWithFont:[UIFont systemFontOfSize:fontSize] maxSize:maxSize].width;
    UILabel *  contentLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0,self.topImageView.frame.size.height+10,self.tintView.frame.size.width,20)];
    
    contentLabel1.font = [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
    contentLabel1.text = [NSString stringWithFormat:@"        神佛庇佑, 供奉%@,随喜奉上",name];
    [self.tintView addSubview:contentLabel1];
    
    NSString *preStr = @"       神佛庇佑, 供奉 ";
    CGFloat marginX = [preStr sizeWithFont:[UIFont systemFontOfSize:fontSize] maxSize:maxSize].width;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(marginX,contentLabel1.frame.origin.y, width, 20)];
    nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
    nameLabel.text = model.tasklName;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.backgroundColor = [UIColor colorWithRed: 255 / 255.0 green: 245 / 255.0 blue:185 / 255.0 alpha:1];
    nameLabel.textColor = [UIColor redColor];
    [self.tintView addSubview:nameLabel];
    
    UILabel * contentLabel2  = [[UILabel alloc] initWithFrame:CGRectMake(0, contentLabel1.frame.size.height+ contentLabel1.frame.origin.y+ 10,self.tintView.frame.size.width,20)];
    contentLabel2.text =  @"  祈福币        个,佛渡有缘人,阿弥陀佛!";
    contentLabel2.font = [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
    [self.tintView addSubview:contentLabel2];
    NSString *preStr1 = @"  祈福币 ";
    NSString *widthStr = @" 10 ";
    CGFloat  coinLabelMarginX =[preStr1 sizeWithFont:[UIFont systemFontOfSize:fontSize] maxSize:maxSize].width;
    CGFloat  coinLabelWidth =  [widthStr sizeWithFont:[UIFont systemFontOfSize:fontSize] maxSize:maxSize].width;
    UILabel *coinLabel = [[UILabel alloc] initWithFrame:CGRectMake(coinLabelMarginX,contentLabel2.frame.origin.y,coinLabelWidth,20)];
    coinLabel.font = [UIFont systemFontOfSize:fontSize];
    coinLabel.backgroundColor = [UIColor clearColor];
    coinLabel.textColor = [UIColor redColor];
    coinLabel.textAlignment = NSTextAlignmentCenter;
    coinLabel.text = [NSString stringWithFormat:@"%ld", (long)model.prayMoney];
    [self.tintView addSubview:coinLabel];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.removeBlock();
}
@end

