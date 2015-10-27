//
//  SearchViewCell.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/18.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WisdomModel.h"

@interface SearchViewCell : UITableViewCell

@property(nonatomic,strong) WisdomModel * wismodel;
-(void)setWisModel:(WisdomModel *)wismodel;

@end
