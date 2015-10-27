//
//  BuddhaCollectionViewCell.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/11.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempleImage.h"
#import "HeaderFile.h"
@interface BuddhaCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView  *frameWorkImageView;
@property(nonatomic,strong)TempleImage *model;
@property(nonatomic,copy) void (^selectBlock)(TempleImage *,UIImageView *,UIImageView *,UILabel*);
-(void)setModel:(TempleImage *)model;
@end

