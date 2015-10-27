//
//  UserInfoprefectViewController.h
//  Bodhicitta
//
//  Created by 怀恩11 on 15/9/21.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoprefectViewController : UIViewController
@property(nonatomic,strong) id lastViewController;
//用于更换地址
-(void)changeAddressFunctionWithAdressStr:(NSString *) addressStr;
//返回时带回选择的皮肤
@property(nonatomic,strong)void (^block)(UIImage  * image);
//判断是否更改背景图
@property(nonatomic,assign)NSInteger isChange;
@end
