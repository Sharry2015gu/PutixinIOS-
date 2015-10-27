//
//  BuddhistCalendarViewController.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/10/10.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "BuddhistCalendarViewController.h"
#import "HeaderFile.h"
#import "RESideMenu.h"
#import "CalendarView.h"
@interface BuddhistCalendarViewController ()
{
    int   yearIndex;
    int   montnIndex;
    UILabel * hintDateLabel;
    UILabel * hintLunarLabel;
    CalendarView  * myCalendarView;
    NSDate  * currentDate;
    UIView  * earlyView1;
    UIView  * lateView1;
    
    UISwitch  *mySwitch1;
    UISwitch  *mySwitch2;
}
@property(nonatomic,strong)UILabel  * currentDateLabel;
@property(nonatomic,strong)UIDatePicker  * datePicker;
@property(nonatomic,strong)UIView  * datePickerView;
@property(nonatomic,strong)UIDatePicker * earlyDatePicker;
@property(nonatomic,strong)UIDatePicker * lateDatePicker;
@property(nonatomic,strong)UIView  *  maskView;
@property(nonatomic,strong)NSCalendar * calendar;
@property(nonatomic,strong)UIView  * hintView;
@property(nonatomic,strong)UILabel  * earlyLabel;
@property(nonatomic,strong)UILabel  * lateLabel;
@property(nonatomic,strong)UIView   *earlyTimerPickerView;
@property(nonatomic,strong)UIView   *lateTimerPickerView;
@end

