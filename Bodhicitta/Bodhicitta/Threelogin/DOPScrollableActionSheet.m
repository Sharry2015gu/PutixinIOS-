//
//  ViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/5/5.
//  Copyright (c) 2015年 怀恩2. All rights reserved.//

#import "DOPScrollableActionSheet.h"

static CGFloat horizontalMargin = 50.0;

@interface DOPScrollableActionSheet ()

@property (nonatomic, assign) CGRect         screenRect;
@property (nonatomic, strong) UIWindow       *window;
@property (nonatomic, strong) UIView         *dimBackground;
@property (nonatomic, copy  ) NSArray        *actions;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *handlers;
@property (nonatomic, copy) void(^dismissHandler)(void);

@end

@implementation DOPScrollableActionSheet

- (instancetype)initWithActionArray:(NSArray *)actions {
    self = [super init];
    if (self) {
        _screenRect = [UIScreen mainScreen].bounds;
        if ([[UIDevice currentDevice].systemVersion floatValue] < 7.5 &&
            UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            _screenRect = CGRectMake(0, 0, _screenRect.size.height, _screenRect.size.width);
        }
        _actions = actions;
        _buttons = [NSMutableArray array];
        _handlers = [NSMutableArray array];
        _dimBackground = [[UIView alloc] initWithFrame:_screenRect];
        _dimBackground.backgroundColor = [UIColor lightGrayColor];
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_dimBackground addGestureRecognizer:gr];
        self.backgroundColor = [UIColor whiteColor];
    
        NSInteger rowCount = _actions.count;
    
        /*calculate action sheet frame begin*/
        //row title screenwidth*40 without row title margin screenwidth*20
        //60*60 icon 60*30 icon name
        CGFloat height = 0.0;
        for (int i = 0; i < rowCount; i++) {
            if ([_actions[i] isKindOfClass:[NSString class]]) {
                if ([_actions[i] isEqualToString:@""]) {
                    height += 20;
                } else {
                    height += 40;
                }
            } else {
                height = height+60+30;
            }
        }
        //cancel button screenwidth*60
        height += 60;
        /*calculation end*/
        self.frame = CGRectMake(0, _screenRect.size.height, _screenRect.size.width, height);
        
        //add each row
        CGFloat y = 0.0;
        for (int i = 0; i < rowCount; i++) {
            if ([_actions[i] isKindOfClass:[NSString class]]) {
                //title
                if ([_actions[i] isEqualToString:@""]) {
                    UIView *marginView = [[UIView alloc] initWithFrame:CGRectMake(0, y, _screenRect.size.width, 25.0)];
                    [self addSubview:marginView];
                    y+=20;
                } else {
                    UILabel *rowTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, y, _screenRect.size.width, 45.0)];
                    rowTitle.font = [UIFont systemFontOfSize:14.0];
                    rowTitle.text = _actions[i];
                    rowTitle.textAlignment = NSTextAlignmentCenter;
                    [self addSubview:rowTitle];
                    y+=40;
                }
            } else {
                NSArray *items = _actions[i];
                //图片
                CGFloat x = horizontalMargin;
                for (int j = 0; j < items.count; j++) {
                    DOPAction *action = items[j];
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame = CGRectMake(x, 20, 50, 50);
                    [button setImage:[UIImage imageNamed:action.iconName] forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(handlePress:) forControlEvents:UIControlEventTouchUpInside];
                    [self addSubview:button];
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 75, 50, 20)];
                    label.textColor=[UIColor lightGrayColor];
                    label.text = action.actionName;
                    label.font = [UIFont systemFontOfSize:12.0];
                    label.textAlignment = NSTextAlignmentCenter;
                    [self addSubview:label];
                    x = x + 60 + horizontalMargin;
                    
                    [_buttons addObject:button];
                    [_handlers addObject:action.handler];
                }
                y+=90;
                UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, y, _screenRect.size.width,0.5)];
                separator.backgroundColor = [UIColor lightGrayColor];
                [self addSubview:separator];
            }
        }
        
        UIButton *cancel = [UIButton buttonWithType:UIButtonTypeSystem];
        cancel.frame = CGRectMake(0, y, _screenRect.size.width, 60);
        [cancel setTitle:NSLocalizedString(@"取消", @"cancel button name") forState:UIControlStateNormal];
        [cancel setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        cancel.titleLabel.font = [UIFont systemFontOfSize:20];
        cancel.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];;
        [self addSubview:cancel];
        [cancel addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        
//        UIImageView * iv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cellLine@2x.png"]];
//        iv.frame=CGRectMake(0, y, _screenRect.size.width, 1);
//        [self addSubview:iv];

    }
    
    return self;
}

- (void)handlePress:(UIButton *)button {
    NSInteger index = [self.buttons indexOfObject:button];
    if (index != self.buttons.count-1) {
        void(^handler)(void) = self.handlers[index];
        handler();
    }
    [self dismiss];
}

- (void)show {
    self.window = [[UIWindow alloc] initWithFrame:self.screenRect];
    self.window.windowLevel = UIWindowLevelAlert;
    self.window.backgroundColor = [UIColor clearColor];
    self.window.rootViewController = [UIViewController new];
    self.window.rootViewController.view.backgroundColor = [UIColor clearColor];
    
    [self.window.rootViewController.view addSubview:self.dimBackground];
    
    [self.window.rootViewController.view addSubview:self];
    
    self.window.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.dimBackground.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        self.frame = CGRectMake(0, self.screenRect.size.height-self.frame.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        //
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.dimBackground.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, self.screenRect.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        self.window = nil;
    }];
}

@end

@implementation DOPAction

- (instancetype)initWithName:(NSString *)name iconName:(NSString *)iconName handler:(void(^)(void))handler {
    self = [super init];
    if (self) {
        _actionName = name;
        _iconName = iconName;
        _handler = handler;
    }
    return self;
}

@end
