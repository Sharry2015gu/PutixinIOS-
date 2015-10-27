//
//  ShouCangViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/18.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShouCangModel.h"
@interface ShouCangViewController : UITableViewController

+(instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)ShouCangModel *cellModel;

@end