@implementation BuddhistCalendarViewController
-(UIView *)earlyTimerPickerView
{
    if (_earlyTimerPickerView == nil) {
        _earlyTimerPickerView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 120) / 2,(SCREEN_HEIGHT - 180) / 2,120, 180)];
        CALayer *earlyPickerViewLayer = _earlyTimerPickerView.layer;
        earlyPickerViewLayer.cornerRadius = 5;
        earlyPickerViewLayer.masksToBounds = YES;
        UILabel * titleLabel= [[UILabel alloc]initWithFrame:CGRectMake(0,0,_earlyTimerPickerView.frame.size.width,30)];
        titleLabel.text = @"功课时间";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont boldSystemFontOfSize:13];
        titleLabel.textColor = [UIColor blueColor];
        titleLabel.backgroundColor = [UIColor lightGrayColor];
        [_earlyTimerPickerView addSubview:titleLabel];
        
        self.earlyDatePicker = [[UIDatePicker alloc] init];
        NSLog(@"%ld",self.earlyDatePicker.frame.size.width);
        self.earlyDatePicker.frame = CGRectMake(0,CGRectGetMaxY(titleLabel.frame),_earlyTimerPickerView.frame.size.width,_earlyTimerPickerView.frame.size.height - 2 * 30);
        NSLog(@"%ld",self.earlyDatePicker.frame.size.width);
        self.earlyDatePicker.backgroundColor = [UIColor whiteColor];
        self.earlyDatePicker.timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
        self.earlyDatePicker.datePickerMode = UIDatePickerModeTime;
        self.earlyDatePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
        [_earlyTimerPickerView addSubview:self.earlyDatePicker];
        
        UIButton  * resignBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,150,0.5 * _earlyTimerPickerView.frame.size.width,30)];
        [resignBtn setTitle:@"取消" forState:UIControlStateNormal];
        resignBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [resignBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        resignBtn.backgroundColor = [UIColor lightGrayColor];
        [resignBtn addTarget:self action:@selector(homeWorkResignBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_earlyTimerPickerView addSubview:resignBtn];
        
        UIButton  * submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.5 *_earlyTimerPickerView.frame.size.width,150,resignBtn.frame.size.width,30)];
        [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
        submitBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [submitBtn setTitleColor:[UIColor  blueColor]forState:UIControlStateNormal];
        submitBtn.backgroundColor = [UIColor lightGrayColor];
        [submitBtn addTarget:self action:@selector(homeWorkSubmitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_earlyTimerPickerView  addSubview:submitBtn];
        
    }
    return _earlyTimerPickerView;
}
#pragma mark  取消功课时间选择
-(void)homeWorkResignBtnClick
{
    [self.maskView removeFromSuperview];
    [self.earlyTimerPickerView removeFromSuperview];
}
#pragma mark  确定功课的时间
-(void)homeWorkSubmitBtnClick
{
    [self.maskView removeFromSuperview];
    [self.earlyTimerPickerView removeFromSuperview];
    //处理功课时间
    NSDate * date = self.earlyDatePicker.date;
    NSDateFormatter  * formatter  = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    NSString  * timeStr = [formatter stringFromDate:date];
    
    AppDelegate  * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString  * huaienId = [delegate.accountBasicDict  objectForKey:@"huaienId"];
    
    if (self.earlyTimerPickerView.tag == 600) {
        self.earlyLabel.text = [NSString stringWithFormat:@"    早功课  %@",timeStr];
        timeStr  = [NSString stringWithFormat:@"%@:00",timeStr];
        [[NSUserDefaults standardUserDefaults] setObject:timeStr forKey:[NSString stringWithFormat:@"%@%@",earlyHomeWorkTime,huaienId]];
    }
    else
    {
        self.lateLabel.text = [NSString stringWithFormat:@"    晚功课  %@",timeStr];
        timeStr  = [NSString stringWithFormat:@"%@:00",timeStr];
        [[NSUserDefaults standardUserDefaults] setObject:timeStr forKey:[NSString stringWithFormat:@"%@%@",lateHomeWorkTime,huaienId]];
    }
    
}
-(UIView *)hintView
{
    if (_hintView == nil) {
        _hintView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 - 65 , NAVBARHEIGHT + 0.3 * SCREEN_HEIGHT,130,100)];
        _hintView.backgroundColor = [UIColor whiteColor];
        CALayer * hintViewLayer = _hintView.layer;
        hintViewLayer.cornerRadius = 5.0;
        hintViewLayer.masksToBounds = YES;
        
        hintDateLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0,10,_hintView.frame.size.width,30)];
        hintDateLabel.font = [UIFont boldSystemFontOfSize:22];
        hintDateLabel.textAlignment = NSTextAlignmentCenter;
        [_hintView addSubview:hintDateLabel];
        
        hintLunarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,50,_hintView.frame.size.width,20)];
        hintLunarLabel.font = [UIFont systemFontOfSize:12];
        hintLunarLabel.textAlignment = NSTextAlignmentCenter;
        [_hintView addSubview:hintLunarLabel];
        
        
        UIView  * lineView = [[UIView alloc] initWithFrame:CGRectMake(0,_hintView.frame.size.height - 30 - 0.3,_hintView.frame.size.width,0.3)];
        lineView.backgroundColor = [UIColor blackColor];
        lineView.alpha = 0.1;
        [_hintView addSubview:lineView];
        UIButton * sumbitBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,_hintView.frame.size.height - 30,_hintView.frame.size.width,30)];
        sumbitBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [sumbitBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sumbitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        sumbitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_hintView addSubview:sumbitBtn];
        [sumbitBtn addTarget:self action:@selector(sumbitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hintView;
}
-(void)sumbitBtnClick
{
    [self.maskView removeFromSuperview];
    [self.hintView removeFromSuperview];
}
-(void)showHintViewWithDictionary:(NSDictionary *) dict
{
    [self.view addSubview:self.maskView];
    if (_hintView == nil) {
        [self.view addSubview:self.hintView];
        hintDateLabel.text = [dict objectForKey:@"solarDay"];
        hintLunarLabel.text = [dict objectForKey:@"lunarDay"];
    }
    else
    {
        hintDateLabel.text = [dict objectForKey:@"solarDay"];
        hintLunarLabel.text = [dict objectForKey:@"lunarDay"];
        [self.view addSubview:self.hintView];
    }
}
-(UIView *)datePickerView
{
    if (_datePickerView == nil) {
        _datePickerView = [[UIView alloc] initWithFrame:CGRectMake(0.1 *SCREEN_WIDTH ,0.28 * SCREEN_HEIGHT,0.8 * SCREEN_WIDTH,0.4 * SCREEN_HEIGHT)];
        _datePickerView.backgroundColor = [UIColor whiteColor];
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0,0,_datePickerView.frame.size.width,0.2 * _datePickerView.frame.size.height)];
        UILabel * hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,_datePickerView.frame.size.width,_datePickerView.frame.size.height * 0.2)];
        hintLabel.text = @"选择时间";
        hintLabel.backgroundColor = [UIColor whiteColor];
        hintLabel.backgroundColor = [UIColor clearColor];
        hintLabel.font = [UIFont systemFontOfSize:17];
        hintLabel.textColor = [UIColor blueColor];
        hintLabel.textAlignment = NSTextAlignmentCenter;
        topView.backgroundColor = [UIColor colorWithRed: 231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:1];
        [_datePickerView addSubview:topView];
        [_datePickerView addSubview:hintLabel];
        
        //时间选择器
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(topView.frame), _datePickerView.frame.size.width,0.6 *_datePickerView.frame.size.height)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans"];
        _datePicker.timeZone = [NSTimeZone localTimeZone];
        _datePicker.minimumDate = [NSDate dateWithTimeIntervalSince1970:0];
        [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        [_datePickerView addSubview:_datePicker];
        
        UIView  * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,0.8 * _datePickerView.frame.size.height,_datePicker.frame.size.width,0.2 * _datePickerView.frame.size.height)];
        
        UIButton  * resignBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0.8 *_datePickerView.frame.size.height,_datePickerView.frame.size.width* 0.5- 0.5, bottomView.frame.size.height)];
        //resignBtn.backgroundColor = [UIColor colorWithRed: 231/255.0 green: 231 / 255.0 blue:231 / 255.0 alpha:1];
        [resignBtn setTitle:@"取消" forState:UIControlStateNormal];
        resignBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [resignBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [resignBtn addTarget:self action:@selector(datePickerResignBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *seperatorLineView = [[UIView alloc] initWithFrame:CGRectMake(_datePickerView.frame.size.width* 0.5,5+0.8*_datePickerView.frame.size.height,1,bottomView.frame.size.height - 10)];
        seperatorLineView.backgroundColor = [UIColor darkGrayColor];
        seperatorLineView.alpha = 0.3;
        
        UIButton  *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(_datePickerView.frame.size.width* 0.5+0.5,0.8 * _datePickerView.frame.size.height,0.5 * _datePickerView.frame.size.width,bottomView.frame.size.height)];
        [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
        submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [submitBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        submitBtn.backgroundColor= [UIColor colorWithRed: 231 / 255.0 green:231 /  255.0 blue: 231 /  255.0 alpha:1];
        bottomView.backgroundColor = [UIColor colorWithRed:231 / 255.0 green: 231 / 255.0 blue:231 /  255.0 alpha:1];
        [submitBtn addTarget:self action:@selector(datePickerSubmitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_datePickerView addSubview:bottomView];
        CALayer *datePickViewLayer = _datePickerView.layer;
        datePickViewLayer.cornerRadius = 10;
        datePickViewLayer.masksToBounds = YES;
        
        [_datePickerView addSubview:resignBtn];
        [_datePickerView addSubview:seperatorLineView];
        [_datePickerView addSubview:submitBtn];
    }
    return _datePickerView;
}
-(void)datePickerSubmitBtnClick  //datePickerResignBtnClick
{
    //[myCalendarView reloadCalendarViewWith:currentDate];
    
    NSDateFormatter  *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.timeZone = [NSTimeZone localTimeZone];
    NSString   *dateString  = [formatter stringFromDate:currentDate];
    NSArray  *dateStringArray = [dateString componentsSeparatedByString:@"-"];
    self.currentDateLabel.text = [NSString stringWithFormat:@"%@年%@月",dateStringArray[0],dateStringArray[1]];
    CGFloat marginX = 5;
    CalendarView * calendarView = [[CalendarView alloc] initWithFrame:CGRectMake(marginX,myCalendarView.frame.origin.y,SCREEN_WIDTH - 2 * marginX, SCREEN_HEIGHT - NAVBARHEIGHT - 250) withDate:currentDate];
    calendarView.backgroundColor = [UIColor whiteColor];
    calendarView.showDetailBlock= ^void(NSDictionary * dict)
    {
        [self showHintViewWithDictionary:dict];
    };
    WS(weakSelf);
    calendarView.swipeLeftBlock = ^ void(NSDate  * date)
    {
        [weakSelf swipeCalendarViewLeftWithDate:date];
    };
    calendarView.swipeRightBlock = ^void(NSDate  * date)
    {
        [weakSelf swipeCalendarViewRightWithDate:date];
    };
    [myCalendarView removeFromSuperview];
    myCalendarView = calendarView;
    [self.view addSubview:calendarView];
    
    [self.maskView removeFromSuperview];
    [self.datePickerView removeFromSuperview];
}
-(void)datePickerResignBtnClick
{
    [self.maskView removeFromSuperview];
    [self.datePickerView removeFromSuperview];
}
-(UIView *) maskView
{
    if (_maskView == nil) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.7;
    }
    return _maskView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBar];
    [self createUI];
    currentDate = [NSDate date];
    //-(NSString *)LunarForSolar:(NSDate *)solarDate
    self.view.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景.png"]];
    // Do any additional setup after loading the view.
}
-(void)createUI
{
    NSDateFormatter * formatter  = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.timeZone = [NSTimeZone localTimeZone];
    NSString * dateString  = [formatter stringFromDate:[NSDate date]];
    NSArray  *dateArray = [dateString componentsSeparatedByString:@"-"];
    NSString  * yearStr = dateArray[0];
    NSString  * monthStr = dateArray[1];
    yearIndex = [yearStr intValue];
    montnIndex = [monthStr intValue];
    
    UIView  *  yearAndMonthView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVBARHEIGHT,SCREEN_WIDTH,50)];
    [self.view addSubview:yearAndMonthView];
    self.currentDateLabel = [[UILabel  alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 120) / 2,0,120,50)];
    self.currentDateLabel.font = [UIFont systemFontOfSize:19];
    self.currentDateLabel.textAlignment = NSTextAlignmentRight;
    self.currentDateLabel.text = [NSString stringWithFormat:@"%d年%d月",yearIndex,montnIndex];
    [yearAndMonthView addSubview:self.currentDateLabel];
    
    UIImageView  * arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.currentDateLabel.frame), (50 -10) / 2,15,10)];
    arrowImageView.image = [UIImage imageNamed:@"down_arrow"];
    // arrowImageView.backgroundColor = [UIColor grayColor];
    [yearAndMonthView addSubview:arrowImageView];
    [self.view addSubview:yearAndMonthView];
    
    UIControl  *control = [[UIControl alloc] initWithFrame:CGRectMake(0,0,yearAndMonthView.frame.size.width,yearAndMonthView.frame.size.height)];
    [control addTarget:self action:@selector(selectDateClick) forControlEvents:UIControlEventTouchUpInside];
    [yearAndMonthView addSubview:control];
    
    UIView  *lineView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(yearAndMonthView.frame), SCREEN_WIDTH,0.5)];
    lineView.backgroundColor = [UIColor  grayColor];
    lineView.alpha = 0.3;
    [self.view addSubview:lineView];
    
    CGFloat  horizontalMarigin  =  5;
    CGFloat  weekDayLabelWidth = (SCREEN_WIDTH - 2 * horizontalMarigin) / 7;
    NSArray  *weekDaytitleArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
    for(int i = 0;i <  weekDaytitleArray.count; i++)
    {
        UILabel  * label = [[UILabel alloc] initWithFrame:CGRectMake(i * weekDayLabelWidth +horizontalMarigin,CGRectGetMaxY(lineView.frame),weekDayLabelWidth,20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        if (i ==0 || i == weekDaytitleArray.count - 2) {
            label.textColor = [UIColor redColor];
        }
        else
        {
            label.textColor = [UIColor blackColor];
        }
        label.text = weekDaytitleArray[i];
        [self.view addSubview:label];
    }
    CGFloat  marginX = 5 ;
    CalendarView * calendarView = [[CalendarView alloc] initWithFrame:CGRectMake(marginX,CGRectGetMaxY(lineView.frame)+ 30,SCREEN_WIDTH - 2 * marginX, SCREEN_HEIGHT - NAVBARHEIGHT - 250) withDate:[NSDate date]];
    calendarView.backgroundColor = [UIColor whiteColor];
    calendarView.showDetailBlock= ^void(NSDictionary * dict)
    {
        [self showHintViewWithDictionary:dict];
    };
    WS(weakSelf);
    calendarView.swipeLeftBlock = ^ void(NSDate  * date)
    {
        [weakSelf swipeCalendarViewLeftWithDate:date];
    };
    calendarView.swipeRightBlock = ^void(NSDate  * date)
    {
        [weakSelf swipeCalendarViewRightWithDate:date];
    };
    myCalendarView = calendarView;
    [self.view addSubview:calendarView];
    
    UIView  *titleView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(calendarView.frame)+ 10,SCREEN_WIDTH,30)];
    titleView.backgroundColor = [UIColor whiteColor];
    UIImageView  * bellImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20,10,15,15)];
    bellImageView.image = [UIImage imageNamed:@"1a"];
    [titleView addSubview:bellImageView];
    UILabel  * homeworkLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(bellImageView.frame), 10,100,20)];
    homeworkLabel.text = @"功课提醒";
    homeworkLabel.font = [UIFont systemFontOfSize:15];
    [titleView addSubview:homeworkLabel];
    [self.view addSubview:titleView];
    
    
    AppDelegate  * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString  * huaienId = [delegate.accountBasicDict  objectForKey:@"huaienId"];
    
    UIView * earlyView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(titleView.frame),SCREEN_WIDTH,35)];
    earlyView1 = earlyView;
    earlyView.tag = 500;
    earlyView.backgroundColor = [UIColor lightGrayColor];
    self.earlyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,35)];
    self.earlyLabel.font = [UIFont systemFontOfSize:15];
