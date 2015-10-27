//
//  MusicViewController.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/9/6.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WisdomModel.h"
#import "HeaderFile.h"
#import <AVFoundation/AVFoundation.h>
@interface MusicViewController : UIViewController
{
    AVAudioPlayer  *audioPlayer;
}
@property(nonatomic,strong) WisdomModel  *model;
@property(nonatomic,strong) UIButton *selectBtn;
@end
