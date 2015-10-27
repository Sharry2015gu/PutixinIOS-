//
//  BuddhaHallView.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/20.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "BuddhaHallView.h"
#import "HeaderFile.h"
#import "TempleImage.h"
#import "CheckBuddhaHallLevel.h"
@interface BuddhaHallView(){
    UIImageView *bgImageView;
}

@end
@implementation BuddhaHallView

#pragma mark 初始化
-(UIButton *)btn
{
    if (_btn == nil) {
        CGFloat width;
        CGFloat size ;
        if (fabs(SCREEN_HEIGHT-667) < 1) {
            width = 85;
            size =  25;
        }
        else
        {
            if (fabs(SCREEN_HEIGHT -568) < 1) {
                width = 80;
                size = 22;
            }
            else if (fabs(SCREEN_HEIGHT - 736) < 1)
            {
                width = 90;
                size = 27;
            }
            else
            {
                width = 70;
                size  = 20;
            }
        }
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,width,width)];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn setBackgroundImage:[UIImage imageNamed:@"gjlf"] forState:UIControlStateNormal];
        _btn.userInteractionEnabled = YES;
        [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        UILabel * qingfoLa=[[UILabel alloc]initWithFrame:CGRectMake(0,(width - 30 * 2) / 2,_btn.frame.size.width,30)];
        qingfoLa.text=@"恭请";
        qingfoLa.textAlignment = NSTextAlignmentCenter;
        qingfoLa.font=[UIFont fontWithName:@"Helvetica-Bold" size:size];
        qingfoLa.textColor=[UIColor whiteColor];
        [_btn addSubview:qingfoLa];
        UILabel * qingfoLa1=[[UILabel alloc]initWithFrame:CGRectMake(0,(width - 30 * 2) / 2 + 30,_btn.frame.size.width,30)];
        qingfoLa1.text=@"佛像";
        qingfoLa1.textAlignment = NSTextAlignmentCenter;
        qingfoLa1.font=[UIFont fontWithName:@"Helvetica-Bold" size:size];
        qingfoLa1.textColor=[UIColor whiteColor];
        [_btn addSubview:qingfoLa1];
    }
    return _btn;
}
-(UIImageView *)vaseImageView1
{
    if (_vaseImageView1 == nil) {
        _vaseImageView1 = [[UIImageView alloc]init];
    }
    return _vaseImageView1;
}
-(UIImageView *)vaseImageView2
{
    if (_vaseImageView2 == nil) {
        _vaseImageView2 = [[UIImageView alloc]init];
    }
    return _vaseImageView2;
}
-(UIImageView *)lightImageView1
{
    if (_lightImageView1 == nil) {
        _lightImageView1 = [[UIImageView alloc]init];
    }
    return _lightImageView1;
}
-(UIImageView *)lightImageView2
{
    if (_lightImageView2 == nil) {
        _lightImageView2 = [[UIImageView alloc]init];
    }
    return _lightImageView2;
}

-(UIImageView *)teacupImageView1
{
    if (_teacupImageView1 == nil) {
        _teacupImageView1 = [[UIImageView alloc] init];
    }
    return _teacupImageView1;
}
-(UIImageView *)teacupImageView2
{
    if (_teacupImageView2 == nil) {
        _teacupImageView2 = [[UIImageView alloc] init];
    }
    return _teacupImageView2;
}
-(UIImageView *)teacupImageView3
{
    if (_teacupImageView3 == nil) {
        _teacupImageView3 = [[UIImageView alloc] init];
    }
    return _teacupImageView3;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createSubViews];
    }
    return self;
}