#pragma mark  ------  先看之前有没有设置
    NSString  * earlyTimeStr = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",earlyHomeWorkTime,huaienId]];
    NSLog(@"earlyTimeStr---%@---",earlyTimeStr);
    if (earlyTimeStr != nil) {
        NSArray * strArray = [earlyTimeStr componentsSeparatedByString:@":"];
        self.earlyLabel.text  = [NSString stringWithFormat:@"    早功课  %@:%@",strArray[0],strArray[1]];
    }
    else
    {
        self.earlyLabel.text = [NSString stringWithFormat:@"    早功课  06:00"];
        //系统默认的早课时间
        [[NSUserDefaults standardUserDefaults] setObject:@"06:00:00" forKey:[NSString stringWithFormat:@"%@%@",earlyHomeWorkTime,huaienId]];
    }
    UIControl  * control1 = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, earlyView.frame.size.width, earlyView.frame.size.height)];
    [control1 addTarget:self action:@selector(control1Click) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:earlyView];
    [earlyView addSubview:self.earlyLabel];
    [earlyView addSubview:control1];
    //根据持久化数据来设置开关
    
    NSString  * hintKey1 = [NSString stringWithFormat:@"%@%@",earlyHomeWorkHint,huaienId];
    NSString  * hintKey2  = [NSString stringWithFormat:@"%@%@",lateHomeWorkHint,huaienId];
    
    UISwitch  * switch1 = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 60,(35 - 31) / 2,0,0)];
    mySwitch1 = switch1;
    switch1.tag = 400;
    NSNumber * switchNumber1 = [[NSUserDefaults standardUserDefaults] objectForKey:hintKey1];
    NSNumber * switchNumber2 = [[NSUserDefaults standardUserDefaults] objectForKey:hintKey2];
    NSInteger  switchNumberInteger1 = [switchNumber1 integerValue];
    NSInteger  switchNumberInteger2 = [switchNumber2 integerValue];
    switch1.on = switchNumberInteger1;
    
    [switch1 addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [earlyView addSubview:switch1];
    
    UIView * lateView  = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(earlyView.frame),SCREEN_WIDTH,35)];
    lateView1 = lateView;
    lateView.tag = 501;
    lateView.backgroundColor = [UIColor lightGrayColor];
    
    UIControl  * control2 = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, earlyView.frame.size.width, earlyView.frame.size.height)];
    [control2 addTarget:self action:@selector(control2Click) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:earlyView];
    
    self.lateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,35)];
    self.lateLabel.font = [UIFont systemFontOfSize:15];
