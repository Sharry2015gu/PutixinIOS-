//
//  BookView.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/27.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectModel.h"
@interface BookView : UIView
@property(nonatomic,assign)BOOL isDelete;
@property(nonatomic,copy) void(^deleteBlock)(CollectModel *model);
@property(nonatomic,strong)CollectModel *model;
@property(nonatomic,copy) void(^selectBlock)(CollectModel *model);
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)void (^addBlock)();
@end
