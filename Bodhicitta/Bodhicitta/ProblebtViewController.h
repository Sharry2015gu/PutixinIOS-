//
//  ProblebtViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/5/5.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownSheet.h"


@interface ProblebtViewController : UIViewController<DownSheetDelegate>{

    UITextField * megtext;
    UIButton * nextstepbt;
    
    UITableView *_tableView;

    NSArray *MenuList;

}

@end
