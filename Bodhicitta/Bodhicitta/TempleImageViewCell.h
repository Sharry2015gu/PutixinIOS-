//
//  TempleImageViewCell.h
//  Bodhicitta
//
//  Created by 怀恩11 on 15/8/11.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempleImage.h"
@interface TempleImageViewCell : UICollectionViewCell
@property(nonatomic,strong)TempleImage *model;
- (void)setModel:(TempleImage *)model;
@end
