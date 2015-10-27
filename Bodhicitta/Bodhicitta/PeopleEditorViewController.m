//
//  PeopleEditorViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/5/20.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "PeopleEditorViewController.h"
#import "ZhangHuViewController.h"
@interface PeopleEditorViewController ()

@end

@implementation PeopleEditorViewController


- (NSMutableArray *)menus {
    if (!_menus) {
        _menus = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _menus;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    
    UIImageView * iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 230)];
    iv.image=[UIImage imageNamed:@"个人中心顶部背景.png"];
    [self.view addSubview:iv];
    
    UIButton * peoplebt=[[UIButton alloc]initWithFrame:CGRectMake(5, 30, 25, 25)];
    [peoplebt setBackgroundImage:[UIImage imageNamed:@"个人中心返回按钮.png"] forState:UIControlStateNormal];
    [peoplebt addTarget:self action:@selector(clickHome:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:peoplebt];
    
    UIButton * editorbt=[[UIButton alloc]initWithFrame:CGRectMake(330, 30, 35, 30)];
    [editorbt setBackgroundImage:[UIImage imageNamed:@"个人中心编辑按钮"] forState:UIControlStateNormal];
    [iv addSubview:editorbt];
    
    UIImageView * touphoto=[[UIImageView alloc]initWithFrame:CGRectMake(20, 90, 60, 60)];
    touphoto.image=[UIImage imageNamed:@"头像.png"];
    [iv addSubview:touphoto];
    
    UIImageView * genghuan=[[UIImageView alloc]initWithFrame:CGRectMake(60, 130, 18, 18)];
    genghuan.image=[UIImage imageNamed:@"更换头像.png"];
    [iv addSubview:genghuan];
    
    UILabel * name=[[UILabel alloc]initWithFrame:CGRectMake(90, 90, 100, 20)];
    name.text=@"虞诚之心";
    name.textColor=[UIColor whiteColor];
    [iv addSubview:name];
    
    UIImageView * renzheng=[[UIImageView alloc]initWithFrame:CGRectMake(165, 95, 10, 10)];
    renzheng.image=[UIImage imageNamed:@"认证.png"];
    [iv addSubview:renzheng];
    
    UIImageView * xindeng=[[UIImageView alloc]initWithFrame:CGRectMake(180, 95, 10, 10)];
    xindeng.image=[UIImage imageNamed:@"心灯.png"];
    [iv addSubview:xindeng];
    
    UIImageView * huiyuan=[[UIImageView alloc]initWithFrame:CGRectMake(195, 95, 10, 10)];
    huiyuan.image=[UIImage imageNamed:@"会员.png"];
    [iv addSubview:huiyuan];
    
    UIButton * vipbt=[[UIButton alloc]initWithFrame:CGRectMake(90, 115, 20, 10)];
    [vipbt setBackgroundImage:[UIImage imageNamed:@"LV1.png"] forState:UIControlStateNormal];
    [vipbt setTitle:@"LV7" forState:UIControlStateNormal];
    [vipbt setTintColor:[UIColor whiteColor]];
    vipbt.font=[UIFont systemFontOfSize:10];
    [iv addSubview:vipbt];
    
    UIProgressView *pro1=[[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    //设置的高度对进度条的高度没影响，整个高度=进度条的高度，进度条也是个圆角矩形
    //但slider滑动控件：设置的高度对slider也没影响，但整个高度=设置的高度，可以设置背景来检验
    pro1.frame=CGRectMake(115, 120, 55, 100);
    
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.0f);
    pro1.transform = transform;
    
    //设置进度条颜色
    pro1.trackTintColor=[UIColor whiteColor];
    pro1.layer.cornerRadius = self.view.frame.size.height/2;
    
    //设置进度默认值，这个相当于百分比，范围在0~1之间，不可以设置最大最小值
    pro1.progress=0.7;
    //设置进度条上进度的颜色
    pro1.progressTintColor=[UIColor redColor];
    //设置进度条的背景图片
    //    pro1.trackImage=[UIImage imageNamed:@"logo.png"];
    //    //设置进度条上进度的背景图片
    //    pro1.progressImage=[UIImage imageNamed:@"1.png"];
    //设置进度值并动画显示
    [pro1 setProgress:0.7 animated:YES];
    [iv addSubview:pro1];
    
    UILabel * namela=[[UILabel alloc]initWithFrame:CGRectMake(90, 130, 50, 20)];
    namela.text=@"怀恩ID:";
    namela.font=[UIFont systemFontOfSize:14];
    [iv addSubview:namela];
    
    UILabel * idla=[[UILabel alloc]initWithFrame:CGRectMake(135, 130, 50, 20)];
    idla.text=@"10058";
    idla.font=[UIFont systemFontOfSize:14];
    [iv addSubview:idla];
    
    UILabel * guanzhu=[[UILabel alloc]initWithFrame:CGRectMake(90, 150, 40, 20)];
    guanzhu.text=@"关注:";
    guanzhu.font=[UIFont systemFontOfSize:14];
    [iv addSubview:guanzhu];
    UILabel * guanzhula=[[UILabel alloc]initWithFrame:CGRectMake(125, 150, 40, 20)];
    guanzhula.text=@"58";
    guanzhula.font=[UIFont systemFontOfSize:14];
    [iv addSubview:guanzhula];
    
    UILabel * fensi=[[UILabel alloc]initWithFrame:CGRectMake(160, 150, 40, 20)];
    fensi.text=@"粉丝:";
    fensi.font=[UIFont systemFontOfSize:14];
    [iv addSubview:fensi];
    UILabel * fensila=[[UILabel alloc]initWithFrame:CGRectMake(195, 150, 40, 20)];
    fensila.text=@"1586";
    fensila.font=[UIFont systemFontOfSize:14];
    [iv addSubview:fensila];
    
    UILabel * zongjie=[[UILabel alloc]initWithFrame:CGRectMake(90, 180, 210, 30)];
    zongjie.text=@"大悲无泪,大悟无言,大笑无声";
    zongjie.textColor=[[UIColor alloc]initWithRed:0.123 green:0.435 blue:0.52 alpha:1];//土蓝色
    zongjie.font=[UIFont systemFontOfSize:15];
    [iv addSubview:zongjie];
    
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 230, 410, self.view.frame.size.height)];
    tableview.delegate=self;
    tableview.dataSource=self;
    [self.view addSubview:tableview];
    
    
     self.shouldObserving = YES;

}