-(void)setModel:(TempleImage *)model
{
    //改在这里的
    _model = model;
    if (model.buddhistTempleID == 0) {
        self.btn.hidden = NO;
        bgImageView.hidden=YES;
        _bgimageview.hidden=NO;
    }
    [self.vaseImageView1 setImage:[UIImage imageNamed:@"empty_flower_vase.png"]];
//    [self.vaseImageView1 setImageWithURL:[NSURL URLWithString:model.flowerUrl] placeholderImage:[UIImage imageNamed:@"empty_flower_vase.png"]];
//    [self.vaseImageView2 setImageWithURL:[NSURL URLWithString:model.flowerUrl] placeholderImage:[UIImage imageNamed:@"empty_flower_vase.png"]];
    [self.teacupImageView1 setImage:[UIImage imageNamed:@"cup_has_tea"]];
//    [self.teacupImageView2 setImageWithURL:[NSURL URLWithString:model.teaUrl] placeholderImage:[UIImage imageNamed:@"茶杯"]];
//    [self.teacupImageView3 setImageWithURL:[NSURL URLWithString:model.teaUrl] placeholderImage:[UIImage imageNamed:@"茶杯"]];
    [self.burnerImageView setImageWithURL:[NSURL URLWithString:model.incenseUrl] placeholderImage:[UIImage imageNamed:@"empty_censer.png"]];
    [self.buddhaImageView setImageWithURL:[NSURL URLWithString:model.materialImageUrl] placeholderImage:[UIImage imageNamed:@"480佛"]];
    NSLog(@"model.materialImageUrl=%@",model.materialImageUrl);
    _totalLabel.text=[NSString stringWithFormat:@"%ld",model.templeIntegral];
    NSInteger grad =model.templeIntegral;
    
    CheckBuddhaHallLevel *levelManager = [CheckBuddhaHallLevel   shareCheckBuddhaHallLevel];
    NSInteger   levelInteger = [levelManager checkBuddhaHallLevelWithValue:grad];
    _gradLabel.text=[NSString stringWithFormat:@"%ld",levelInteger];
    [self.fruitBowlImageView1 setImageWithURL:[NSURL URLWithString:model.tributeURL] placeholderImage:[UIImage imageNamed:@"dish_icon.png"]];
    [self.fruitBowlImageView2 setImageWithURL:[NSURL URLWithString:model.tributeURL] placeholderImage:[UIImage imageNamed:@"dish_icon.png"]];
    
    
}
-(void)createSubViews
{
    bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,self.frame.size.height)];
    bgImageView.image = [UIImage imageNamed:@"buddha_view_bg480.gif"];
    bgImageView.userInteractionEnabled = YES;
    [self addSubview:bgImageView];
    
    _bgimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,self.frame.size.height)];
    _bgimageview.image=[UIImage imageNamed:@"buddha_view_no_guang_bg.gif"];
    [self addSubview:_bgimageview];

    //距离最底端的
    CGFloat marginV = 20;
    //可以根据宽改动
    CGFloat marginX = 30 ;
    CGFloat width = (SCREEN_WIDTH - 4 * marginX) / 3;
    CGFloat height  = width * 0.6;
    
    self.wishBtn=[[UIButton alloc]initWithFrame:CGRectMake(marginX+40,self.frame.size.height- marginV-height*1, width*0.9, height*0.7)];
    [self.wishBtn setBackgroundImage:[UIImage imageNamed:@"wish_something.png"] forState:UIControlStateNormal];
    [self.wishBtn addTarget:self action:@selector(wishClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.wishBtn];
    
    UIImageView * gardImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.wishBtn.frame.origin.x+width*0.95, self.wishBtn.frame.origin.y, width*0.9, height*0.7)];
    gardImageView.image=[UIImage imageNamed:@"temp_level_bg.png"];
    [self addSubview:gardImageView];
    self.gradLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 8, 50, 20)];
    self.gradLabel.textColor=[UIColor redColor];
    self.gradLabel.font=[UIFont systemFontOfSize:9];
    [gardImageView addSubview:self.gradLabel];
    self.vowBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-marginX-width*1.35,self.wishBtn.frame.origin.y, width*0.9, height*0.7)];
    [self.vowBtn setBackgroundImage:[UIImage imageNamed:@"votive_whis.png"] forState:UIControlStateNormal];
    [self.vowBtn addTarget:self action:@selector(vowClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.vowBtn];
#pragma mark --果盘--
    self.fruitBowlImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(marginX, self.frame.size.height - marginV - height*2.6 , width,height*1.4)];
    self.fruitBowlImageView1.userInteractionEnabled=YES;
    UITapGestureRecognizer * fruitTap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fruitTap1Click)];
    [self.fruitBowlImageView1 addGestureRecognizer:fruitTap1];
    self.fruitBowlImageView1.image = [UIImage imageNamed:@"dish_icon.png"];
    [self addSubview:self.fruitBowlImageView1];

    self.fruitBowlImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - marginX - width,self.fruitBowlImageView1.frame.origin.y ,width,height*1.4)];
    self.fruitBowlImageView2.userInteractionEnabled=YES;
    UITapGestureRecognizer * fruitTap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fruitTap2Click)];
    [self.fruitBowlImageView2 addGestureRecognizer:fruitTap2];
    self.fruitBowlImageView2.image = [UIImage imageNamed:@"dish_icon.png"];
    [self addSubview:self.fruitBowlImageView2];
