//
//  MusicOnlineViewController.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/10/6.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MusicOnlineViewController : UIViewController
-(void)getBookShelfInfoWithCategory:(NSInteger) category isRefresh:(BOOL) isRefresh;
@property(nonatomic,assign)void (^downBlock)(NSString  * name);
@property(retain, nonatomic) NSIndexPath *selectIndex;

@end
