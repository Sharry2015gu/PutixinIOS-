//
//  QiFo_MainViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/27.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "QiFo_MainViewController.h"
#import "HeaderFile.h"

#define Start_X 10.0f           // 第一个按钮的X坐标

#define Start_Y 60.0f           // 第一个按钮的Y坐标

#define Width_Space 10.0f        // 2个按钮之间的横间距

#define Height_Space 10.0f      // 竖间距

#define Row_Space   30.0f       //行距

#define Button_Height 20.0f    // 高

#define Button_Width 68.0f      // 宽



@interface QiFo_MainViewController ()<BlessingDelegate,BlessingviewDelegate>

@property(nonatomic,strong)BlessingViewController * bless;

@property(nonatomic,strong) UIButton * seleBt;

@end

@implementation QiFo_MainViewController

@synthesize contributeBtnView;
@synthesize qifuBtnView;
@synthesize wenguaBtnView;
 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, SCREEN_HEIGHT)];
    backgroundview.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景.png"]];
    [self.view addSubview:backgroundview];
    
    UIImageView * bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgImage.userInteractionEnabled=YES;
    bgImage.image=[UIImage imageNamed:@"buddha_hall_bg.jpg"];
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
    [bgImage addGestureRecognizer:singleTap];
    [backgroundview addSubview:bgImage];

    UINavigationBar*bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 375, 70)];
    
    [bar setBackgroundImage:[UIImage imageNamed:@"meditation_top_bg.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:bar];
    
    UIButton*fanhuiBt=[[UIButton alloc]initWithFrame:CGRectMake(6, 33, 25, 25)];
    [fanhuiBt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [fanhuiBt addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:fanhuiBt];
    
    title=[[UILabel alloc]initWithFrame:CGRectMake(150, 33, 120, 25)];
//    title.text=@"恭敬礼佛";
    
//    title.text=self.bless;
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [bar addSubview:title];
    
    foxiangImage=[[UIImageView alloc]initWithFrame:CGRectMake(40, 55, 300, 400)];
    NSLog(@"hahaha%@",foxiangImage);
    foxiangImage.image=[UIImage imageNamed:@"佛"];
    [bgImage addSubview:foxiangImage];
    
    gongpingImage1=[[UIImageView alloc]initWithFrame:CGRectMake(20, 445, 50, 100)];
    gongpingImage1.image=[UIImage imageNamed:@"花瓶"];
    [bgImage addSubview:gongpingImage1];
    
    gongpingImage2=[[UIImageView alloc]initWithFrame:CGRectMake(310, 445, 50, 100)];
    gongpingImage2.image=[UIImage imageNamed:@"花瓶"];
    [bgImage addSubview:gongpingImage2];
    
    huaImage1=[[UIImageView alloc]initWithFrame:CGRectMake(40, 380, 50, 80)];
    huaImage1.image=[UIImage imageNamed:@""];
    [bgImage addSubview:huaImage1];
    
    dengImage1=[[UIImageView alloc]initWithFrame:CGRectMake(75, 468, 45, 80)];
    dengImage1.image=[UIImage imageNamed:@"灯"];
    [bgImage addSubview:dengImage1];
    
    dengImage2=[[UIImageView alloc]initWithFrame:CGRectMake(255, 468, 45, 80)];
    dengImage2.image=[UIImage imageNamed:@"灯"];
    [bgImage addSubview:dengImage2];
    
    xiangluImage=[[UIImageView alloc]initWithFrame:CGRectMake(140, 500, 90, 80)];
    xiangluImage.image=[UIImage imageNamed:@"香炉"];
    [bgImage addSubview:xiangluImage];
    
    xiangImage=[[UIImageView alloc]initWithFrame:CGRectMake(173, 430, 20, 80)];
    xiangImage.image=[UIImage imageNamed:@""];
    [bgImage addSubview:xiangImage];
    
    guobanImage1=[[UIImageView alloc]initWithFrame:CGRectMake(50, 540, 80, 60)];
    guobanImage1.image=[UIImage imageNamed:@"果盘"];
    [bgImage addSubview:guobanImage1];
    
    guobanImage2=[[UIImageView alloc]initWithFrame:CGRectMake(240, 540, 80, 60)];
    guobanImage2.image=[UIImage imageNamed:@"果盘"];
    [bgImage addSubview:guobanImage2];
    
    chaImage1=[[UIImageView alloc]initWithFrame:CGRectMake(140, 569, 30, 30)];
    chaImage1.image=[UIImage imageNamed:@"茶杯"];
    [bgImage addSubview:chaImage1];
    
    chaImage2=[[UIImageView alloc]initWithFrame:CGRectMake(170, 569, 30, 30)];
    chaImage2.image=[UIImage imageNamed:@"茶杯"];
    [bgImage addSubview:chaImage2];
    
    chaImage3=[[UIImageView alloc]initWithFrame:CGRectMake(200, 569, 30, 30)];
    chaImage3.image=[UIImage imageNamed:@"茶杯"];
    [bgImage addSubview:chaImage3];
    
    UIImageView * barImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 620, 375, 48)];
    barImage.image=[UIImage imageNamed:@"导航"];
    [bgImage addSubview:barImage];
    
    CGFloat width = SCREEN_WIDTH / 3;
    array = [[NSArray alloc] initWithObjects:@"进供",@"祈福",@"问卦",nil];
    
    for(int i = 0 ; i < array.count;i++)
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(width*i,630, width,NAVBARHEIGHT-40)];
//        UIImage *image = [self OriginImage:[UIImage imageNamed:imageArray[i]] scaleToSize:CGSizeMake(20,20)];
//        [btn setBackgroundImage:[self OriginImage:[UIImage imageNamed:@"jipin_head_on.jpg"] scaleToSize:btn.frame.size] forState:UIControlStateSelected];
        [btn setTitle:array[i] forState:UIControlStateNormal];