#pragma mark
    NSString  * lateTimeStr = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",lateHomeWorkTime,huaienId]];
    NSLog(@"lateTimeStr---%@",lateTimeStr);
    if (lateTimeStr != nil) {
        NSArray * strArray = [lateTimeStr componentsSeparatedByString:@":"];
        self.lateLabel.text  = [NSString stringWithFormat:@"   晚功课  %@:%@",strArray[0],strArray[1]];
    }
    else
    {
        self.lateLabel.text = [NSString stringWithFormat:@"    晚功课  18:00"];
        //系统默认晚课时间
        [[NSUserDefaults standardUserDefaults] setObject:@"18:00:00" forKey:[NSString stringWithFormat:@"%@%@",lateHomeWorkTime,huaienId]];
    }
    [lateView addSubview:self.lateLabel];
    [lateView addSubview:control2];
    UISwitch   * switch2  = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60,(35 - 31) / 2,0,0)];
    mySwitch2 = switch2;
    switch2.tag = 401;
    switch2.on = switchNumberInteger2;
    [switch2 addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    //[self.view addSubview:self.lateLabel];
    [lateView addSubview:switch2];
    [self.view addSubview:lateView];
}
#pragma mark---弹出早课时间选择
-(void)control1Click
{
    if (!mySwitch1.isOn) return;
    self.earlyTimerPickerView.tag = 600;
    self.earlyDatePicker.date = [NSDate date];
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.earlyTimerPickerView];
}
#pragma mark ----弹出晚课时间选择
-(void)control2Click
{
    if (!mySwitch2.isOn) return;
    self.earlyTimerPickerView.tag = 601;
    self.earlyDatePicker.date = [NSDate date];
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.earlyTimerPickerView];
}
#pragma mark ---处理小开关 触发事件
-(void)switchValueChanged:(UISwitch  *) sw
{
    AppDelegate  * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString  * huaienId = [delegate.accountBasicDict  objectForKey:@"huaienId"];
    NSString  * hintKey1 = [NSString stringWithFormat:@"%@%@",earlyHomeWorkHint,huaienId];
    NSString  * hintKey2  = [NSString stringWithFormat:@"%@%@",lateHomeWorkHint,huaienId];
    if (sw.isOn) {
        if (sw.tag == 400) {
            earlyView1.backgroundColor = [UIColor lightGrayColor];
            [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:hintKey1];
        }
        else
        {
            lateView1.backgroundColor = [UIColor lightGrayColor];
            [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:hintKey2];
        }
    }
    else
    {
        if (sw.tag == 400) {
            earlyView1.backgroundColor = [UIColor whiteColor];
            earlyView1.alpha=0.5;
            [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:hintKey1];
        }
        else
        {
            lateView1.backgroundColor = [UIColor whiteColor];
            lateView1.alpha=0.5;
            [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:hintKey2];
        }
    }
    [delegate changeHomeWorkHint];
}
#pragma mark ---选择日期
-(void)selectDateClick
{
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.datePickerView];
}
#pragma mark ---导航栏
-(void)createNavBar
{
    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,NAVBARHEIGHT)];
    [navBar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forBarMetrics:UIBarMetricsDefault];
    UINavigationItem *titleItem = [[UINavigationItem alloc]initWithTitle:@"万年佛历"];
    NSDictionary *navTitleArr = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [UIFont boldSystemFontOfSize:20],UITextAttributeFont,
                                 [UIColor whiteColor],UITextAttributeTextColor ,nil];
    [navBar setTitleTextAttributes:navTitleArr];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake(20, 20,30, 25)];
    [leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [titleItem setLeftBarButtonItem:leftItem];
    [navBar pushNavigationItem:titleItem animated:NO];
    [self.view addSubview:navBar];
}
-(void)backBtnClick
{
    AppDelegate * delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.sideMenuViewController setContentViewController:delegate.mainVc    animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}
