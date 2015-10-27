//
//  DuJingViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/2.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WisdomMathViewController.h"
#import "RESideMenu.h"
#import "HeaderFile.h"
@interface DuJingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView * tableview;
    UIButton * preservation;
    UIButton * remove;
    UITextField * nicheng;
}
-(void)getReadRankingIsResh:(BOOL)isfresh;


@end