//        [btn setImage:image forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        btn.tag = 200+i;
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    }
}

-(void)backclick{
    
       //通过委托协议传值
//    [self.delegate passValue:userEntity];
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
//    BlessingViewController * bless=[[BlessingViewController alloc]init];
//
//    [self.sideMenuViewController
//     setContentViewController:bless animated:YES];
//    [self.sideMenuViewController hideMenuViewController];
}
-(void)onClickImage{

//    contributeBtnView.backgroundColor=[UIColor clearColor];
}

//传相应的值
- (void) setValue:(NSString *) value{
    title.text = value;
}

-(void)btnClick:(UIButton *)btn{

    btn.selected = YES;
    self.seleBt.selected = NO;
    self.seleBt= btn;
    if (btn.tag == 200) {
        [UIView animateWithDuration:0.3 animations:^{
            
            [self.view addSubview:self.contributeBtnView];
            
        }];
    }
    else
    {
        if (btn.tag == 201) {
            [UIView animateWithDuration:0.3 animations:^{
                [self.view addSubview:self.qifuBtnView];
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self.view addSubview:self.wenguaBtnView];
            }];
        }
    }

}
-(UIView *)contributeBtnView
{
    if (contributeBtnView == nil) {
        
        CGFloat width = SCREEN_WIDTH / 4;
        NSArray *titleArray = @[@"敬香",@"供茶",@"献供",@"献花",];
        contributeBtnView = [[UIView alloc] initWithFrame:CGRectMake(0,NAVBARHEIGHT+515,SCREEN_WIDTH,NAVBARHEIGHT-20)];
        contributeBtnView.backgroundColor = DarkRed;
        for(int i = 0 ; i < titleArray.count;i++)
        {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(width*i,10, width,NAVBARHEIGHT-40)];
            btn.tag = 200+i;
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(contributeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 1) {
                
            
//                [btn setBackgroundImage:[self imageWithColor:DDarkOrange size:btn.frame.size] forState:UIControlStateNormal];
            }
            [contributeBtnView addSubview:btn];
        }
    }
    return  contributeBtnView;
}

