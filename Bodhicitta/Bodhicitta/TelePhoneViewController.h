//
//  TelePhoneViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/1.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FangShiViewController.h"
@interface TelePhoneViewController : UIViewController{


    UIButton * backbt;
    
    UILabel * nametext;
    UITextField * yanzhengtext;
    UITextField * passwork;
    UIButton * huan;
    UIButton * sure;
    UILabel * nameiv;
    UILabel * yaniv;
    UILabel * pass;
    UIButton * quxiao;
    int num;

}
//获取验证码是返回给APP的主键ID
@property(nonatomic,strong)NSNumber *keyID;

@end
