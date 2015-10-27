//
//  BuddhaInfoView.h
//  Bodhicitta
//
//  Created by 怀恩11 on 15/9/22.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempleImage.h"

@interface BuddhaInfoView : UIView
{
    UIScrollView * scrollview;
    UIButton * titlebutton;
    UILabel * titleText;
  
    
  
    UIView * maskView;
    UIImageView * iv;
    UIImageView * foxiangImage;
    UIImageView * imageView;
    UIImageView * jianjieImage;
}
-(instancetype)initWithFrame:(CGRect)frame WithModel:(TempleImage *) model;
@property(nonatomic,strong)TempleImage *model;
@property (nonatomic,strong)UILabel *title;
@property(nonatomic,copy)  void (^foTapBlock)(TempleImage *  model);
@property(nonatomic,strong)UITextView * textview;
@property(nonatomic,copy) void(^blockBudd)();

@end
