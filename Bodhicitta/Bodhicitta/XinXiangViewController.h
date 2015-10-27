//
//  XinXiangViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/9/14.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewModel.h"
@interface XinXiangViewController : UIViewController
@property(nonatomic,strong)NewModel * model;
-(void)getMessageInfo;
-(void)getSetMessageInfon:(NewModel *)model;
@property(nonatomic,strong) id lastViewController;

@end
