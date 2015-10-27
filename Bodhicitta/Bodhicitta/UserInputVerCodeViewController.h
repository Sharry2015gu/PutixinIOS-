//
//  UserInputVerCodeViewController.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/9/9.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInputVerCodeViewController : UIViewController
@property(nonatomic,strong)NSString *telePhoneStr;
@property(nonatomic,strong)NSString *passWordStr;
//获取验证码是返回给APP的主键ID
@property(nonatomic,strong)NSNumber *keyID;
@end
