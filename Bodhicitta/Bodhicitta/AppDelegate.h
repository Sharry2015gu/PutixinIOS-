//
//  AppDelegate.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/5/5.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
#import <CoreData/CoreData.h>
#import "Personal.h"
#import "HeaderFile.h"
#import "TempleImage.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarDelegate>{
    
    UINavigationController * nav;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) id mainVc;
@property (strong,nonatomic) Personal *user;
@property (strong,nonatomic) TempleImage * templeimage;
@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic,strong) NSMutableDictionary  *accountBasicDict;
@property (nonatomic,strong) NSTimer  * timer;
-(void)changeHomeWorkHint;
@end

