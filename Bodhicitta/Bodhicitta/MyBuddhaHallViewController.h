//
//  MyBuddhaHallViewController.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/20.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempleImage.h"
#import "TempleVow.h"
#import "HomeWorkModel.h"
@interface MyBuddhaHallViewController : UIViewController{
    
    UIButton * rebackBtn;
    UILabel * retitleLabel;
    UIImageView * divinationImageView;
    UIScrollView * scrollImageView;
    UIImageView * explainImageView;
    UILabel * explainLabel;
    UILabel * explainConten;
    UIButton * startBtn;
    UIImageView * signImageView;
    UILabel * signNameLabel;
    UILabel * signpaperLabel;
    UILabel * contentLabel;
    UITextView * promptText;
    UIButton * againBt;
}
@property(nonatomic,assign) NSInteger  currentPage;
@property(nonatomic,assign) NSInteger  flagVowStyle;
@property(nonatomic,strong)NSMutableArray *MyBuddhaArray;
-(void)changeBuhhaImage:(TempleImage *) model withInfo:(NSDictionary *) jsonData;
@property(nonatomic,strong) MyBuddhaHallViewController *vc;
//用于表示是否是还愿时进行的献供
@property(nonatomic,assign) BOOL isVow;
@property(nonatomic,strong) TempleVow * vowModel;
@property(nonatomic,strong) HomeWorkModel * homeModel;
//-(void)getTempleImage;
//-(void)getWishInfo:(NSInteger)buddhistID;
-(void)getWishNum;
-(void)getTribute;
//还愿的时候需要用到敬茶 供花等
-(void)incenseBtnClick;
-(void)forteaBtnClick;
-(void)offerBtnClick;
-(void)forflowerBtnClick;
-(void)cliffordClick;
@end
