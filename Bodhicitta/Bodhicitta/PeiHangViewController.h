//
//  PeiHangViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/23.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "JingXinViewController.h"

@interface PeiHangViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    UITableView * tableview;
    
    
    UILabel * nameView;
    UILabel *  cishuView;
    UILabel * mingciView;
    UIImageView * mimngciImage;
    
}
-(void)getMeditionRankInfo;
@end
