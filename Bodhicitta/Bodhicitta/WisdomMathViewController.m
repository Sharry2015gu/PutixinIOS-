//
//  WisdomMathViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/2.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "WisdomMathViewController.h"
#import "ZaiXian_JSViewController.h"
#import "ShuJia_MyViewController.h"
#import "HeaderFile.h"
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


@interface WisdomMathViewController ()
@property(nonatomic,strong)ShuJia_MyViewController * shujiaVC;
@end

@implementation WisdomMathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    NSLog(@"WisdomMathViewController%@",self);
    [self initControllers];
    [self creatTabbar:self.viewControllers.count];
    [self initControllers];
}

#pragma mark - 如果想添加控制器到tabbar里面在这里面实例化就行
- (void)initControllers
{
    ZaiXian_JSViewController *view1 = [[ZaiXian_JSViewController alloc]init];
    //[view1 getClassicInterface];
    [self addViewControllers:view1 title:nil];
    
    ShuJia_MyViewController *view2 = [[ShuJia_MyViewController alloc]init];
    //[view2 getBookShelfInfo];
    //view2.btn = self.btn2;
    self.shujiaVC = view2;
    [self addViewControllers:view2 title:nil];
    
    //  照着上面添加控制球就行了
}

#pragma  mark - 添加子控制器
- (void)addViewControllers:(UIViewController *)childController title:(NSString *)title
{
    childController.navigationItem.title = title;
    if ([childController isMemberOfClass:[ShuJia_MyViewController class]])
    {
        
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:childController];
        [self addChildViewController:nvc];
        
    }
    else
    {
         [self addChildViewController:childController];
    }
}
-(void)showTabBar
{
    _tabbar.hidden = NO;
}
-(void)hideTabBar
{
    _tabbar.hidden = YES;
}

- (void)creatTabbar:(NSInteger)ControllersNum
{
    
    //  只需要该图片名字就行
    NSArray * normImage = @[@"在线经书@2x",@"我的书架@2x"];
    //  只需修改选中图片的名字
    NSArray * selectImage = @[@"在线经书选中@2x",@"我的书架选中@2x"];
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
            self.btn1 = btn;
             self.shujiaVC.btn = self.btn1;
        }
        else
        {
            self.btn2 = btn;
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
    self.selectedIndex = sender.tag-BTNTAG;
    if(self.selectedIndex == 1)
    {
        [self hideTabBar];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