#pragma mark --茶--
    CGFloat teaCupMargin = 10;
    CGFloat teaCupWidth =  (width - 2*teaCupMargin);
    CGFloat teaCupHeight = teaCupWidth * 1.5;
    _teacupImageView1  = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.fruitBowlImageView1.frame) + marginX,self.frame.size.height - marginV*6,teaCupWidth*1.5,teaCupHeight*0.3)];
    _teacupImageView1.userInteractionEnabled=YES;
    _teacupImageView1.image = [UIImage imageNamed:@"cup_no_tea"];
    UITapGestureRecognizer * teaTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(teaTapClick)];
    [_teacupImageView1 addGestureRecognizer:teaTap];
    [self addSubview:_teacupImageView1];

#pragma mark --香---
    self.burnerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.5 * SCREEN_WIDTH - 0.6 * width+8,self.fruitBowlImageView1.frame.origin.y - height * 2.3,width, 2.2* height)];
    self.burnerImageView.userInteractionEnabled=YES;
    UITapGestureRecognizer * incentseTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(incentseClick)];
    [self.burnerImageView addGestureRecognizer:incentseTap];
    self.burnerImageView.image = [UIImage imageNamed:@"empty_censer.png"];
#pragma mark ----花---
    //根据宽度改变
    CGFloat marginX1 = 35;
    CGFloat widthVase = 50;
    CGFloat widthLight = 45;
    
    NSArray *vaseArray = @[self.vaseImageView1,self.vaseImageView2];
    for(int i = 0 ; i < vaseArray.count ; i++)
    {
        UIImageView  * vaseImageView = vaseArray[i];
        vaseImageView.frame = CGRectMake(i==0?self.fruitBowlImageView1.frame.origin.x - 0.4 * widthVase:SCREEN_WIDTH - 0.8 * widthVase - widthVase+30,CGRectGetMinY(self.fruitBowlImageView1.frame) - marginV - 2 * widthVase-widthVase*0.4,widthVase,2.5*widthVase);
        vaseImageView.userInteractionEnabled=YES;
        vaseImageView.image = [UIImage imageNamed:@"empty_flower_vase.png"];
        UITapGestureRecognizer * flowerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(flowerClick)];
        [vaseImageView addGestureRecognizer:flowerTap];
        //[self addSubview:vaseImageView];
    }
#pragma mark ---灯----
    NSArray *lightArray = @[self.lightImageView1,self.lightImageView2];
    for(int i = 0 ; i < lightArray.count; i++)
    {
        UIImageView  *imageView = lightArray[i];
        CGFloat vaseX;
        if (i == 0 ) {
            vaseX = self.vaseImageView1.frame.origin.x + self.vaseImageView1.frame.size.width+ marginX1-20;
        }
        else
        {
            vaseX = self.vaseImageView2.frame.origin.x - marginX1 - widthVase+30;
        }
        imageView.frame  = CGRectMake(vaseX,CGRectGetMaxY(self.vaseImageView1.frame) - 2*widthLight,widthLight,2 * widthLight);
        imageView.image = [UIImage imageNamed:@"dark_light1.png"];
        //[self addSubview:imageView];
    }
    
    CGFloat  height1;
    CGFloat  size1;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        height1 = 260;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            height1 = 250;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            height1 = 280;
        }
        else
        {
            height1 = 200;
        }
    }
    //佛像高度要改
    //点击佛像
    self.buddhaImageView  = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - ((self.frame.size.height - height)*0.6)) / 2, 64,(self.frame.size.height - height)*0.6, self.frame.size.height - height1+10)];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [self.buddhaImageView addGestureRecognizer:tap];
    self.buddhaImageView.userInteractionEnabled = YES;
    self.buddhaImageView.image = [UIImage imageNamed:@"480佛"];
    self.buddhaImageView.userInteractionEnabled=YES;
    self.btn.center = self.buddhaImageView.center;
//    CGRect btnFrame =  self.btn.frame;
    self.btn.hidden = YES;
    [self addSubview:self.buddhaImageView];
    [self addSubview:self.vaseImageView1];
    [self addSubview:self.vaseImageView2];
    [self addSubview:self.lightImageView1];
    [self addSubview:self.lightImageView2];
    [self addSubview:self.burnerImageView];
    [self addSubview:self.btn];
    
    _bgimageview.hidden=YES;

}
-(void)btnClick
{
    self.block();
}
-(void)tapClick{
    
    self.tapBlock(self.model);
    
}
-(void)wishClick{

    self.wishBlock();
}
-(void)vowClick{
    
    self.vowBlock();
}
-(void)teaTapClick{

    self.teaaBlock();
}
-(void)flowerClick{

    self.flowerBlock();
}
-(void)incentseClick{

    self.increntseBlock();
}
-(void)fruitTap1Click{

    self.fruitBliock();
}
-(void)fruitTap2Click{
    
    self.fruitBliock();
}
@end

