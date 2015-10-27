//
//  BgImagViewCollectionViewCell.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/9/15.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BgImageModel.h"
@interface BgImagViewCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIButton     *selectBtn;
@property(nonatomic,strong)BgImageModel  * model;
@property(nonatomic,copy) void  (^block)(UIImage * image);
@end
