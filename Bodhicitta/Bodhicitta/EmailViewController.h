//
//  EmailViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/5/11.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownSheet.h"
#import "ILBarButtonItem.h"
#import "UserLoginViewController.h"
#import "FangShiViewController.h"
@interface EmailViewController : UIViewController<DownSheetDelegate>{

               UITextField * emailtext;
               UIButton * nextstepbt;
    
               UITableView *_tableView;
    
               NSArray *MenuList;
    
    UIButton * backbt;
    
    UITextField * nametext;
    UITextField * yanzhengtext;
    UITextField * passwork;
    UIButton * huan;
    UIButton * sure;
    UILabel * nameiv;
    UILabel * yaniv;
    UILabel * pass;
    UIButton * quxiao;


}

@end
