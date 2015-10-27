//
//  FaBiao_SYViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/8.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhuYeMianViewController.h"
#import "RESideMenu.h"
#import "ShanYou_DTViewController.h"

@interface FaBiao_SYViewController : UIViewController<UITextViewDelegate>{

    UIButton * fanhuiBt;
    UIButton * fabiaoButton;
    UITextView * textview;
    UIButton * bgButton;
    UIButton * dayBt;
    UIImageView * dayImage;
    UILabel * dayla;
    
    BOOL isClick;
}

@end
