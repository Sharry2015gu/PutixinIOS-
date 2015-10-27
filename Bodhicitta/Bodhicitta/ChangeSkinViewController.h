//
//  ChangeSkinViewController.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/9/15.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeSkinViewController : UIViewController
//判断是否更改背景图
@property(nonatomic,assign)NSInteger isChange;
//返回时带回选择的皮肤
@property(nonatomic,strong)void (^block)(UIImage  * image);


@end
