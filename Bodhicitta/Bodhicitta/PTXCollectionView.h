//
//  PTXCollectionView.h
//  Bodhicitta
//
//  Created by 怀恩11 on 15/8/11.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTXCollectionView;
@protocol PTXCollectionViewDelegate <NSObject>
//返回多少个cell
- (NSInteger)ptxCollectionView :(PTXCollectionView *)ptxCollectionView  numberOfCellsInSection:(NSInteger)section;
//cell上面的显示
- (void)ptxCollectionView :(PTXCollectionView *)ptxCollectionView  configCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
//点击cell的事件
- (void)ptxCollectionView :(PTXCollectionView *)ptxCollectionView didSelectCellAtIndexPath:(NSIndexPath *)indexPath;

@optional
//是否有更多的数据
- (BOOL)ptxCollectionViewHasMoreData:(PTXCollectionView *)ptxCollectionView ;
//是否正在加载
- (BOOL)ptxCollectionViewIsLoading:(PTXCollectionView *)ptxCollectionView ;
//加载更多
- (void)loadMoreForPTXCollectionView:(PTXCollectionView *)ptxCollectionView ;


@end
@interface PTXCollectionView : UIView
/*
 @param sectionInsets:上下左右的间距
 @param itemSpace:横向间距
 @param lineSpace:纵向间距
 @param itemSize:cell的大小
 @param bgColor:网格视图的背景颜色
 */
-(instancetype)initWithFrame:(CGRect)frame sectionInset:(UIEdgeInsets)sectionInsets itemSpace:(CGFloat)itemSpace lineSpace:(CGFloat)lineSpace itemSize:(CGSize)itemSize bgColor:(UIColor *)bgColor;
@property (nonatomic,weak)id<PTXCollectionViewDelegate>delegate;
- (void)reloadData;

@end
