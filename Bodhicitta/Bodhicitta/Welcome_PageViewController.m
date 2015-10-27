//
//  Welcome_PageViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/9/18.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "Welcome_PageViewController.h"
#import "HeaderFile.h"
#import "EAIntroView.h"
@interface Welcome_PageViewController ()<EAIntroDelegate>
@end

@implementation Welcome_PageViewController

- (void)viewDidLoad {
    
    self.view.backgroundColor=[UIColor whiteColor];
}
- (void)viewDidAppear:(BOOL)animated {
    
    [self showIntroWithCrossDissolve];
    
}

- (void)showIntroWithCrossDissolve {
    
    EAIntroPage *page1 = [EAIntroPage page];
    page1.bgImage = [UIImage imageNamed:@"guide1.jpg"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.bgImage = [UIImage imageNamed:@"guide2.jpg"];
    
    EAIntroPage *page3 = [EAIntroPage page];
       page3.bgImage = [UIImage imageNamed:@"guide3.jpg"];
    
    EAIntroPage * page4 = [EAIntroPage page];
    page4.bgImage = [UIImage imageNamed:@"guide4.jpg"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4]];
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
}

- (void)showBasicIntroWithBg {
    
    EAIntroPage *page1 = [EAIntroPage page];
    page1.bgImage = [UIImage imageNamed:@"guide1.jpg"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.bgImage = [UIImage imageNamed:@"guide2.jpg"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.bgImage = [UIImage imageNamed:@"guide3.jpg"];
    
    EAIntroPage * page4 = [EAIntroPage page];
    page4.bgImage = [UIImage imageNamed:@"guide4.jpg"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4]];
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
}

- (void)showBasicIntroWithFixedTitleView {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.bgImage = [UIImage imageNamed:@"guide1.jpg"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.bgImage = [UIImage imageNamed:@"guide2.jpg"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.bgImage = [UIImage imageNamed:@"guide3.jpg"];
    
    EAIntroPage * page4 = [EAIntroPage page];
    page4.bgImage = [UIImage imageNamed:@"guide4.jpg"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4]];
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
}

- (void)showCustomIntro {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.titleImage = [UIImage imageNamed:@"guide1.jpg"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.titlePositionY = 180;
    page2.descPositionY = 160;
    page2.titleImage = [UIImage imageNamed:@"guide2.jpg"];
    page2.imgPositionY = 70;
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.titlePositionY = 220;
    page3.descPositionY = 200;
    page3.titleImage = [UIImage imageNamed:@"guide3.jpg"];
    page3.imgPositionY = 100;
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3]];
    intro.backgroundColor = [UIColor colorWithRed:1.0f green:0.58f blue:0.21f alpha:1.0f]; //iOS7 orange
    
    intro.pageControlY = 100.0f;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setBackgroundImage:[UIImage imageNamed:@"skipButton"] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake((320-230)/2, [UIScreen mainScreen].bounds.size.height - 60, 230, 40)];
    [btn setTitle:@"SKIP NOW" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    intro.skipButton = btn;
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
}

- (void)showIntroWithCustomView {
    EAIntroPage *page1 = [EAIntroPage page];
    
    page1.bgImage = [UIImage imageNamed:@"guide1.jpg"];
    
    UIView *viewForPage2 = [[UIView alloc] initWithFrame:self.view.bounds];
    UILabel *labelForPage2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 220, 300, 30)];
    labelForPage2.text = @"Some custom view";
    labelForPage2.font = [UIFont systemFontOfSize:32];
    labelForPage2.textColor = [UIColor whiteColor];
    labelForPage2.backgroundColor = [UIColor clearColor];
    labelForPage2.transform = CGAffineTransformMakeRotation(M_PI_2*3);
    [viewForPage2 addSubview:labelForPage2];
    EAIntroPage *page2 = [EAIntroPage pageWithCustomView:viewForPage2];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.bgImage = [UIImage imageNamed:@"guide3.jpg"];
    page3.titleImage = [UIImage imageNamed:@"femalecodertocat"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3]];
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
}

- (void)showIntroWithSeparatePagesInit {
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds];
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
    
    EAIntroPage *page1 = [EAIntroPage page];
    page1.bgImage = [UIImage imageNamed:@"guide1.jpg"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.bgImage = [UIImage imageNamed:@"guide2.jpg"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.bgImage = [UIImage imageNamed:@"guide3.jpg"];
    EAIntroPage *page4 = [EAIntroPage page];
    page3.bgImage = [UIImage imageNamed:@"guide4.jpg"];
    [intro setPages:@[page1,page2,page3,page4]];
}

- (void)introDidFinish {    
    UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    iv.image=[UIImage imageNamed:@"guide5.jpg"];
    [self.view addSubview:iv];
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.35, SCREEN_HEIGHT*0.9, 90, 30)];
    [button setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)buttonClick{

    [self.navigationController popViewControllerAnimated:YES];
}

@end
