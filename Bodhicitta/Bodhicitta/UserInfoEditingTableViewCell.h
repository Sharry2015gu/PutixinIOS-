//
//  UserInfoEditingTableViewCell.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/9/11.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoEditingTableViewCell : UITableViewCell
@property(nonatomic,strong)UITextField  * filed;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *hintString;
@property(nonatomic,copy)void (^block)();
@property(nonatomic,assign)BOOL isHintLabelShow;
@end