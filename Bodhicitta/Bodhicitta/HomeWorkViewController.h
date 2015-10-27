//
//  HomeWorkViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/8.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBuddhaHallViewController.h"
#import "ShuJia_MyViewController.h"
#import "MusicViewController.h"
#import "PracticeViewController.h"
#import "FoZhuViewController.h"
#import "JingXinViewController.h"
@interface HomeWorkViewController : UIViewController
@property(nonatomic,strong)MyBuddhaHallViewController * myBuddahaVC;
@property(nonatomic,strong)ShuJia_MyViewController   * myShuajiaVC;
@property(nonatomic,strong)MusicViewController      *  myMusicPlayerVc;
@property(nonatomic,strong)JingXinViewController   *  myJingXinVC;
@property(nonatomic,strong)FoZhuViewController   *   fozhuVc;
-(void)getHomeWorkInfo;
-(void)getCompletionInfo;
@end
