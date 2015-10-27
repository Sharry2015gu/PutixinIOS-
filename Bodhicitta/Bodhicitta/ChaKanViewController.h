//
//  ChaKanViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/10.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "ZhuYeMianViewController.h"
//#import "TouXiang_GXViewController.h"

@interface ChaKanViewController : UISearchController<UISearchBarDelegate>{
    
    UIButton * fanhuiBt;
    UIButton * touxiangButton;
    UILabel * accutLa;
    
    UISearchBar * searchBt;
}

@end
