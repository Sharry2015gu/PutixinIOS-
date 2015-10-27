//
//  CalendarView.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/10/13.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "CalendarView.h"
#import "HeaderFile.h"
@interface  CalendarView()
{
    //用于排位置
    int calendarViewX;
    int calendarViewY;
    NSDate  * firstDate;
    NSDate  * lastDate;
}
@property(nonatomic,strong)NSMutableArray * dictArray;
@property(nonatomic,strong)NSMutableDictionary  * locationDict;
@end
@implementation CalendarView
-(NSMutableArray *) dictArray
{
    if (_dictArray == nil) {
        _dictArray  = [[NSMutableArray alloc]init];
    }
    return _dictArray;
}
-(NSMutableDictionary *)locationDict
{
    if (_locationDict == nil) {
        _locationDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    }
    return _locationDict;
}
-(instancetype)initWithFrame:(CGRect)frame withDate:(NSDate *) date
{
    self = [super initWithFrame:frame];
    if (self) {
        //        NSTimeZone  *  zone = [NSTimeZone systemTimeZone];
        //        NSInteger  interval = [zone secondsFromGMTForDate:date];
        //        self.date = [date dateByAddingTimeInterval:interval *  100];
        calendarViewX = 0 ;
        calendarViewY = 0 ;
        self.date = date;
        [self createSubViews];
    }
    return self;
}
#pragma mark ---所有数据准备好后 开始创建日历视图
-(void)createSubViews
{
    
    [self calculateDayDetailInfo];
    CGFloat  width = self.frame.size.width  /  7;
    //以50的为标准
    CGFloat  height  = self.frame.size.height / 6;
    for(int i = 0 ; i < self.dictArray.count ; i++)
    {
        int  rank  =  i  / 7;
        int  column  =  i % 7;
        UIView   * view = [[UIView alloc] initWithFrame:CGRectMake(column * width,rank * height,width, height)];
        view.tag =  200 + i;
        NSDictionary  * detailDict = [self.dictArray objectAtIndex:i];
        NSLog(@"具体信息字典%@",detailDict);
        NSDate  * date = [detailDict objectForKey:@"solarDate"];
        NSDateFormatter  *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        formatter.timeZone = [NSTimeZone localTimeZone];
        NSString   *dateString  = [formatter stringFromDate:date];
        NSString  *dayString = [dateString componentsSeparatedByString:@"-"][2];
        NSString  * lunarString = [detailDict  objectForKey:@"lunarDate"];
        NSString  * buddhaDetail =  [detailDict objectForKey:@"buddhaDetail"];
        
        UILabel * solarCalendarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,view.frame.size.width,0.666 *height)];
        solarCalendarLabel.tag = 100;
        solarCalendarLabel.text = dayString;
        solarCalendarLabel.font = [UIFont  boldSystemFontOfSize:15];
        solarCalendarLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:solarCalendarLabel];
        
        UILabel  * lunarCalendarLabel  = [[UILabel alloc] initWithFrame:CGRectMake(0,solarCalendarLabel.frame.size.height,view.frame.size.width,0.333* height)];
        lunarCalendarLabel.tag = 101;
        lunarCalendarLabel.font = [UIFont systemFontOfSize:12];
        lunarCalendarLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:lunarCalendarLabel];
        if (column == 0 || column == 6) {
            lunarCalendarLabel.textColor = [UIColor redColor];
            solarCalendarLabel.textColor = [UIColor redColor];
        }
        if ([buddhaDetail isEqualToString:@""]) {
            NSString * lunarDayStr = [lunarString componentsSeparatedByString:@" "][1];
            if ([lunarDayStr isEqualToString:@"初一"]) {
                lunarCalendarLabel.text = [lunarString componentsSeparatedByString:@" "][0];
            }
            else
            {
                lunarCalendarLabel.text = [lunarString componentsSeparatedByString:@" "][1];
            }
        }
        else
        {
            lunarCalendarLabel.text = buddhaDetail;
        }
        NSString * todayDateString = [formatter stringFromDate:[NSDate date]];
        if ([dateString  isEqualToString:todayDateString]) {
            view.backgroundColor = majorityColor;
            lunarCalendarLabel.textColor = [UIColor whiteColor];
            solarCalendarLabel.textColor = [UIColor whiteColor];
        }
        NSNumber * alphaNumber = [detailDict objectForKey:@"alpha"];
        NSInteger  alphaInteger = [alphaNumber integerValue];
        if (alphaInteger == 0) {
            lunarCalendarLabel.alpha = 0.3;
            solarCalendarLabel.alpha = 0.3;
        }
        [self addSubview:view];
        UIControl  * touchControl = [[UIControl alloc] initWithFrame:CGRectMake(0,0,view.frame.size.width,view.frame.size.height)];
        touchControl.tag = 300 + i ;
        [touchControl addTarget:self action:@selector(touchControlClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:touchControl];
        UISwipeGestureRecognizer  *   swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight:)];
        swipeRight.numberOfTouchesRequired  = 1;
        swipeRight.direction  = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipeRight];
        
        UISwipeGestureRecognizer  * swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
        swipeLeft.numberOfTouchesRequired = 1;
        swipeLeft.direction  = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipeLeft];
    }
}
#pragma mark ----右滑
-(void)swipeRight:(UISwipeGestureRecognizer *) ges
{
    self.swipeRightBlock(firstDate);
}
#pragma mark ---- 左滑
-(void)swipeLeft:(UISwipeGestureRecognizer *) ges
{
    self.swipeLeftBlock(lastDate);
}
-(void)touchControlClick:(UIControl *) control
{
    NSInteger viewIndex = control.tag - 300 ;
    UIView  * view = [self viewWithTag:viewIndex + 200];
    UILabel  * solarLabel = (UILabel *)[view viewWithTag:100];
    UILabel  * lunarLabel = (UILabel *)[view viewWithTag:101];
    NSDictionary * dict = @{@"solarDay":solarLabel.text,@"lunarDay":lunarLabel.text};
    self.showDetailBlock(dict);
}
#pragma mark ---计算42的排列中的信息
-(void)calculateDayDetailInfo
{
    NSLog(@"本月的第一天日期%@",[self firstDayOfCurrentMonth]);
    NSDate  * lastMonthDay  = [NSDate dateWithTimeInterval:-24 *  60 * 60 sinceDate:[self firstDayOfCurrentMonth]];
    firstDate = lastMonthDay;
    NSInteger lastMonthDayNumber =  [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:lastMonthDay].length;
    //通过这个月的第一天是星期几判断
    NSInteger weeklyOrdinalityNumber = [self weeklyOrdinality];
    //把上一个月的残余信息放入数组
    
    for(int i = 0 ; i < weeklyOrdinalityNumber - 1; i++)
    {
        NSDictionary  * detailDict;
        //与当月第一天差的时间
        NSInteger seperatorNumber =  weeklyOrdinalityNumber - i-2;
        //此时的日期
        NSDate *  currentDate = [NSDate dateWithTimeInterval: -24 * 60* 60 * seperatorNumber  sinceDate:lastMonthDay];
        NSString * lunarDateString = [self returnDetailStringAboutBuddhistWithLunarString:[self LunarForSolar:currentDate]];
        if (lunarDateString != nil) {
            detailDict = @{@"solarDate":currentDate,@"lunarDate":[self LunarForSolar:currentDate],@"buddhaDetail":lunarDateString,@"alpha":@0};
        }
        else
        {
            detailDict = @{@"solarDate":currentDate,@"lunarDate":[self LunarForSolar:currentDate],@"buddhaDetail":@"",@"alpha":@0};
        }
        [self.dictArray addObject:detailDict];
    }
    //本月的第一天
    
    //把当月的信息放入数组中
    for(int i = 0 ; i <  [self numberOfDaysIncurrentMonth]; i++)
    {
        NSDictionary  * detailDict;
        NSDate  * currentDate  = [NSDate  dateWithTimeInterval:24 *  60 * 60 * i  sinceDate:[self firstDayOfCurrentMonth]];
        NSString * lunarDateString  = [self returnDetailStringAboutBuddhistWithLunarString:[self LunarForSolar:currentDate]];
        if (lunarDateString != nil) {
            detailDict = @{@"solarDate":currentDate,@"lunarDate":[self LunarForSolar:currentDate],@"buddhaDetail":lunarDateString,@"alpha":@1};
        }
        else
        {
            detailDict = @{@"solarDate":currentDate,@"lunarDate":[self LunarForSolar:currentDate],@"buddhaDetail":@"",@"alpha":@1};
        }
        [self.dictArray addObject:detailDict];
    }
    if (self.dictArray.count == 42) {
    }
    else
    {
        //开始计算下个月的
        NSInteger  nextMonthDayNumber = 42 - self.dictArray.count;
        NSDate * currentMonthLastDate =  [NSDate dateWithTimeInterval:24 * 60 * 60 * ([self numberOfDaysIncurrentMonth]) sinceDate:[self firstDayOfCurrentMonth]];
        NSLog(@"本月的最后一天%@",currentMonthLastDate);
        lastDate = [NSDate  dateWithTimeInterval:24 * 60 * 60 sinceDate:currentMonthLastDate];
        for(int i = 0 ; i < nextMonthDayNumber; i++)
        {
            NSDictionary * detailDict;
            NSDate  *currentDate = [NSDate dateWithTimeInterval:24 * 60  * 60 *i  sinceDate:currentMonthLastDate];
            NSString * lunarDateString  = [self returnDetailStringAboutBuddhistWithLunarString:[self LunarForSolar:currentDate]];
            if (lunarDateString !=  nil ) {
                detailDict = @{@"solarDate":currentDate,@"lunarDate":[self LunarForSolar:currentDate],@"buddhaDetail":lunarDateString,@"alpha":@0};
            }
            else
            {
                detailDict = @{@"solarDate":currentDate,@"lunarDate":[self LunarForSolar:currentDate],@"buddhaDetail":@"",@"alpha":@0};            }
            [self.dictArray addObject:detailDict];
        }
    }
}
#pragma mark --- 算出一个月有多少天
-(NSUInteger)numberOfDaysIncurrentMonth
{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self.date].length;
}
#pragma mark --- 确定这个月
-(NSDate *) firstDayOfCurrentMonth
{
    NSDate  * startDate  = nil;
    BOOL  ok  = [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit startDate:&startDate interval:NULL forDate:
                 self.date];
    return startDate;
}
-(NSUInteger)weeklyOrdinality
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:[self firstDayOfCurrentMonth]];
}
#pragma mark  ---根据日期算出农历信息
-(NSString *)LunarForSolar:(NSDate *)solarDate{
    //天干名称
    NSArray *cTianGan = [NSArray arrayWithObjects:@"甲",@"乙",@"丙",@"丁",@"戊",@"己",@"庚",@"辛",@"壬",@"癸", nil];
    
    //地支名称
    NSArray *cDiZhi = [NSArray arrayWithObjects:@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",nil];
    
    //属相名称
    NSArray *cShuXiang = [NSArray arrayWithObjects:@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"猴",@"鸡",@"狗",@"猪",nil];
    
    //农历日期名
    NSArray *cDayName = [NSArray arrayWithObjects:@"*",@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",
                         @"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",
                         @"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十",nil];
    
    //农历月份名
    NSArray *cMonName = [NSArray arrayWithObjects:@"*",@"正",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"腊",nil];
    
    //公历每月前面的天数
    const int wMonthAdd[12] = {0,31,59,90,120,151,181,212,243,273,304,334};
    
    //农历数据
    const int wNongliData[100] = {2635,333387,1701,1748,267701,694,2391,133423,1175,396438
        ,3402,3749,331177,1453,694,201326,2350,465197,3221,3402
        ,400202,2901,1386,267611,605,2349,137515,2709,464533,1738
        ,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762
        ,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413
        ,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395
        ,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031
        ,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222
        ,268949,3402,3493,133973,1386,464219,605,2349,334123,2709
        ,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877};
    
    static int wCurYear,wCurMonth,wCurDay;
    static int nTheDate,nIsEnd,m,k,n,i,nBit;
    
    //取当前公历年、月、日
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:solarDate];
    wCurYear = [components year];
    wCurMonth = [components month];
    wCurDay = [components day];
    
    //计算到初始时间1921年2月8日的天数：1921-2-8(正月初一)
    nTheDate = (wCurYear - 1921) * 365 + (wCurYear - 1921) / 4 + wCurDay + wMonthAdd[wCurMonth - 1] - 38;
    if((!(wCurYear % 4)) && (wCurMonth > 2))
        nTheDate = nTheDate + 1;
    
    //计算农历天干、地支、月、日
    nIsEnd = 0;
    m = 0;
    while(nIsEnd != 1)
    {
        if(wNongliData[m] < 4095)
            k = 11;
        else
            k = 12;
        n = k;
        while(n>=0)
        {
            //获取wNongliData(m)的第n个二进制位的值
            nBit = wNongliData[m];
            for(i=1;i<n+1;i++)
                nBit = nBit/2;
            
            nBit = nBit % 2;
            
            if (nTheDate <= (29 + nBit))
            {
                nIsEnd = 1;
                break;
            }
            
            nTheDate = nTheDate - 29 - nBit;
            n = n - 1;
        }
        if(nIsEnd)
            break;
        m = m + 1;
    }
    wCurYear = 1921 + m;
    wCurMonth = k - n + 1;
    wCurDay = nTheDate;
    if (k == 12)
    {
        if (wCurMonth == wNongliData[m] / 65536 + 1)
            wCurMonth = 1 - wCurMonth;
        else if (wCurMonth > wNongliData[m] / 65536 + 1)
            wCurMonth = wCurMonth - 1;
    }
    
    //生成农历天干、地支、属相
    NSString *szShuXiang = (NSString *)[cShuXiang objectAtIndex:((wCurYear - 4) % 60) % 12];
    NSString *szNongli = [NSString stringWithFormat:@"%@(%@%@)年",szShuXiang, (NSString *)[cTianGan objectAtIndex:((wCurYear - 4) % 60) % 10],(NSString *)[cDiZhi objectAtIndex:((wCurYear - 4) % 60) % 12]];
    
    //生成农历月、日
    NSString *szNongliDay;
    if (wCurMonth < 1){
        szNongliDay = [NSString stringWithFormat:@"闰%@",(NSString *)[cMonName objectAtIndex:-1 * wCurMonth]];
    }
    else{
        szNongliDay = (NSString *)[cMonName objectAtIndex:wCurMonth];
    }
    
    NSString *lunarDate = [NSString stringWithFormat:@"%@月 %@",szNongliDay,(NSString *)[cDayName objectAtIndex:wCurDay]];
    
    return lunarDate;
}
//@"2009-09-15 18:30:00";
#pragma mark  ---字符串与时间之间转换
-(NSDate *)returnNSDateWithString:(NSString *)dataString
{
    NSDateFormatter  * df  = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-DD HH:mm:ss"];
    NSLocale   *local  = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [df setLocale:local];
    NSDate  * myDate = [df dateFromString:dataString];
    return myDate;
}
#pragma mark  ---关于佛历描述
-(NSString *)returnDetailStringAboutBuddhistWithLunarString:(NSString*)luanarString
{
    NSDictionary *  buddhaDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"春节", @"正月 初一",
                                  @"定光佛圣诞",@"正月 初六",
                                  @"元宵", @"正月 十五",
                                  @"释迦牟尼佛出家",@"二月 初八",
                                  @"释迦牟尼佛涅盘",@"二月 十五",
                                  @"观世音菩萨圣诞",@"二月 十九",
                                  @"普贤菩萨圣诞",@"二月 廿一",
                                  @"准提菩萨圣诞",@"三月 十六",
                                  @"文殊菩萨圣诞",@"四月 初四",
                                  @"释迦牟尼佛圣诞 ",@"四月 初八",
                                  @"端午", @"五月 初五",
                                  @"伽蓝菩萨圣诞",@"五月 十三",
                                  @"护法韦驮尊天菩萨圣诞",@"六月 初三",
                                  @"观世音菩萨成道",@"六月 十九",
                                  @"七夕", @"七月 初七",
                                  @"大势至菩萨圣诞 ",@"七月 十三",
                                  @"中元", @"七月 十五",
                                  @"龙树菩萨圣诞",@"七月 廿四",
                                  @"地藏菩萨圣诞",@"七月 三十",
                                  @"中秋", @"八月 十五",
                                  @"燃灯佛圣诞",@"八月 廿二",
                                  @"重阳", @"九月 初九",
                                  @"观世音菩萨出家纪念日",@"九月 十九",
                                  @"药师琉璃光如来圣诞",@"九月 三十",
                                  @"达摩祖师圣诞",@"十月 初五",
                                  @"阿弥陀佛圣诞",@"十一月 十七",
                                  @"腊八", @"腊月 初八",
                                  @"释迦如来成道日", @"腊月 十七",
                                  @"小年", @"腊月 廿四",
                                  @"华严菩萨圣诞", @"腊月 廿九",
                                  @"除夕", @"腊月 三十",
                                  nil];
    return [buddhaDict objectForKey:luanarString];
}
-(void)reloadCalendarViewWith:(NSDate *) date
{
    for(UIView * subViews in self.subviews)
    {
        [subViews removeFromSuperview];
    }
    self.date = date;
    [self createSubViews];   
}
@end
