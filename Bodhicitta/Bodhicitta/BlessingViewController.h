//
//  BlessingViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/3.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QiFo_MainViewController.h"
#import "RESideMenu.h"
#import "ZhuYeMianViewController.h"

//传值
@class BlessingViewController;

@protocol BlessingviewDelegate <NSObject>

-(void)passValue:(BlessingViewController *)value;

@end

@class button_fozu1;

@protocol BlessingDelegate <NSObject>

- (void)setValue:(NSString *)value;

@end

@interface BlessingViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>{


    UIImageView * bgImage;
    UIScrollView * scrollview;
    UITableView * tableview;
    button_fozu1 * fozuImage1,*fozuImage2;
    
    UILabel * fozuName1,* fozuName2;
    UIImageView * huoImage;
    UILabel * numLa1,* numLa2;
    UIImageView * bgBt,*bg1;
}


@property(nonatomic,strong) NSMutableArray * dateArray;
@property(nonatomic,strong) id<BlessingDelegate>delegate;



@end


@interface button_fozu1 : UIButton

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