-(UIView *)qifuBtnView{
    
    if (qifuBtnView == nil) {

        CGFloat width = SCREEN_WIDTH / 4;
        NSArray *titleArray = @[@"许愿",@"还愿",@"光明灯",@"功德牌",];
        qifuBtnView = [[UIView alloc] initWithFrame:CGRectMake(0,NAVBARHEIGHT+515,SCREEN_WIDTH,NAVBARHEIGHT-20)];
        qifuBtnView.backgroundColor = DarkRed;
        for(int i = 0 ; i < titleArray.count;i++)
        {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(width*i,10, width,NAVBARHEIGHT-40)];
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(qifuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 1) {
                //                [btn setBackgroundImage:[self imageWithColor:DDarkOrange size:btn.frame.size] forState:UIControlStateNormal];
            }
            [qifuBtnView addSubview:btn];
        }
    }

    return qifuBtnView;
}

-(UIView *)wenguaBtnView{
    
    if (wenguaBtnView == nil) {
        
        CGFloat width = SCREEN_WIDTH / 2;
        NSArray *titleArray = @[@"求圣签",@"掷筊",];
        wenguaBtnView = [[UIView alloc] initWithFrame:CGRectMake(0,NAVBARHEIGHT+515,SCREEN_WIDTH,NAVBARHEIGHT-20)];
        wenguaBtnView.backgroundColor = DarkRed;
        for(int i = 0 ; i < titleArray.count;i++)
        {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(width*i,10, width,NAVBARHEIGHT-40)];
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(wenguaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 1) {
                //                [btn setBackgroundImage:[self imageWithColor:DDarkOrange size:btn.frame.size] forState:UIControlStateNormal];
            }
            [wenguaBtnView addSubview:btn];
        }
    }
    
    return wenguaBtnView;
}

-(void)contributeBtnClick:(UIButton *)btn
{
    //数组中多个按钮的事件
    if (_button != btn) {
        btn.selected = YES;
        _button.selected = NO;
        _button = btn;
    }
    self.sumNumber = btn.tag - 200;
    if (btn.tag - 200 == 0) {
        
        fugeiImage=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 380, self.view.frame.size.height)];
        [fugeiImage setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
        [fugeiImage addTarget:self action:@selector(fugei1Click) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:fugeiImage];
        
        backgroundImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 560, 380, 107)];
        backgroundImage.image=[UIImage imageNamed:@"offerings_bg"];
        backgroundImage.userInteractionEnabled=YES;
        [self.view addSubview:backgroundImage];
        
        scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, 380, 100)];
        [scrollview setShowsHorizontalScrollIndicator:NO];
        [scrollview setContentSize:CGSizeMake(840, 0)];
        [scrollview setDelegate:self];
        [scrollview setBackgroundColor:[UIColor clearColor]];
        [backgroundImage addSubview:scrollview];
        
        NSArray *nameArray = @[@"平安香",@"智慧香",@"消灾香",@"增缘香",@"增福香",@"求子香",@"增财香",];
        for (int i = 0 ; i < 7; i++) {
            
            NSInteger index = i % 7;
            
            NSInteger page = i / 7;
            
            // 圆角按钮
            
            UIButton*jianjieBt = [[UIButton alloc]initWithFrame:CGRectMake(index * (Button_Width + Width_Space+40) + Start_X+70, page  * (Button_Height + Height_Space)+Start_Y-20, Button_Width-50, Button_Height-38)];
            
            [jianjieBt setBackgroundImage:[UIImage imageNamed:@"thing_detail"] forState:UIControlStateNormal];
            jianjieBt.tag=i;
            
            [jianjieBt addTarget:self action:@selector(jianjieBtClick) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollview addSubview:jianjieBt];
            
            xiangBt1=[[UIButton alloc]initWithFrame:CGRectMake(index * (Button_Width + Width_Space+40) + Start_X-10, page  * (Button_Height + Height_Space)+Start_Y-50, Button_Width+7, Button_Height+70)];
            [xiangBt1 setBackgroundColor:[UIColor clearColor]];
            xiangBt1.tag=i;
            [scrollview addSubview:xiangBt1];
            
            xiang1=[[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 50, 70)];
            xiang1.image=[UIImage imageNamed:@"joss_stick_stick"];
            [xiangBt1 addSubview:xiang1];
            
            name_sgLa1=[[UILabel alloc]initWithFrame:CGRectMake(20, 68, 100, 20)];
            name_sgLa1.text=nameArray[i];
            name_sgLa1.textColor=[UIColor whiteColor];
            [xiangBt1 addSubview:name_sgLa1];
            
            UIImageView * lian1=[[UIImageView alloc]initWithFrame:CGRectMake(75, 45, 30,20)];
            lian1.image=[UIImage imageNamed:@"price_icon"];
            [xiangBt1 addSubview:lian1];

            money_sgLa1=[[UILabel alloc]initWithFrame:CGRectMake(105, 45, 100, 20)];
            money_sgLa1.text=@"10";
            money_sgLa1.textColor=majorityColor;
            money_sgLa1.font=[UIFont systemFontOfSize:12];
            [xiangBt1 addSubview:money_sgLa1];

        }
        
