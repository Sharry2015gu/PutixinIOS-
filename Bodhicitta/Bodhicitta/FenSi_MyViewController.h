//
//  FenSi_MyViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/13.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FenSi_MyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

         UITableView * tableview;
         NSDictionary *dictionary;
         NSArray *list;
    
    UIButton * _deleteButton;
    NSIndexPath * _editingIndexPath;

}

@end
