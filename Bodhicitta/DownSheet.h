//
//  ViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/5/5.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpDowCell.h"
@protocol DownSheetDelegate <NSObject>
@optional
-(void)didSelectIndex:(NSInteger)index;
@end

@interface DownSheet : UIView<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{
    UITableView *view;
    NSArray *listData;
}
-(id)initWithlist:(NSArray *)list height:(CGFloat)height;
- (void)showInView:(UIViewController *)Sview;
@property(nonatomic,assign) id <DownSheetDelegate> delegate;
@end


