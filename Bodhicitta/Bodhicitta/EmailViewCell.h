//
//  EmailViewCell.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/9/8.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewModel.h"

@interface EmailViewCell : UITableViewCell

@property(nonatomic,strong) NewModel * newmodel;
-(void)setnewModel:(NewModel *)newmodel ;
@property(nonatomic,strong)UILabel * contenLabel;
@end
