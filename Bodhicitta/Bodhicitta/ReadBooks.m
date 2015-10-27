//
//  ReadBooks.m
//  BookShelf
//
//  Created by mac on 12-9-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ReadBooks.h"

@implementation ReadBooks

@synthesize str;

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //    [UIView beginAnimations:nil context:nil];
    UIView * bgview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, self.view.frame.size.height)];
    bgview.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景.png"]];
    [self.view addSubview:bgview];
    
    bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 380, self.view.frame.size.height)];
    bgImage.image=[UIImage imageNamed:@"puti_beads_bg.jpg"];
    [bgview addSubview:bgImage];
    
    bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 375, 70)];
    [bar setBackgroundImage:[UIImage imageNamed:@"meditation_top_bg.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:bar];
    
    fanhuiBt=[[UIButton alloc]initWithFrame:CGRectMake(6, 33, 25, 25)];
    [fanhuiBt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [fanhuiBt addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:fanhuiBt];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(130, 33, 190, 25)];
    title.text=@"易筋经第一章";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [bar addSubview:title];
    
    fenxiangBt=[[UIButton alloc]initWithFrame:CGRectMake(340, 33, 25, 25)];
    [fenxiangBt setBackgroundImage:[UIImage imageNamed:@"share_white_icon"] forState:UIControlStateNormal];
    //    fenxiangBt.titleLabel.text=[NSString stringWithFormat:@"%d/%d",currentPage,allPage];
    //        [fenxiangBt addTarget:self action:@selector(changjianClick) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:fenxiangBt];
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"read_book_main_bg.jpg"]];
    imageView.frame = CGRectMake(0, 70, 380,644 - 44);
    
    [self.view addSubview:imageView];
    
    
    
    //自定义工具栏
    UIToolbar * toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 613, 380, 55)];
    toolBar.tintColor = [UIColor grayColor];
    toolBar.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"read_book_bottom_bg"]];
    [self.view addSubview:toolBar];
    
    time_bcLa=[[UILabel alloc]initWithFrame:CGRectMake(10, 7, 90, 20)];
    time_bcLa.text=@"本次阅读:";
    time_bcLa.font=[UIFont systemFontOfSize:14];
    [toolBar addSubview:time_bcLa];
    time_bcText=[[UILabel alloc]initWithFrame:CGRectMake(75, 7, 90, 20)];
    time_bcText.text=@"22分钟";
    time_bcText.font=[UIFont systemFontOfSize:14];
    [toolBar addSubview:time_bcText];
    
    time_ljLa=[[UILabel alloc]initWithFrame:CGRectMake(10, 28, 90, 20)];
    time_ljLa.text=@"累积阅读:";
    time_ljLa.font=[UIFont systemFontOfSize:14];
    [toolBar addSubview:time_ljLa];
    time_ljText=[[UILabel alloc]initWithFrame:CGRectMake(75, 28, 190, 20)];
    time_ljText.text=@"356小时23分钟";
    time_ljText.font=[UIFont systemFontOfSize:14];
    [toolBar addSubview:time_ljText];
    
    time_jrLa=[[UILabel alloc]initWithFrame:CGRectMake(200, 7, 90, 20)];
    time_jrLa.text=@"今日阅读:";
    time_jrLa.font=[UIFont systemFontOfSize:14];
    [toolBar addSubview:time_jrLa];
    time_jrText=[[UILabel alloc]initWithFrame:CGRectMake(285, 7, 90, 20)];
    time_jrText.text=@"3小时23分钟";
    time_jrText.font=[UIFont systemFontOfSize:14];
    [toolBar addSubview:time_jrText];
    
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 5, 380, 480)];
    [imageView addSubview:textView];
    textView.text = self.str;
    
    textView.font = [UIFont italicSystemFontOfSize:20];
    textView.inputAccessoryView = imageView;
    
    textView.textColor = [UIColor blackColor];
    
    textView.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"read_book_main_bg.jpg"]];
    
    textView.editable = NO;
    //    [textView release];
    
    NSLog(@"%f",textView.contentSize.height);
    
    //计算textView的总页数
    allPage = textView.contentSize.height / 430 + 100;
    //设置当前页为1
    currentPage = 1;
    //为工具栏设置按钮
    
    UIBarButtonItem * button01 = [[UIBarButtonItem alloc] initWithTitle:@"我的书架" style:UIBarButtonItemStylePlain target:self action:@selector(onClick)];
    UIBarButtonItem * button02 = [[UIBarButtonItem alloc] initWithTitle:@"上一页" style:UIBarButtonItemStylePlain target:self action:@selector(upPage)];
    button02.tag = 200;
    UIButton * button03 = [[UIButton alloc] initWithFrame:CGRectMake(100, 480, 90, 20)];
    [button03 setTitle:@"下一页" forState:UIControlStateNormal];
    button03.tag = 300;
    [button03 addTarget:self action:@selector(downPage) forControlEvents:UIControlEventTouchUpInside];
    [textView addSubview:button03];
    button4 = [[UIButton alloc] initWithFrame:CGRectMake(120, 570, 120, 20)];
    button4.tag = 100;
    [button4 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button4 setTitle:[NSString stringWithFormat:@"%d/%d",currentPage,allPage] forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(hello) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];    //将工具栏按钮添加到一个数组里面
    //    NSArray * array = [[NSArray alloc] initWithObjects:button01,button02,button03,button04, nil];
    //    //给工具栏添加按钮
    //    [toolBar setItems:array animated:YES];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    [textView addGestureRecognizer:pan];
    
    //    [pan release];
}
-(void)backclick{
    
    [self.sideMenuViewController
     setContentViewController:[[ShuJia_MyViewController alloc] init]animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    CGPoint  point = [pan translationInView:textView];
    if (point.x < -5 && point.x > -10) {
        [pan setTranslation:CGPointMake(0, 0) inView:textView];
        [self upPage];
        return;
    }else if (point.x > 5 && point.x < 10) {
        [self downPage];
        [pan setTranslation:CGPointMake(0, 0) inView:textView];
        return;
    }
    [pan setTranslation:CGPointMake(0, 0) inView:textView];
    NSLog(@"%f",point.x);
    return;
}


//点击上一页时响应的事件
-(void)upPage{
    if (currentPage == 0) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"这已是第一页" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        return;
    }
    currentPage = currentPage - 1;
    NSLog(@"%d",currentPage);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [textView setContentOffset:CGPointMake(0, (currentPage - 1) * 430) animated:YES];
    [UIView commitAnimations];
    //
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
    
    
    [UIView commitAnimations];
    
    [button4 setTitle:[NSString stringWithFormat:@"%d/%d",currentPage,allPage] forState:UIControlStateNormal];
    return;
}
//点击下一页时响应的事件
-(void)downPage{
    if (currentPage == allPage) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"这已是最后一页" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        //        [alertView release];
        return;
    }
    currentPage = currentPage + 1;
    
    NSLog(@"%d",currentPage);
    [button4 setTitle:[NSString stringWithFormat:@"%d/%d",currentPage,allPage] forState:UIControlStateNormal];
    
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [textView setContentOffset:CGPointMake(0, (currentPage - 1) * 430) animated:YES];
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
    [UIView commitAnimations];
    
    return;
}

-(void)hello{
    return;
}


////此视图将要出现时隐藏导航栏和最上面的横条
//-(void)viewWillAppear:(BOOL)animated{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.35];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
//    //隐藏导航栏上面的横条
//
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
//
//    //隐藏导航栏
//    //self.navigationController.navigationBar.hidden = YES;
//    [UIView commitAnimations];
//    self.view.backgroundColor = [UIColor grayColor];
//}

//点击我的书架时回到主页
- (void)onClick{
    [self dismissViewControllerAnimated:YES completion:nil];
    return;
}

@end
