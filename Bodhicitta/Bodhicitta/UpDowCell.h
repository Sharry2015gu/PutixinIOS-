//
//  UpDowCell.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/5/7.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#import "UpDowModel.h"

@interface UpDowCell : UITableViewCell{

    UILabel *InfoLabel;
    UpDowModel *cellData;
    UIView *backgroundView;

}

-(void)setData:(UpDowModel *)dicdata;

@end