//        xiangBt1=[[UIButton alloc]initWithFrame:CGRectMake(0, 10, 75, 100)];
//        [xiangBt1 setBackgroundColor:[UIColor clearColor]];
//        [xiangBt1 addTarget:self action:@selector(xiangBt1Click) forControlEvents:UIControlEventTouchUpInside];
//        [scrollview addSubview:xiangBt1];
//        xiang1=[[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 50, 70)];
//        xiang1.image=[UIImage imageNamed:@"joss_stick_stick"];
//        [xiangBt1 addSubview:xiang1];
//        
//        name_sgLa1=[[UILabel alloc]initWithFrame:CGRectMake(20, 68, 100, 20)];
//        name_sgLa1.text=@"平安香";
//        name_sgLa1.textColor=[UIColor whiteColor];
//        [xiangBt1 addSubview:name_sgLa1];
//        UIImageView * lian1=[[UIImageView alloc]initWithFrame:CGRectMake(75, 45, 30,20)];
//        lian1.image=[UIImage imageNamed:@"price_icon"];
//        [xiangBt1 addSubview:lian1];
//        
//        money_sgLa1=[[UILabel alloc]initWithFrame:CGRectMake(105, 45, 100, 20)];
//        money_sgLa1.text=@"10";
//        money_sgLa1.textColor=majorityColor;
//        money_sgLa1.font=[UIFont systemFontOfSize:12];
//        [xiangBt1 addSubview:money_sgLa1];
//        
//        xiangBt2=[[UIButton alloc]initWithFrame:CGRectMake(120, 10, 75, 100)];
//        [xiangBt2 setBackgroundColor:[UIColor clearColor]];
//        [xiangBt2 addTarget:self action:@selector(xiangBt2Click) forControlEvents:UIControlEventTouchUpInside];
//        [scrollview addSubview:xiangBt2];
//        
//        xiang2=[[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 50, 70)];
//        xiang2.image=[UIImage imageNamed:@"joss_stick_stick"];
//        [xiangBt2 addSubview:xiang2];
//        
//        name_sgLa2=[[UILabel alloc]initWithFrame:CGRectMake(20, 68, 100, 20)];
//        name_sgLa2.text=@"智慧香";
//        name_sgLa2.textColor=[UIColor whiteColor];
//        [xiangBt2 addSubview:name_sgLa2];
//        UIImageView * lian2=[[UIImageView alloc]initWithFrame:CGRectMake(75, 45, 30,20)];
//        lian2.image=[UIImage imageNamed:@"price_icon"];
//        [xiangBt2 addSubview:lian2];
//        
//        money_sgLa2=[[UILabel alloc]initWithFrame:CGRectMake(105, 45, 100, 20)];
//        money_sgLa2.text=@"10";
//        money_sgLa2.textColor=majorityColor;
//        money_sgLa2.font=[UIFont systemFontOfSize:12];
//        [xiangBt2 addSubview:money_sgLa2];
//        
//        xiangBt3=[[UIButton alloc]initWithFrame:CGRectMake(240, 10, 75, 100)];
//        [xiangBt3 setBackgroundColor:[UIColor clearColor]];
//        [xiangBt3 addTarget:self action:@selector(xiangBt3Click) forControlEvents:UIControlEventTouchUpInside];
//        [scrollview addSubview:xiangBt3];
//        
//        xiang3=[[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 50, 70)];
//        xiang3.image=[UIImage imageNamed:@"joss_stick_stick"];
//        [xiangBt3 addSubview:xiang3];
//        
//        name_sgLa3=[[UILabel alloc]initWithFrame:CGRectMake(20, 68, 100, 20)];
//        name_sgLa3.text=@"消灾香";
//        name_sgLa3.textColor=[UIColor whiteColor];
//        [xiangBt3 addSubview:name_sgLa3];
//        UIImageView * lian3=[[UIImageView alloc]initWithFrame:CGRectMake(75, 45, 30,20)];
//        lian3.image=[UIImage imageNamed:@"price_icon"];
//        [xiangBt3 addSubview:lian3];
//        
//        money_sgLa3=[[UILabel alloc]initWithFrame:CGRectMake(105, 45, 100, 20)];
//        money_sgLa3.text=@"10";
//        money_sgLa3.textColor=majorityColor;
//        money_sgLa3.font=[UIFont systemFontOfSize:12];
//        [xiangBt3 addSubview:money_sgLa3];
//        
//        xiangBt4=[[UIButton alloc]initWithFrame:CGRectMake(360, 10, 75, 100)];
//        [xiangBt4 setBackgroundColor:[UIColor clearColor]];
//        [xiangBt4 addTarget:self action:@selector(xiangBt4Click) forControlEvents:UIControlEventTouchUpInside];
//        [scrollview addSubview:xiangBt4];
//    
//        xiang4=[[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 50, 70)];
//        xiang4.image=[UIImage imageNamed:@"joss_stick_stick"];
//        [xiangBt4 addSubview:xiang4];
//        
//        name_sgLa4=[[UILabel alloc]initWithFrame:CGRectMake(20, 68, 100, 20)];
//        name_sgLa4.text=@"增缘香";
//        name_sgLa4.textColor=[UIColor whiteColor];
//        [xiangBt4 addSubview:name_sgLa4];
//        
//        UIImageView * lian4=[[UIImageView alloc]initWithFrame:CGRectMake(75, 45, 30,20)];
//        lian4.image=[UIImage imageNamed:@"price_icon"];
//        [xiangBt4 addSubview:lian4];
//        
//        money_sgLa4=[[UILabel alloc]initWithFrame:CGRectMake(105, 45, 100, 20)];
//        money_sgLa4.text=@"10";
//        money_sgLa4.textColor=majorityColor;
//        money_sgLa4.font=[UIFont systemFontOfSize:12];
//        [xiangBt4 addSubview:money_sgLa4];
//        
//        xiangBt5=[[UIButton alloc]initWithFrame:CGRectMake(480, 10, 75, 100)];
//        [xiangBt5 setBackgroundColor:[UIColor clearColor]];
//        [xiangBt5 addTarget:self action:@selector(xiangBt5Click) forControlEvents:UIControlEventTouchUpInside];
//        [scrollview addSubview:xiangBt5];
//        
//        xiang5=[[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 50, 70)];
//        xiang5.image=[UIImage imageNamed:@"joss_stick_stick"];
//        [xiangBt5 addSubview:xiang5];
//        
//        name_sgLa5=[[UILabel alloc]initWithFrame:CGRectMake(20, 68, 100, 20)];
//        name_sgLa5.text=@"增福香";
//        name_sgLa5.textColor=[UIColor whiteColor];
//        [xiangBt5 addSubview:name_sgLa5];
//        UIImageView * lian5=[[UIImageView alloc]initWithFrame:CGRectMake(75, 45, 30,20)];
//        lian5.image=[UIImage imageNamed:@"price_icon"];
//        [xiangBt5 addSubview:lian5];
//        
//        money_sgLa5=[[UILabel alloc]initWithFrame:CGRectMake(105, 45, 100, 20)];
//        money_sgLa5.text=@"10";
//        money_sgLa5.textColor=majorityColor;
//        money_sgLa5.font=[UIFont systemFontOfSize:12];
//        [xiangBt5 addSubview:money_sgLa5];
//        
//        xiangBt6=[[UIButton alloc]initWithFrame:CGRectMake(600, 10, 75, 100)];
//        [xiangBt6 setBackgroundColor:[UIColor clearColor]];
//        [scrollview addSubview:xiangBt6];
//        
//        xiang6=[[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 50, 70)];
//        xiang6.image=[UIImage imageNamed:@"joss_stick_stick"];
//        [xiangBt6 addTarget:self action:@selector(xiangBt6Click) forControlEvents:UIControlEventTouchUpInside];
//        [xiangBt6 addSubview:xiang6];
//        
//        name_sgLa6=[[UILabel alloc]initWithFrame:CGRectMake(20, 68, 100, 20)];
//        name_sgLa6.text=@"求子香";
//        name_sgLa6.textColor=[UIColor whiteColor];
//        [xiangBt6 addSubview:name_sgLa6];
//        UIImageView * lian6=[[UIImageView alloc]initWithFrame:CGRectMake(75, 45, 30,20)];
//        lian6.image=[UIImage imageNamed:@"price_icon"];
//        [xiangBt6 addSubview:lian6];
//        
//        money_sgLa6=[[UILabel alloc]initWithFrame:CGRectMake(105, 45, 100, 20)];
//        money_sgLa6.text=@"10";
//        money_sgLa6.textColor=majorityColor;
//        money_sgLa6.font=[UIFont systemFontOfSize:12];
//        [xiangBt6 addSubview:money_sgLa6];
//        
//        xiangBt7=[[UIButton alloc]initWithFrame:CGRectMake(720, 10, 75, 100)];
//        [xiangBt7 setBackgroundColor:[UIColor clearColor]];
//        [scrollview addSubview:xiangBt7];
//        
//        xiang7=[[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 50, 70)];
//        xiang7.image=[UIImage imageNamed:@"joss_stick_stick"];
//        [xiangBt7 addTarget:self action:@selector(xiangBt7Click) forControlEvents:UIControlEventTouchUpInside];
//        [xiangBt7 addSubview:xiang7];
//        
//        name_sgLa7=[[UILabel alloc]initWithFrame:CGRectMake(20, 68, 100, 20)];
//        name_sgLa7.text=@"增财香";
//        name_sgLa7.textColor=[UIColor whiteColor];
//        [xiangBt7 addSubview:name_sgLa7];
//        UIImageView * lian7=[[UIImageView alloc]initWithFrame:CGRectMake(75, 45, 30,20)];
//        lian7.image=[UIImage imageNamed:@"price_icon"];
//        [xiangBt7 addSubview:lian7];
//        
//        money_sgLa7=[[UILabel alloc]initWithFrame:CGRectMake(105, 45, 100, 20)];
//        money_sgLa7.text=@"10";
//        money_sgLa7.textColor=majorityColor;
//        money_sgLa7.font=[UIFont systemFontOfSize:12];
//        [xiangBt7 addSubview:money_sgLa7];
        
    }
    if (btn.tag - 200 == 1) {
//        if ([self.view.subviews indexOfObject:self.tributeView2] == NSNotFound) {
//            [self.tributeView1 removeFromSuperview];
//            [self.tributeView3 removeFromSuperview];
//            [self.tributeView4 removeFromSuperview];
//            [self.view addSubview:self.tributeView2];
//        }
    }
    if (btn.tag - 200 == 2) {
//        if ([self.view.subviews indexOfObject:self.tributeView3] == NSNotFound) {
//            [self.tributeView1 removeFromSuperview];
//            [self.tributeView2 removeFromSuperview];
//            [self.tributeView4 removeFromSuperview];
//            [self.view addSubview:self.tributeView3];
//        }
    }
    if (btn.tag - 200 == 3) {
//        if ([self.view.subviews indexOfObject:self.tributeView4] == NSNotFound) {
//            [self.tributeView1 removeFromSuperview];
//            [self.tributeView2 removeFromSuperview];
//            [self.tributeView3 removeFromSuperview];
//            [self.view addSubview:self.tributeView4];
//        }
    }
}

-(void)fugei1Click{
    
//    [self resignFirstResponder];
    
    fugeiImage.hidden=YES;
    backgroundImage.hidden=YES;
//    contributeBtnView.hidden=YES;
    scrollview.hidden=NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
