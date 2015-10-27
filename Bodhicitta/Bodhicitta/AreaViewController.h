//
//  AreaViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/29.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaViewController : UIViewController

@property(nonatomic,strong) NSString *cityID;

@property(nonatomic,strong) UIViewController  *createVc;
@property(nonatomic,strong)NSString *cityName;
-(NSArray *)loadData;
@end
