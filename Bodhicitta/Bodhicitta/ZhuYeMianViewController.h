//
//  ZhuYeMianViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/6.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZhuYeMianViewController : UITabBarController{
    UIButton *_button;
    

}
@property(nonatomic,strong) id up;
-(void)setPerson;
@property(nonatomic,strong)id lastViewController;
@property (nonatomic,strong)NSString *name;
@end
