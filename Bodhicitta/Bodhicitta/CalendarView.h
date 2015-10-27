//
//  CalendarView.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/10/13.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarView : UIView
-(instancetype)initWithFrame:(CGRect)frame withDate:(NSDate *) date;
@property(nonatomic,strong)NSDate * date ;
@property(nonatomic,copy) void (^showDetailBlock)(NSDictionary  * dict);
-(void)reloadCalendarViewWith:(NSDate *) date;
//右滑
@property(nonatomic,copy) void(^swipeLeftBlock)(NSDate * date);
@property(nonatomic,copy) void(^swipeRightBlock)(NSDate * date);
@end
