//
//  UserInfoEditingViewController.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/9/10.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
@interface UserInfoEditingViewController : UIViewController
@property(nonatomic,strong) id lastViewController;
//用于更换地址
-(void)changeAddressFunctionWithAdressStr:(NSString *) addressStr;

//判断是否更改背景图
@property(nonatomic,assign)NSInteger isChange;
//返回时带回选择的皮肤
@property(nonatomic,strong)void (^block)(UIImage  * image);

@end
