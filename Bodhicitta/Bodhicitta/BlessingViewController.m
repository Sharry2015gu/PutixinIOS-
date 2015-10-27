//
//  BlessingViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/3.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "BlessingViewController.h"
#import "HeaderFile.h"

#define Start_X 10.0f           // 第一个按钮的X坐标

#define Start_Y 60.0f           // 第一个按钮的Y坐标

#define Width_Space 10.0f        // 2个按钮之间的横间距

#define Height_Space 10.0f      // 竖间距

#define Row_Space   30.0f       //行距

#define Button_Height 20.0f    // 高

#define Button_Width 68.0f      // 宽

@interface BlessingViewController ()

@end

@implementation BlessingViewController
@synthesize dateArray;
@synthesize delegate;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 70)];
    view.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"顶部导航背景"]];
    [self.view addSubview:view];
    //    UIImageView *
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(165, 30, 80, 30)];
    title.text=@"祈福";
    title.font=[UIFont systemFontOfSize:20];
    title.textColor=[UIColor whiteColor];
    [view addSubview:title];
    
    UIView * background=[[UIView alloc]initWithFrame:CGRectMake(0, 70, 380, 550)];
    background.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    [self.view addSubview:background];
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [scrollview setShowsHorizontalScrollIndicator:NO];
    [scrollview setContentSize:CGSizeMake(SCREEN_WIDTH, 1000)];
    [scrollview setDelegate:self];
    [scrollview setBackgroundColor:[UIColor clearColor]];
//    [self.view addSubview:scrollview];
    
    dateArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<3; i++) {
        [dateArray addObject:[NSNumber numberWithInt:i+1]];
    }
    
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH+5, 600)];
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.backgroundColor=[UIColor clearColor];
    [background addSubview:tableview];
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dateArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier_ = @"cell_";
    UITableViewCell *cell_ = [tableView dequeueReusableCellWithIdentifier:identifier_];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (cell_ == nil){
        cell_ = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_] ;
        
        bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210)];
        bgImage.image=[UIImage imageNamed:@"bookshelf_items_bg1.jpg"];
        bgImage.tag=10;
        [cell_.contentView addSubview:bgImage];
        
        UIImageView * zhongjian=[[UIImageView alloc]initWithFrame:CGRectMake(185, 0, 10, 210)];
        zhongjian.image=[UIImage imageNamed:@"111.png"];
        [cell_.contentView addSubview:zhongjian];
        
        fozuImage1 = [[button_fozu1 alloc]initWithFrame:CGRectMake(28, 33, 140, 165)];
        fozuImage1.indexPath = indexPath;
        [fozuImage1 setBackgroundImage:[UIImage imageNamed:@"buddha_icon_list_items"] forState:UIControlStateNormal];
        [fozuImage1 addTarget:self action:@selector(fozuClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell_ addSubview:fozuImage1];
        
        fozuName1=[[UILabel alloc]initWithFrame:CGRectMake(160, 5, 20, 100)];
        fozuName1.numberOfLines = 5;
        fozuName1.text=@"释迦摩尼佛";
        fozuName1.font=[UIFont systemFontOfSize:15];
        fozuName1.textColor=Typeface;
        [cell_.contentView addSubview:fozuName1];
        
        huoImage=[[UIImageView alloc]initWithFrame:CGRectMake(80, 11, 10, 15)];
        huoImage.image=[UIImage imageNamed:@"huo"];
        [cell_.contentView addSubview:huoImage];
        
        numLa1=[[UILabel alloc]initWithFrame:CGRectMake(90, 8, 100, 20)];
        numLa1.text=@"1021";
        numLa1.font=[UIFont systemFontOfSize:12];
        numLa1.textColor=TypefaceName;
        [cell_.contentView addSubview:numLa1];
        
        fozuImage2 = [[button_fozu1 alloc]initWithFrame:CGRectMake(207, 33, 140, 165)];
        fozuImage2.indexPath = indexPath;
        [fozuImage2 setBackgroundImage:[UIImage imageNamed:@"buddha_icon_list_items"] forState:UIControlStateNormal];
        [fozuImage2 addTarget:self action:@selector(fozu1Click:) forControlEvents:UIControlEventTouchUpInside];
        [cell_ addSubview:fozuImage2];
        
        fozuName2=[[UILabel alloc]initWithFrame:CGRectMake(340, 5, 20, 60)];
        fozuName2.numberOfLines = 3;
        fozuName2.text=@"关公";
        fozuName2.font=[UIFont systemFontOfSize:15];
        fozuName2.textColor=Typeface;
        [cell_.contentView addSubview:fozuName2];
        
        numLa2=[[UILabel alloc]initWithFrame:CGRectMake(265, 8, 100, 20)];
        numLa2.text=@"1221";
        numLa2.font=[UIFont systemFontOfSize:12];
        numLa2.textColor=TypefaceName;
        [cell_.contentView addSubview:numLa2];

        
    }
    
    cell_.selectionStyle=UITableViewCellSeparatorStyleNone;
    
    return cell_;
    
}
-(void)fozuClick:(button_fozu1*)button{
    
    UIView *sup_view1 = button.superview;
    [bgBt removeFromSuperview];
    
    bgBt = nil;
    bgBt=[[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 180, 200)];
    bgBt.image=[UIImage imageNamed:@"buddha_choosed_list_bg"];
    bgBt.userInteractionEnabled = YES;
    [sup_view1 addSubview:bgBt];
    
    QiFo_MainViewController * qifu=[[QiFo_MainViewController alloc]init];

    
    [self.navigationController pushViewController:qifu animated:YES];
    
    self.delegate =qifu;   //这里和B进行交互下一句代码就是对应的赋值
    [self.delegate setValue: @"hdbejbej"];
    
}
-(void)fozu1Click:(button_fozu1*)button{
    [bgBt removeFromSuperview];
    bgBt = nil;

    UIView *sup_view2 = button.superview;
    bgBt=[[UIImageView alloc]initWithFrame:CGRectMake(190, 0, 180, 200)];
    bgBt.image=[UIImage imageNamed:@"buddha_choosed_list_bg"];
    bgBt.userInteractionEnabled=YES;
    [sup_view2 addSubview:bgBt];
    
    QiFo_MainViewController * qifo=[[QiFo_MainViewController alloc]init];
    [self.navigationController pushViewController:qifo animated:YES];
    
    self.delegate =qifo;   //这里和B进行交互下一句代码就是对应的赋值
    [self.delegate setValue: @"关公"];
}
-(void)passValue:(QiFo_MainViewController *)value
{
    fozuName1.text = value.title;
//    self.ageLabel.text = [NSString stringWithFormat:@"%d",value.age];
//    self.gendarLabel.text = value.gendar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

//传值
@implementation button_fozu1


@end
