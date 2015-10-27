//
//  Please_QFViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/20.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "GongJing_MainViewController.h"
#import "Tribute.h"
#import "QingFoView1.h"

@class button_fozu;


@protocol QingFoViewDelegate<NSObject>
-(void)takeAction:(NSString*) name takeImage:(UIImage *) image;
@end

@interface Please_QFViewController : UIViewController{
    
    UITableView * tableview;
    UIImageView * imageView;
    UIScrollView * scrollview;
    
    button_fozu * fozuImage1,*fozuImage2;
    UILabel *  fozuName1,* fozuName2;
    UILabel * yuyiLa1,* yuyiLa2;
    UIImageView * titleImage1,* titleImage2;
    UIImageView * qingfoNumImage;
    UILabel * numLa1,* numLa2;
    UIImageView * bgBt;
    UILabel * bgName;
    UIImageView * bgImage;
    UILabel * title;
    
    
    UIView *starHallView;
    
}
@property(nonatomic,strong)  MyBuddhaHallViewController *vc;
@property (retain, nonatomic) NSMutableArray *dataArray;

@property(nonatomic,strong) UIView *maskView;

@property(nonatomic,strong) id<QingFoViewDelegate> delegate;
@property(nonatomic,strong) id<UIApplicationDelegate> delegata;
@property(nonatomic,strong)Tribute *model;

-(void)getTempleList;

@end


@interface button_fozu : UIButton

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

