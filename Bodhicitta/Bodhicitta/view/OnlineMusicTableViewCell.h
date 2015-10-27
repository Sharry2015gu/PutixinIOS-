//
//  OnlineMusicTableViewCell.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/10/6.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WisdomModel.h"
@interface OnlineMusicTableViewCell : UITableViewCell
@property(nonatomic,strong)NSMutableDictionary *musicInfoDictionary;
@property(nonatomic,copy)void (^block)(WisdomModel * model);
@property(nonatomic,copy)void (^hintBlock)(WisdomModel * model);
-(void)setMusicInfoDictionary:(NSMutableDictionary *)musicInfoDictionary;
@property(nonatomic,strong)UIButton * downButton;
@property(nonatomic,strong)UILabel  * downLoadingLabel;
@end
