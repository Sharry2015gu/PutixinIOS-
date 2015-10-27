//
//  LeftViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/8.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "LeftViewController.h"
#import "ZhuYeMianViewController.h"
#import "HeaderFile.h"
#import "NewsViewController.h"
#import "UserInfoEditingViewController.h"
#import "PayViewController.h"
@interface LeftViewController (){

    UIImageView * bgImage;
}
@property (strong, readwrite, nonatomic) UITableView *tableView;
@property(nonatomic,strong)UILabel * paryMoneyLabel;
@property(nonatomic,strong)UILabel * paryLabel;
@property(nonatomic,strong)NSMutableDictionary *userInfoDictionary;
@property(nonatomic,strong)UILabel * amountLabel;
@end

@implementation LeftViewController

#pragma mark ------自定义----
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //用于判断设备
    CGFloat width;
    CGFloat height;
    CGFloat font;
    if (fabs(SCREEN_HEIGHT-667) < 1)
    {
        width = 205;
        height =  280;
        font = 16;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            width = 150;
            height = 210;
            font = 14;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            width = 190;
            height = 320;
            font = 18;
        }
        else
        {
             width = 175;
            height = 215;
            font = 13;
        }
    }

    bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height+10)];
    bgImage.image=[UIImage imageNamed:@"背景.jpg"];
    [self.view addSubview:bgImage];
    
    touxiang=[[UIImageView alloc]initWithFrame:CGRectMake(bgImage.center.x - 0.3 * bgImage.frame.size.height,0.2 * bgImage.frame.size.height,0.3 * bgImage.frame.size.height,0.3 * bgImage.frame.size.height)];
    touxiang.image=[UIImage imageNamed:@"默认头像"];
    touxiang.contentMode = UIViewContentModeScaleAspectFill;
    CALayer  *layerHeadImageViewLayer = touxiang.layer;
    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
    layerHeadImageViewLayer.borderWidth = 1.5;
    layerHeadImageViewLayer.masksToBounds = YES;
    layerHeadImageViewLayer.cornerRadius = touxiang.frame.size.height * 0.5;
    touxiang.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTapped)];
    [touxiang addGestureRecognizer:singleTap];//点击图片事件
    [self.view addSubview:touxiang];
    
    title=[[UILabel alloc]initWithFrame:CGRectMake(touxiang.frame.origin.x+width*0.1, touxiang.frame.origin.y+touxiang.frame.size.height, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.05)];
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:font];
    [bgImage addSubview:title];
    
    UILabel * huanenId=[[UILabel alloc]initWithFrame:CGRectMake(width*0.1, touxiang.frame.origin.y+touxiang.frame.size.height+height*0.15, 100, 20)];
    huanenId.text=@"怀恩ID :";
    huanenId.textColor=[UIColor whiteColor];
    huanenId.font=[UIFont systemFontOfSize:font];
    [bgImage addSubview:huanenId];
    
    huaienIDtext=[[UITextField alloc]initWithFrame:CGRectMake(huanenId.frame.origin.x+55, huanenId.frame.origin.y, 110, 20)];
    huaienIDtext.textColor=[UIColor whiteColor];
    huaienIDtext.font=[UIFont systemFontOfSize:font];
    [bgImage addSubview:huaienIDtext];
    
    lvt=[[UIButton alloc]initWithFrame:CGRectMake(huaienIDtext.frame.origin.x+huaienIDtext.frame.size.width-45, huanenId.frame.origin.y+5, 25, 10)];
    [lvt setBackgroundImage:[UIImage imageNamed:@"LV背景"] forState:UIControlStateNormal];
    [lvt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    lvt.titleLabel.font=[UIFont boldSystemFontOfSize:8];
    [bgImage addSubview:lvt];
    
    proLabel=[[UILabel alloc]initWithFrame:CGRectMake(lvt.frame.origin.x+lvt.frame.size.width+3, huanenId.frame.origin.y+7, 70, 6)];
    proLabel.backgroundColor=[UIColor whiteColor];
    [bgImage addSubview:proLabel];
    
    colorPro=[[UILabel alloc]initWithFrame:CGRectMake(lvt.frame.origin.x+lvt.frame.size.width+3, huanenId.frame.origin.y+7, 70, 6)];
//    colorPro.text=@"hehehe";
    colorPro.textColor=[UIColor redColor];
    [bgImage addSubview:colorPro];
    
    _paryMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(huanenId.frame.origin.x, huanenId.frame.origin.y+30, 100, 20)];
    _paryMoneyLabel.text=@"祈福币 :";
    _paryMoneyLabel.textColor=[UIColor whiteColor];
    _paryMoneyLabel.font=[UIFont systemFontOfSize:font];
    [bgImage addSubview:_paryMoneyLabel];
    
    _paryLabel = [[UILabel alloc]initWithFrame:CGRectMake(_paryMoneyLabel.frame.origin.x+_paryMoneyLabel.frame.size.width-40, huanenId.frame.origin.y+30 , SCREEN_WIDTH*0.3, 20)];
    _paryLabel.textColor=[UIColor whiteColor];
    _paryLabel.font=[UIFont systemFontOfSize:font];
    [bgImage addSubview:_paryLabel];
    
    UILabel * amount = [[UILabel alloc]initWithFrame:CGRectMake(_paryLabel.frame.size.width+_paryLabel.frame.origin.x-40, _paryLabel.frame.origin.y, 100, 20)];
    amount.text=@"功德量:";
    amount.font=[UIFont systemFontOfSize:font];
    amount.textColor=[UIColor whiteColor];
    [bgImage addSubview:amount];
    
    _amountLabel = [[UILabel alloc]initWithFrame:CGRectMake(amount.frame.size.width+amount.frame.origin.x-50, amount.frame.origin.y,SCREEN_WIDTH*0.3, 20)];
    _amountLabel.textColor=[UIColor whiteColor];
    _amountLabel.font=[UIFont systemFontOfSize:font];
    [bgImage addSubview:_amountLabel];
    
    UIButton * button=[[UIButton alloc]initWithFrame:CGRectMake(0, height*0.9, SCREEN_WIDTH, 30)];
    [button setBackgroundColor:[UIColor clearColor]];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIImageView * yindaoiv=[[UIImageView alloc]initWithFrame:CGRectMake(width*0.1, 7, SCREEN_WIDTH*0.05, SCREEN_WIDTH*0.05)];
    yindaoiv.image=[UIImage imageNamed:@"引号"];
    [button addSubview:yindaoiv];
    
    signture=[[UILabel alloc]initWithFrame:CGRectMake(50, 3, SCREEN_WIDTH*0.8, SCREEN_WIDTH*0.075)];
    signture.textColor=[UIColor whiteColor];
    signture.font=[UIFont systemFontOfSize:font];
    [button addSubview:signture];
    
    view=[[UIView alloc]initWithFrame:CGRectMake(0, height+10, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    
    UIButton * zhanghu=[[UIButton alloc]initWithFrame:CGRectMake(width*0.1+SCREEN_WIDTH*0.15, view.frame.origin.x+20, width*0.2, height*0.13)];
    [zhanghu setBackgroundImage:[UIImage imageNamed:@"account_icon.png"] forState:UIControlStateNormal];
    [zhanghu addTarget:self action:@selector(zhanghubt) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:zhanghu];
    UILabel * zhanghula=[[UILabel alloc]initWithFrame:CGRectMake(zhanghu.frame.origin.x+3,zhanghu.frame.origin.y+height*0.2, 50, 20)];
    zhanghula.text=@"账户";
    zhanghula.font=[UIFont systemFontOfSize:font];
    [view addSubview:zhanghula];
    
    UIButton * newBtn=[[UIButton alloc]initWithFrame:CGRectMake(zhanghu.frame.origin.x+zhanghu.frame.size.width+75, view.frame.origin.x+20, width*0.2, height*0.13)];
    [newBtn setBackgroundImage:[UIImage imageNamed:@"信箱"] forState:UIControlStateNormal];
    [newBtn addTarget:self action:@selector(newBtnbt) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:newBtn];
    UILabel * xinxiangla=[[UILabel alloc]initWithFrame:CGRectMake(newBtn.frame.origin.x+3, zhanghula.frame.origin.y, 50, 20)];
    xinxiangla.text=@"消息";
    xinxiangla.font=[UIFont systemFontOfSize:font];
    [view addSubview:xinxiangla];
    
    UIButton * foli=[[UIButton alloc]initWithFrame:CGRectMake(zhanghu.frame.origin.x-width*0.01-3, zhanghula.frame.origin.y+zhanghula.frame.size.height+15, width*0.25, height*0.15)];
    [foli setBackgroundImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateNormal];
    [foli addTarget:self action:@selector(folibt) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:foli];
    UILabel * folila=[[UILabel alloc]initWithFrame:CGRectMake(zhanghula.frame.origin.x, foli.frame.origin.y+height*0.2, 50, 20)];
    folila.text=@"佛历";
    folila.font=[UIFont systemFontOfSize:font];
    [view addSubview:folila];

    UIButton * shezhi=[[UIButton alloc]initWithFrame:CGRectMake(newBtn.frame.origin.x, foli.frame.origin.y, width*0.2, height*0.13)];
    [shezhi setBackgroundImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    [shezhi addTarget:self action:@selector(shezhibt) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:shezhi];
    UILabel * shezhila=[[UILabel alloc]initWithFrame:CGRectMake(shezhi.frame.origin.x+5, folila.frame.origin.y, 50, 20)];
    shezhila.text=@"设置";
    shezhila.font=[UIFont systemFontOfSize:font];
    [view addSubview:shezhila];
    
    UIButton * reCharge = [[UIButton alloc]initWithFrame:CGRectMake(zhanghu.frame.origin.x, folila.frame.origin.y+folila.frame.size.height+15,width*0.2, height*0.13)];
    [reCharge setBackgroundImage:[UIImage imageNamed:@"Purchase"] forState:UIControlStateNormal];
    [reCharge addTarget:self action:@selector(reCharge) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:reCharge];
    
    UILabel * reChargelabel = [[UILabel alloc]initWithFrame:CGRectMake(zhanghula.frame.origin.x, reCharge.frame.origin.y+height*0.2, 50, 20)];
    reChargelabel.text=@"充值";
    reChargelabel.font=[UIFont systemFontOfSize:font];
    [view addSubview:reChargelabel];
    
    UIButton * helpBtn = [[UIButton alloc]initWithFrame:CGRectMake(shezhi.frame.origin.x, shezhila.frame.origin.y+shezhila.frame.size.height+15, width*0.2, height*0.13)];
    [helpBtn setBackgroundImage:[UIImage imageNamed:@"help_center_icon"] forState:UIControlStateNormal];
    [helpBtn addTarget:self action:@selector(helpClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:helpBtn];
    
    UILabel * helpLabel = [[UILabel alloc]initWithFrame:CGRectMake(xinxiangla.frame.origin.x, reChargelabel.frame.origin.y, 50, 20)];
    helpLabel.text=@"帮助";
    helpLabel.font=[UIFont systemFontOfSize:font];
    [view addSubview:helpLabel];
    
   
}
#pragma mark ----按钮事件----
//图片
-(void)photoTapped{
    UserInfoEditingViewController  * head=[[UserInfoEditingViewController alloc]init];
    UINavigationController  * navVc = [[UINavigationController alloc] initWithRootViewController:head];
    navVc.navigationBarHidden = YES;
    head.lastViewController = self;
    [self.sideMenuViewController setContentViewController:navVc animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}
//说说
-(void)buttonClick{
    UserInfoEditingViewController  * head=[[UserInfoEditingViewController alloc]init];
    UINavigationController  * navVc = [[UINavigationController alloc] initWithRootViewController:head];
    navVc.navigationBarHidden = YES;
    head.lastViewController = self;
    [self.sideMenuViewController setContentViewController:navVc animated:YES];
    [self.sideMenuViewController hideMenuViewController];

}
//账户
-(void)zhanghubt{
    
    UserInfoEditingViewController  * head=[[UserInfoEditingViewController alloc]init];
    UINavigationController  * navVc = [[UINavigationController alloc] initWithRootViewController:head];
    navVc.navigationBarHidden = YES;
    head.lastViewController = self;
    [self.sideMenuViewController setContentViewController:navVc animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
}
//认证
-(void)renzhengbt{
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"个人认证", @"企业认证", nil];
//    [view addSubview:actionSheet];
    [actionSheet showInView:view];

    
}
//设置
-(void)shezhibt{
    
    SetUpViewController  * head=[[SetUpViewController alloc]init];
    UINavigationController  * navVc = [[UINavigationController alloc] initWithRootViewController:head];
    navVc.navigationBarHidden = YES;
    head.lastViewController = self;
    [self.sideMenuViewController setContentViewController:navVc animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
}
//消息
-(void)newBtnbt{
    XinXiangViewController  * new=[[XinXiangViewController alloc]init];
    [new getMessageInfo];
    UINavigationController  * navVc = [[UINavigationController alloc] initWithRootViewController:new];
    navVc.navigationBarHidden = YES;
    new.lastViewController = self;
    [self.sideMenuViewController setContentViewController:navVc animated:YES];
    [self.sideMenuViewController hideMenuViewController];


}
//佛历
-(void)folibt{
    BuddhistCalendarViewController  * calendar=[[BuddhistCalendarViewController alloc]init];
    
    UINavigationController  * navVc = [[UINavigationController alloc] initWithRootViewController:calendar];
    navVc.navigationBarHidden = YES;
    calendar.lastViewController = self;
    [self.sideMenuViewController setContentViewController:navVc animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
}
//帮助
-(void)helpClick{

    NewsViewController * help = [[NewsViewController alloc]init];
    UINavigationController  * navVc = [[UINavigationController alloc] initWithRootViewController:help];
    navVc.navigationBarHidden = YES;
    help.lastViewController = self;
    [self.sideMenuViewController setContentViewController:navVc animated:YES];
    [self.sideMenuViewController hideMenuViewController];

}
//充值
-(void)reCharge{

    PayViewController * pay = [[PayViewController alloc]init];
    UINavigationController  * navVc = [[UINavigationController alloc] initWithRootViewController:pay];
    navVc.navigationBarHidden = YES;
    pay.lastViewController = self;
    [self.sideMenuViewController setContentViewController:navVc animated:YES];
    [self.sideMenuViewController hideMenuViewController];

}
#pragma mark ----actionSheet代理-------
- (void)actionSheet:(UIActionSheet *)actionSheet

didDismissWithButtonIndex:(NSInteger)buttonIndex

{
    
    if( buttonIndex ==0){
//        GeRenViewController * own = [[GeRenViewController alloc]init];
//        UINavigationController  * navVc = [[UINavigationController alloc] initWithRootViewController:own];
//        navVc.navigationBarHidden = YES;
//        own.lastViewController = self;
//        [self.sideMenuViewController setContentViewController:navVc animated:YES];
//        [self.sideMenuViewController hideMenuViewController];
        
    }else if( buttonIndex ==1){
//        EnterpriseViewController * enter = [[EnterpriseViewController alloc]init];
//        UINavigationController * navVC = [[UINavigationController alloc]initWithRootViewController:enter];
//        navVC.navigationBarHidden=YES;
//        enter.lastViewController=self;
//        [self.sideMenuViewController setContentViewController:navVC animated:YES];
//        [self.sideMenuViewController hideMenuViewController];
        
    }

    
}
#pragma mark ------侧滑界面的接口------
-(void)getInfo{
    
   
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
     NSNumber * miyaoNum = [appDelegate.accountBasicDict objectForKey:@"secretKey"];
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSDictionary * dic=@{@"huaienID":huaien};
    NSDictionary * haeddic=@{@"params":[NSString stringWithFormat:@"%@",dic]};
    AppDelegate * delegte=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegte.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,memberVipURL] parameters:haeddic success:^(NSURLSessionDataTask *task, id responseObject){
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"用户信息=%@",jsonData);
        NSDictionary * dic1=@{@"secretKey":miyaoNum,@"huaienID":huaien};
        NSDictionary * headDic1=@{@"params":[NSString stringWithFormat:@"%@",dic1]};
        //self.userInfoDictionary = delegte.accountBasicDict;
        [delegte.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,putixinzhanghuURL] parameters:headDic1 success:^(NSURLSessionDataTask *task, id responseObject){
            id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"用户详细=%@",jsonData);
            [self.userInfoDictionary setObject:jsonData[@"headImg"] forKey:@"headImage"];
            [self.userInfoDictionary setObject:jsonData[@"totalIntegral"] forKey:@"totalIntegral"];
    
            NSString * headImage=jsonData[@"headImg"];
            [[NSUserDefaults standardUserDefaults]setObject:headImage forKey:@"headImg"];
         NSNumber  *totalIntegral=jsonData[@"totalIntegral"];
            [[NSUserDefaults standardUserDefaults]setObject:totalIntegral forKey:@"totalIntegral"];
           
       #pragma mark ----得到相应的值---- 
            NSString * str = [appDelegate.accountBasicDict objectForKey:@"levelAndDesignation"];
            NSArray *array = [str componentsSeparatedByString:@"|"];
            for (int i = 0; i < [array count]; i++) {
                NSLog(@"string:%@", [array objectAtIndex:i]);
                [lvt setTitle:[NSString stringWithFormat:@"LV%@",array[0]] forState:UIControlStateNormal];
                
            }
            huaienIDtext.text=[NSString stringWithFormat:@"%@",[appDelegate.accountBasicDict objectForKey:@"huaienID"]];
            _amountLabel.text=[NSString stringWithFormat:@"%@",jsonData[@"meritQty"]];
            NSString *nickName=jsonData[@"nickName"];
            NSLog(@"名字=%@",nickName);
            [[NSUserDefaults standardUserDefaults]setObject:nickName forKey:@"name"];
            title.text=[NSString stringWithFormat:@"%@",jsonData[@"nickName"]];
         
            signture.text=[NSString stringWithFormat:@"%@",jsonData[@"signature"]];
            _paryLabel.text=[NSString stringWithFormat:@"%@",[appDelegate.accountBasicDict objectForKey:@"prayMoney"]];
            if([jsonData[@"headImg"] hasPrefix:@"http"]){
              [touxiang setImageWithURL:[NSURL URLWithString:jsonData[@"headImg"]]];
            }else{
                touxiang.image=[UIImage imageNamed:@"默认头像.png"];
            }
//            NSURL *bgImabgeUrl=[NSURL URLWithString:jsonData[@"backgroundImg"]];
//            UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:bgImabgeUrl]];
//            bgImage.image=image;
//           [bgImage setImageWithURL:[NSURL URLWithString:jsonData[@"backgroundImg"]]];
            //bgImage.image=jsonData[@"backgroundImg"];
            
        } failure:^(NSURLSessionDataTask *task, id responseObject){
            
        }];
        
    } failure:^(NSURLSessionDataTask *task, id responseObject){
        
    }];
}

-(NSString*)findNumFromStr:(NSString *)originalString
{
    
    // Intermediate
    NSMutableString *numberString = [[NSMutableString alloc] init] ;
    NSString *tempStr;
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    while (![scanner isAtEnd]) {
        // Throw away characters before the first number.
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        
        // Collect numbers.
        [scanner scanCharactersFromSet:numbers intoString:&tempStr];
        [numberString appendString:tempStr];
        tempStr = @"";
    }
    // Result.
    
    return numberString;
}



@end
