//
//  AppDelegate.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/5/5.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "AppDelegate.h"
#import "UserLoginViewController.h"
#import "HeaderFile.h"
@interface AppDelegate ()
{
    //表示早课时间开了没
    NSInteger  earlyHomeWorkInteger ;
    //表示晚课时间开了没
    NSInteger  lateHomeWorkInteger  ;
}
@end

@implementation AppDelegate
-(NSTimer *)timer
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showHomeWorkHintView) userInfo:nil repeats:YES];
    }
    return _timer;
}
-(void)showHomeWorkHintView
{
    NSString  * huaienId = [self.accountBasicDict  objectForKey:@"huaienId"];
    NSString  * hintKey1 = [NSString stringWithFormat:@"%@%@",earlyHomeWorkHint,huaienId];
    NSNumber  * earlyNumber = [[NSUserDefaults standardUserDefaults] objectForKey:hintKey1];
    NSString  * hintKey2  = [NSString stringWithFormat:@"%@%@",lateHomeWorkHint,huaienId];
    NSNumber  * lateNumber = [[NSUserDefaults standardUserDefaults] objectForKey:hintKey2];
    earlyHomeWorkInteger = [earlyNumber integerValue];
    lateHomeWorkInteger =  [lateNumber integerValue];
    //有早课提醒
    if (earlyHomeWorkInteger)
    {
        //早课提醒时间
        NSString  * earlyTimeStr = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",earlyHomeWorkTime,huaienId]];
        NSDate  * date = [NSDate date];
        //本地时间
        NSDateFormatter  * formatter  = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"HH:mm:ss";
        NSString * currentLocalDateString = [formatter stringFromDate:date];
        NSLog(@"早课时间%@-----%@",earlyTimeStr,currentLocalDateString);
        if ([earlyTimeStr isEqualToString:currentLocalDateString]) {
            UIAlertView  *  alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"早功课时间到了" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    if (lateHomeWorkInteger)
    {
        NSString  * earlyTimeStr = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",lateHomeWorkTime,huaienId]];
        NSDate  * date = [NSDate date];
        //本地时间
        NSDateFormatter  * formatter  = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"HH:mm:ss";
        NSString * currentLocalDateString = [formatter stringFromDate:date];
        NSLog(@"晚课时间%@-----%@",earlyTimeStr,currentLocalDateString);
        if ([earlyTimeStr isEqualToString:currentLocalDateString]) {
            UIAlertView  *  alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"晚功课时间到了" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
    }
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
     [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    AFHTTPSessionManager * sessionManager = [AFHTTPSessionManager manager];
    self.sessionManager = sessionManager;
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    self.window.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景.png"]];
    nav=[[UINavigationController alloc]init];
    
    UserLoginViewController *viewcon = [[UserLoginViewController alloc] init];
    [self showHomeWorkHintView];
    [nav pushViewController:viewcon animated:NO];
    self.window.rootViewController=viewcon;
    [self.window addSubview:nav.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ( [navigationController isNavigationBarHidden] ) {
        [navigationController setNavigationBarHidden:NO animated:animated];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//#pragma mark ---- 设置早晚功课的通知
//-(void)setNotificationAboutEarlyOrLateHomework
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeHomeWorkHint:) name:everyDayHomeWorkHint  object:nil];
//}
#pragma mark ---- 改变 提醒功课
-(void)changeHomeWorkHint
{
    NSString  * huaienId = [self.accountBasicDict  objectForKey:@"huaienId"];
    NSString  * hintKey1 = [NSString stringWithFormat:@"%@%@",earlyHomeWorkHint,huaienId];
    NSNumber  * earlyNumber = [[NSUserDefaults standardUserDefaults] objectForKey:hintKey1];
    NSString  * hintKey2  = [NSString stringWithFormat:@"%@%@",lateHomeWorkHint,huaienId];
    NSNumber  * lateNumber = [[NSUserDefaults standardUserDefaults] objectForKey:hintKey2];
    NSLog(@"appDelegate%ld----%ld",earlyNumber,lateNumber);
    earlyHomeWorkInteger = [earlyNumber integerValue] ;
    lateHomeWorkInteger = [lateNumber integerValue];
    //关闭
    if (!earlyHomeWorkInteger && !lateHomeWorkInteger) {
        [self.timer setFireDate:[NSDate distantFuture]];
    }
    //打开
    if (earlyHomeWorkInteger || lateHomeWorkInteger) {
        [self.timer setFireDate:[NSDate distantPast]];
    }
}
@end
