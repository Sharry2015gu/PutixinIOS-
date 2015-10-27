//
//  MiaoYinViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/25.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "MusicViewController.h"
#import "LocalMusicViewController.h"
#import "MiaoYinViewController.h"
#import "MusicOnlineViewController.h"
//按钮空隙
#define BUTTONGAP 5
//按钮长度
#define BUTTONWIDTH 115
//按钮宽度
#define BUTTONHEIGHT 30
//滑条CONTENTSIZEX
#define CONTENTSIZEX 280

#define BUTTONID (sender.tag-100)


#define EACH_W(A) ([UIScreen mainScreen].bounds.size.width/A)
#define EACH_H (self.tabBar.bounds.size.height)
#define BTNTAG 10000

#define DEVICE_3_5_INCH ([[UIScreen mainScreen] bounds].size.height == 480)
#define DEVICE_4_0_INCH ([[UIScreen mainScreen] bounds].size.height == 568)

@interface MiaoYinViewController ()
{
    MusicViewController  * musicPlayVc;
    MusicOnlineViewController  *  VC1;
    LocalMusicViewController  *  VC2;
    MusicViewController  *  VC3;
}
@end

@implementation MiaoYinViewController

@synthesize titleArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    [self initControllers];
    [self creatTabbar:self.viewControllers.count];
    [self initControllers];
}
-(void)showTabBar
{
    _tabbar.hidden = NO;
}
-(void)hideTabBar
{
    _tabbar.hidden = YES;
}

#pragma mark - 如果想添加控制器到tabbar里面在这里面实例化就行
- (void)initControllers
{
    MusicOnlineViewController  *view1  = [[MusicOnlineViewController alloc]init];
    VC1 = view1;
    [view1 getBookShelfInfoWithCategory:6 isRefresh:YES];
    [view1 getBookShelfInfoWithCategory:7 isRefresh:YES];
    
    //    [view1 getBookShelfInfoWithCategory:[[NSNumber numberWithInteger:6]integerValue ] isRefresh:YES];
    //    [view1 getBookShelfInfoWithCategory:[[NSNumber numberWithInteger:7] integerValue] isRefresh:YES];
    [self addViewControllers:view1 title:nil];
    
    LocalMusicViewController   *view2 = [[LocalMusicViewController alloc]init];
    VC2 = view2;
    [self addViewControllers:view2 title:nil];
    
    MusicViewController *view3 = [[MusicViewController alloc]init];
    musicPlayVc = view3;
    VC3 = view3;
    [self addViewControllers:view3 title:nil];
    
    // [self.navigationController pushViewController:view3 animated:YES];
    //  照着上面添加控制球就行了
}

#pragma  mark - 添加子控制器
- (void)addViewControllers:(UIViewController *)childController title:(NSString *)title
{
    //    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childController];
    childController.navigationItem.title = title;
    [self addChildViewController:childController];
}

- (void)creatTabbar:(NSInteger)ControllersNum
{
    // 只需要该图片名字就行
    NSArray * normImage = @[@"在线佛音@2x",@"本地佛音@2x",@"正在播放@2x"];
    //  只需修改选中图片的名字
    NSArray * selectImage = @[@"在线佛音选中@2x",@"本地佛音选中@2x",@"正在播放选中@2x"];
    _tabbar = [[UIView alloc]initWithFrame:self.tabBar.frame];
    _tabbar.backgroundColor =  [UIColor whiteColor];
    _tabbar.userInteractionEnabled = YES;
    for(int i = 0;i<self.viewControllers.count;i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(EACH_W(self.viewControllers.count)*i, 0, EACH_W(self.viewControllers.count), EACH_H);
        [btn setImage:[UIImage imageNamed:normImage[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:selectImage[i]] forState:UIControlStateSelected];
        btn.tag = BTNTAG+i;
        [_tabbar addSubview:btn];
        if(btn.tag==BTNTAG)
        {
            [self btnSelect:btn];
        }
        [btn addTarget:self action:@selector(btnSelect:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    [self.view addSubview:_tabbar];
    
}
- (void)btnSelect:(UIButton *)sender
{
    _button.selected =NO ;
    sender.selected = YES;
    _button = sender;
    if(self.selectedIndex != 2)
    {
        musicPlayVc.selectBtn = sender;
    }
    self.selectedIndex = sender.tag-BTNTAG;
    if(self.selectedIndex == 2)
    {
        [self hideTabBar];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.audioPlayer  stop];
}
@end
