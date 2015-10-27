//
//  AddressViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/29.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressViewController : UIViewController

@property(nonatomic,strong)UILabel *selectLabel;
@property(nonatomic,strong)NSString * resultAdressStr;
@property (nonatomic,strong)void (^block)(NSString *name);
@property(nonatomic,strong) UIViewController  *createVc;
// @property (nonatomic,weak)id <DWresultDelegate>delegate;
@property (nonatomic,strong)NSString *areaID;
@end
