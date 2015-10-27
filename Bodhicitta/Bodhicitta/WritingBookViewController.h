//
//  WritingBookViewController.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/28.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectModel.h"
#import "EasyTimeline.h"
@interface WritingBookViewController : UIViewController<EasyTimelineDelegate>
{
    EasyTimeline *_timeline;
    int now;
    int second;
    int minute;
}
@property(nonatomic,strong) CollectModel *model;
-(void)downLoadBookData:(CollectModel *) model1 WithUrl:(NSString *) downloadURL IsReading:(BOOL)isReading;
@end
