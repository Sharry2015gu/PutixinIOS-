//
//  TouXiang_SCViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/9.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "TouXiang_GXViewController.h"
#import "ShanYou_DTViewController.h"

@interface TouXiang_SCViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{

    UIButton * fanhuiBt;
    UIButton * tijiaoBt;
    UIButton * shangchuanBt;
    UIImageView * touxiangIv;
}

@end
