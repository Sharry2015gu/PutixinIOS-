//
//  CollectModel.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/27.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectModel : NSObject
@property(nonatomic,assign)NSInteger collectID;
@property(nonatomic,assign)NSInteger objectID;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *downloadUrl_r;
@property(nonatomic,strong)NSString *downloadUrl_w;
@end
