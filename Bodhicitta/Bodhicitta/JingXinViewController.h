//
//  JingXinViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/22.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ZhuYeMianViewController.h"
#import "RESideMenu.h"
#import "MZTimerLabel.h"
#import "ZuoChanViewController.h"
#import "ZhunBeiViewController.h"
#import "PeiHangViewController.h"
#import "SimpleAudioEngine.h"

@interface JingXinViewController : UIViewController<UIAlertViewDelegate,UIActionSheetDelegate>{

    UIButton * changjianBt;
    UIImageView * bgImage;
    UIButton * jishiBt;
    UIButton * yuanyinBt;
    UIButton * zhunbeiBt;
    BOOL isClick;
    
    UINavigationBar * bar;
    UIButton * fanhuiBt;
    UIButton * yicangBt;
    
    MZTimerLabel *timer;
    
    UIButton * musicBt;
    
    AVAudioPlayer * myBackMusic;
    UIView * view;
    
}

@end
