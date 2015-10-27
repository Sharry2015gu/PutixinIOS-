//
//  BuddhaHallView.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/20.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempleImage.h"
@interface BuddhaHallView : UIView
@property(nonatomic,strong)UIImageView  *buddhaImageView;
@property(nonatomic,strong)UIImageView  *vaseImageView1;
@property(nonatomic,strong)UIImageView  *vaseImageView2;
@property(nonatomic,strong)UIImageView  *lightImageView1;
@property(nonatomic,strong)UIImageView  *lightImageView2;
@property(nonatomic,strong)UIImageView  *burnerImageView;
@property(nonatomic,strong)UIImageView  *fruitBowlImageView1;
@property(nonatomic,strong)UIImageView  *fruitBowlImageView2;
@property(nonatomic,strong)UIImageView  *teacupImageView1;
@property(nonatomic,strong)UIImageView  *teacupImageView2;
@property(nonatomic,strong)UIImageView  *teacupImageView3;
@property(nonatomic,strong)UIImageView * bgimageview;
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)TempleImage  *model;
@property(nonatomic,strong)UILabel * totalLabel;
@property(nonatomic,strong)UILabel * gradLabel;
@property(nonatomic,strong)UIButton * wishBtn;
@property(nonatomic,strong)UIButton * vowBtn;

//是否显示请佛按钮
//开始请佛
@property(nonatomic,copy) void(^block)();
//佛像简介
@property(nonatomic,copy) void(^tapBlock)(TempleImage *model);
//许愿的按钮
@property(nonatomic,copy)void(^wishBlock)();
//还愿
@property(nonatomic,copy)void(^vowBlock)();
//花
@property(nonatomic,copy)void(^flowerBlock)();
//果盘
@property(nonatomic,copy)void(^fruitBliock)();
//香
@property(nonatomic,copy)void(^increntseBlock)();
//茶
@property(nonatomic,copy)void(^teaaBlock)();
@property(nonatomic,assign) BOOL isBtnHidden;
-(instancetype)initWithFrame:(CGRect)frame;
-(void)setModel:(TempleImage *)model;
@end
