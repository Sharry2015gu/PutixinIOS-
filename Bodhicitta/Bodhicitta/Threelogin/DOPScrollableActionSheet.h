//
//  ViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/5/5.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class DOPAction;

//DOPAction                 model
//DOPScrollableActionSheet  view and partial controller for showing and programmatical dismissing

//multi scrollable row actionsheet
//only for iPhone
@interface DOPScrollableActionSheet : UIView
/*
    actions = @[@"row title one",                   //with title
                @[action1, action2, action3, ...],
                @"row title two",                   //with title
                @[action4, action5],
                @"",                                //without title
                @[action6, action7],
                ...];
*/
- (instancetype)initWithActionArray:(NSArray *)actions;

//always show in a new window
- (void)show;
- (void)dismiss;
@end

#pragma mark - DOPAction interface
@interface DOPAction : NSObject

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *actionName;
@property (nonatomic, copy) void(^handler)(void);

- (instancetype)initWithName:(NSString *)name
                    iconName:(NSString *)iconName
                     handler:(void(^)(void))handler;

@end