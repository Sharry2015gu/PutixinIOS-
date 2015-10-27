//
//  MakingVowView.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/9/17.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakingVowView : UIView
@property(nonatomic,copy)void (^deleteBlock)();
@property(nonatomic,copy)void (^submitBlock)(NSString * name,NSString *vowString,NSInteger  type);
@end