#pragma mark --- 当时间选择器 变化时的处罚事件
-(void)datePickerValueChanged:(UIDatePicker *) dp
{
    currentDate = dp.date;
}
#pragma mark ----右滑
-(void)swipeCalendarViewLeftWithDate:(NSDate *) date
{
    NSDateFormatter * formatter  = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.timeZone = [NSTimeZone localTimeZone];
    NSString * dateString  = [formatter stringFromDate:date];
    NSArray  *dateArray = [dateString componentsSeparatedByString:@"-"];
    NSString  * yearStr = dateArray[0];
    NSString  * monthStr = dateArray[1];
    yearIndex = [yearStr intValue];
    montnIndex = [monthStr intValue];
    self.currentDateLabel.text = [NSString stringWithFormat:@"%d年%d月",yearIndex,montnIndex];
    
    CGFloat  marginX = 5;
    CalendarView * calendarView = [[CalendarView alloc] initWithFrame:CGRectMake(marginX+SCREEN_WIDTH,myCalendarView.frame.origin.y,SCREEN_WIDTH - 2 * marginX, SCREEN_HEIGHT - NAVBARHEIGHT - 250) withDate:date];
    [self.view addSubview:calendarView];
    calendarView.backgroundColor = [UIColor whiteColor];
    calendarView.showDetailBlock= ^void(NSDictionary * dict)
    {
        [self showHintViewWithDictionary:dict];
    };
    WS(weakSelf);
    calendarView.swipeLeftBlock = ^ void(NSDate  * date)
    {
        [weakSelf swipeCalendarViewLeftWithDate:date];
    };
    calendarView.swipeRightBlock = ^void(NSDate  * date)
    {
        [weakSelf swipeCalendarViewRightWithDate:date];
    };
    [UIView animateWithDuration:0.5 animations:^{
        myCalendarView.frame = CGRectMake(-SCREEN_WIDTH + marginX, myCalendarView.frame.origin.y,SCREEN_WIDTH - 2 * marginX,SCREEN_HEIGHT - NAVBARHEIGHT - 250);
        calendarView.frame = CGRectMake(marginX,myCalendarView.frame.origin.y,SCREEN_WIDTH - 2 * marginX, SCREEN_HEIGHT - NAVBARHEIGHT - 250);
    } completion:^(BOOL finished) {
        myCalendarView = calendarView;
    }];
}
#pragma mark ----左滑
-(void)swipeCalendarViewRightWithDate:(NSDate *) date
{
    
    NSDateFormatter * formatter  = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.timeZone = [NSTimeZone localTimeZone];
    NSString * dateString  = [formatter stringFromDate:date];
    NSArray  *dateArray = [dateString componentsSeparatedByString:@"-"];
    NSString  * yearStr = dateArray[0];
    NSString  * monthStr = dateArray[1];
    yearIndex = [yearStr intValue];
    montnIndex = [monthStr intValue];
    self.currentDateLabel.text = [NSString stringWithFormat:@"%d年%d月",yearIndex,montnIndex];
    
    CGFloat  marginX = 5;
    CalendarView * calendarView = [[CalendarView alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH + marginX,myCalendarView.frame.origin.y,SCREEN_WIDTH - 2 * marginX, SCREEN_HEIGHT - NAVBARHEIGHT - 250) withDate:date];
    [self.view addSubview:calendarView];
    calendarView.backgroundColor = [UIColor whiteColor];
    calendarView.showDetailBlock= ^void(NSDictionary * dict)
    {
        [self showHintViewWithDictionary:dict];
    };
    WS(weakSelf);
    calendarView.swipeLeftBlock = ^ void(NSDate  * date)
    {
        [weakSelf swipeCalendarViewLeftWithDate:date];
    };
    calendarView.swipeRightBlock = ^void(NSDate  * date)
    {
        [weakSelf swipeCalendarViewRightWithDate:date];
    };
    [UIView animateWithDuration:0.5 animations:^{
        myCalendarView.frame = CGRectMake(SCREEN_WIDTH + marginX, myCalendarView.frame.origin.y,SCREEN_WIDTH - 2 * marginX,SCREEN_HEIGHT - NAVBARHEIGHT - 250);
        calendarView.frame = CGRectMake(marginX,myCalendarView.frame.origin.y,SCREEN_WIDTH - 2 * marginX, SCREEN_HEIGHT - NAVBARHEIGHT - 250);
    } completion:^(BOOL finished) {
        myCalendarView = calendarView;
    }];
}
@end
