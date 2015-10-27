//
//  MusicTableViewCell.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/9/2.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WisdomModel.h"
@interface MusicTableViewCell : UITableViewCell
@property(nonatomic,strong)UIButton *downButton;
@property(nonatomic,copy) void(^block)(NSMutableDictionary * dict);
//用于音乐播放
-(void)setMusicPlayDict:(NSMutableDictionary  *) dict;
@end
