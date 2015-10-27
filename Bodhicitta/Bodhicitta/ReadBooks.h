//
//  ReadBooks.h
//  BookShelf
//
//  Created by mac on 12-9-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "ShuJia_MyViewController.h"


@interface ReadBooks : UIViewController<UITextViewDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
@private
    UITextView * textView;
    int currentPage;
    int allPage;
    UIButton * button4 ;
    UIButton * fanhuiBt;
    UIButton * fenxiangBt;
    UINavigationBar * bar;
    UIImageView * bgImage;
    UILabel * time_bcLa,* time_bcText;
    UILabel * time_jrLa,* time_jrText;
    UILabel * time_ljLa,* time_ljText;
}
@property (nonatomic ,retain) NSString* str;


-(void)downPage;


-(void)upPage;

@end
