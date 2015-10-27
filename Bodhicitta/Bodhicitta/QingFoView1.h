//
//  QingFoView1.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/22.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempleImage.h"
@interface QingFoView1 : UIView
{
    UIScrollView * scrollview;
    UIButton * titlebutton;
    UILabel * titleText;
    UIButton * qingfoBt;
    
    UILabel * title;
    UIView * maskView;
    UIImageView * iv;
    UIImageView * foxiangImage;
    UIImageView * imageView;
    UIImageView * jianjieImage;
    
    
    
}
-(instancetype)initWithFrame:(CGRect)frame WithModel:(TempleImage *) model;
@property(nonatomic,strong)TempleImage *model;
@property(nonatomic,copy)  void (^submitBlock)(TempleImage *  model);
@property(nonatomic,strong)UITextView * textview;

//-(void)getBuddhaExplainInfo;
@end
