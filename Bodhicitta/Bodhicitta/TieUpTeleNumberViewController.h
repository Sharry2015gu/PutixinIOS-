//
//  TieUpTeleNumberViewController.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/9/14.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TieUpTeleNumberViewController : UIViewController
@property(nonatomic,strong) void (^block)(NSString  * telePhoneStr);
@end
