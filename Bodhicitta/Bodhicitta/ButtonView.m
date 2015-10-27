//
//  ButtonView.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/9/26.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "ButtonView.h"
#import "HeaderFile.h"
@interface ButtonView()
@property(nonatomic,strong)UIButton * dayRankBtn;
@property(nonatomic,strong)UIButton * weekRankBtn;
@property(nonatomic,strong)UIButton * monthRankBtn;
@property(nonatomic,strong)UIButton * totalRankBtn;
@end
@implementation ButtonView

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
//        selectStyleIndex = 3;
        [self createSubViews];
    }
    return self;
}
-(void)createSubViews{
    CGFloat width;
    CGFloat height ;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        width = 205;
        height =  140;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            width = 180;
            height = 125;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            width = 190;
            height = 127;
        }
        else
        {
            width = 175;
            height  = 120;
        }
    }
    
    
    
}
@end
