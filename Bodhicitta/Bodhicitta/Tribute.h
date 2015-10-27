//
//  Tribute.h
//  MemoryWebApp
//
//  Created by 怀恩03 on 15/7/13.
//  Copyright (c) 2015年 怀恩03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tribute : NSObject
@property(nonatomic,strong) NSString *CreateBy;
@property(nonatomic,strong) NSDate *CreateDate;
@property(nonatomic,assign) NSInteger Id;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *QianChengB;
@property(nonatomic,strong) NSString *ShouMing;
@property(nonatomic,strong) NSString *Type;
@property(nonatomic,strong) NSString *TypeChlid;
@property(nonatomic,strong) NSString *guangPath;
@property(nonatomic,strong) NSString *menuUrl;
@property(nonatomic,assign) NSInteger time;
@property(nonatomic,strong) NSString *yuanPath;
@end
