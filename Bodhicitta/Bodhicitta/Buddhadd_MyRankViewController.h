//
//  Buddhadd_MyRankViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/10/15.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempleImage.h"

@interface Buddhadd_MyRankViewController : UIViewController
@property(nonatomic,strong)TempleImage *templeModel;
@property(nonatomic,strong)NSMutableArray *MyBuddhaArray;
-(instancetype)initWithModel:(TempleImage* )model;
@end
