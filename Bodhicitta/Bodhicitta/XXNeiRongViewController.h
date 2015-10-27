//
//  XXNeiRongViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/18.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XinXiangViewController.h"
#import "NewModel.h"
@interface XXNeiRongViewController : UIViewController{

    UIButton * delection;
    
    UILabel * timer;
    UITextView * neirongText;
}
@property(nonatomic,strong) NewModel *model;
@property(nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString * centrol;
@property(nonatomic,strong)NSString * data;
-(void)getSetMessageInfon:(NewModel *)model;
@property(nonatomic,strong)id lastViewConrtroller;
@end
