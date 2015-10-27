//
//  FoZhuViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/24.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "ZhuYeMianViewController.h"

@interface FoZhuViewController : UIViewController{
    
    UIButton * fanhuiBt;
    UINavigationBar * bar;
    UIImageView * bgImage;
    UIButton * shareBt;
    UIButton * leftMenuBt;
    UIButton * rightMenuBt;
    
    UIButton * leftBt,*rightBt;
    UIButton * leftSoundBt,* rightSoundBt;
    UIButton * leftSkinColourBt,* rightSkinColourBt;
    UIButton * leftMusicBt,*rightMusicBt;
    UIButton * fozhuzdBt,* yfozhuzdBt;
    UIButton * leftRankBt,* rightRankBt;
    
    UILabel * thisLabel;
    UILabel * todayLabel;
    UILabel * cumulativeLabel;
    BOOL isClick;
}


@end