-(void)clickHome:(id)sender{
    ViewController * view=[[ViewController alloc]init];
      [self.navigationController pushViewController:view animated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)buclick{

    LeftViewController * zhanghu=[[LeftViewController alloc]init];
        [self.navigationController pushViewController:zhanghu animated:YES];
}


//设置tableView的组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 9;
    
    
}

//设置组数里面各行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger senction = indexPath.section;
    if(senction ==0){
        return 48.0;
    }
    if(senction ==1){
        return 48.0;
    }
    if (senction ==2) {
        return 48.0;
    }
    if (senction ==3) {
        return 48.0;
    }
    if (senction ==4) {
        return 48.0;
    }
    if (senction ==5) {
        return 48.0;
    }
    if (senction ==6) {
        return 48.0;
    }
    if (senction ==7) {
        return 48.0;
    }
    if (senction ==8) {
        return 48.0;
    }
    return 100.0;
}
//设置组数里面各行的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section) {
        return arrllist.count == 0 ? 1 :arrllist.count;
    }
    else
        return arrllist.count + 1;
}

//tableView 的代理
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    
    static NSString *mycell = @"ViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mycell];
    
    if(section==0){
        if(cell == nil){
            
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 390, 48)];
        imageview.image=[UIImage imageNamed:@"个人中心菜单背景.png"];
        [cell addSubview:imageview];
        
        _oneView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"图标1.png"]];
        _oneView.frame=CGRectMake(10, 13, 23, 23);
        [imageview addSubview:_oneView];
        
        UILabel * onetext=[[UILabel alloc]initWithFrame:CGRectMake(40, 12, 90, 25)];
        onetext.text=@"福田账户";
        onetext.font=[UIFont systemFontOfSize:20];
        [imageview addSubview:onetext];
        
    }
    if(section==1){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 390, 48)];
        imageview.image=[UIImage imageNamed:@"个人中心菜单背景.png"];
        [cell addSubview:imageview];
        
        _twoView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"图标2.png"]];
        _twoView.frame=CGRectMake(10, 13, 23, 23);
        [imageview addSubview:_twoView];
        
        UILabel * twotext=[[UILabel alloc]initWithFrame:CGRectMake(40, 12, 140, 25)];
        twotext.text=@"荣誉 : 福田勋章";
        twotext.font=[UIFont systemFontOfSize:20];
        [imageview addSubview:twotext];
        
    }
    
    if(section==2){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 390, 48)];
        imageview.image=[UIImage imageNamed:@"个人中心菜单背景.png"];
        [cell addSubview:imageview];
        _threeView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"图标3.png"]];
        _threeView.frame=CGRectMake(10, 13, 23, 23);
        [imageview addSubview:_threeView];
        
        UILabel * threetext=[[UILabel alloc]initWithFrame:CGRectMake(40, 12, 90, 25)];
        threetext.text=@"我的邮箱";
        threetext.font=[UIFont systemFontOfSize:20];
        [imageview addSubview:threetext];
        
    }
    if(section==3){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 390, 48)];
        imageview.image=[UIImage imageNamed:@"个人中心菜单背景.png"];
        [cell addSubview:imageview];
        _fourView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"图标4.png"]];
        _fourView.frame=CGRectMake(10, 13, 23, 23);
        [imageview addSubview:_fourView];
        
        UILabel * fourtext=[[UILabel alloc]initWithFrame:CGRectMake(40, 12, 90, 25)];
        fourtext.text=@"我的收藏";
        fourtext.font=[UIFont systemFontOfSize:20];
        [imageview addSubview:fourtext];
        
    }
    if(section==4){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 390, 48)];
        imageview.image=[UIImage imageNamed:@"个人中心菜单背景.png"];
        [cell addSubview:imageview];
        _fiveView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"图标5.png"]];
        _fiveView.frame=CGRectMake(10, 13, 23, 23);
        [imageview addSubview:_fiveView];
        
        UILabel * fivetext=[[UILabel alloc]initWithFrame:CGRectMake(40, 12, 90, 25)];
        fivetext.text=@"每日功课";
        fivetext.font=[UIFont systemFontOfSize:20];
        [imageview addSubview:fivetext];
    }
    if(section==5){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 390, 48)];
        imageview.image=[UIImage imageNamed:@"个人中心菜单背景.png"];
        [cell addSubview:imageview];
        _sixView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"图标6.png"]];
        _sixView.frame=CGRectMake(10, 13, 23, 23);
        [imageview addSubview:_sixView];
        
        UILabel * sixtext=[[UILabel alloc]initWithFrame:CGRectMake(40, 12, 90, 25)];
        sixtext.text=@"我的成就";
        sixtext.font=[UIFont systemFontOfSize:20];
        [imageview addSubview:sixtext];
        
    }
    if(section==6){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 390, 48)];
        imageview.image=[UIImage imageNamed:@"个人中心菜单背景.png"];
        [cell addSubview:imageview];
        _tevenView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"图标7.png"]];
        _tevenView.frame=CGRectMake(10, 13, 23, 23);
        [imageview addSubview:_tevenView];
        
        UILabel * teventext=[[UILabel alloc]initWithFrame:CGRectMake(40, 12, 90, 25)];
        teventext.text=@"菩提心灯";
        teventext.font=[UIFont systemFontOfSize:20];
        [imageview addSubview:teventext];
    }
    
    if(section==7){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 390, 48)];
        imageview.image=[UIImage imageNamed:@"个人中心菜单背景.png"];
        [cell addSubview:imageview];
        _eightView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"图标8.png"]];
        _eightView.frame=CGRectMake(10, 13, 23, 23);
        [imageview addSubview:_eightView];
        
        UILabel * eighttext=[[UILabel alloc]initWithFrame:CGRectMake(40, 12, 90, 25)];
        eighttext.text=@"申请认证";
        eighttext.font=[UIFont systemFontOfSize:20];
        [imageview addSubview:eighttext];
    }
    
    if(section==8){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 390, 48)];
        imageview.image=[UIImage imageNamed:@"个人中心菜单背景.png"];
        [cell addSubview:imageview];
        _nineView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"图标9.png"]];
        _nineView.frame=CGRectMake(10, 13, 23, 23);
        [imageview addSubview:_nineView];
        
        UILabel * ninetext=[[UILabel alloc]initWithFrame:CGRectMake(40, 12, 90, 25)];
        ninetext.text=@"万年佛历";
        ninetext.font=[UIFont systemFontOfSize:20];
        [imageview addSubview:ninetext];
        
    }
    
    
    UIButton * bt=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    bt.frame=CGRectMake(330, 15, 18, 18);
    [bt setBackgroundImage:[UIImage imageNamed:@"箭头图标.png"] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(myBtnClick:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:bt];
    
    //    cell.accessoryView = bt;
    return cell;
}

-(void)myBtnClick:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];   // 把触摸的事件放到集合里
    
    UITouch *touch = [touches anyObject];   //把事件放到触摸的对象了
    
    CGPoint currentTouchPosition = [touch locationInView:tableview]; //把触发的这个点转成二位坐标
    
    NSIndexPath *indexPath = [tableview indexPathForRowAtPoint:currentTouchPosition]; //匹配坐标点
    if(indexPath !=nil)
    {
        //        [selftableView:self.tableviewaccessoryButtonTappedForRowWithIndexPath:indexPath];
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    NSInteger senction = indexPath.section;
    if(senction == 0)
    {
        ZhangHuViewController *loginViewController = [[ZhangHuViewController alloc]init];
        [self.navigationController pushViewController:loginViewController animated:YES];
    }else if([indexPath row] == 1)
    {
        //        AboutUsViewController *aboutUsViewController = [[AboutUsViewController alloc]initWithNibName:@"AboutUsViewController" bundle:nil];
        //        aboutUsViewController.hidesBottomBarWhenPushed = YES;
        //        [self.navigationController pushViewController:aboutUsViewController animated:YES];
        
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
