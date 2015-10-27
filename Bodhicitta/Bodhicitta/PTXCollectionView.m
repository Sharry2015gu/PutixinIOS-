//
//  PTXCollectionView.m
//  Bodhicitta
//
//  Created by 怀恩11 on 15/8/11.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "PTXCollectionView.h"
#import "TempleVow.h"
#define ptxCellId (@"ptxCellId ")

@interface PTXCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    //网格视图
    UICollectionView *_collView;
}

@end
@implementation PTXCollectionView
-(instancetype)initWithFrame:(CGRect)frame sectionInset:(UIEdgeInsets)sectionInsets itemSpace:(CGFloat)itemSpace lineSpace:(CGFloat)lineSpace itemSize:(CGSize)itemSize bgColor:(UIColor *)bgColor
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //布局对象
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = sectionInsets;
        layout.minimumInteritemSpacing = itemSpace;
        layout.minimumLineSpacing = lineSpace;
        layout.itemSize = itemSize;
        
        //网格视图
        _collView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collView.delegate = self;
        _collView.dataSource = self;
        _collView.backgroundColor = bgColor;
        [self addSubview:_collView];
        
    }
    
    return self;
}

-(void)reloadData
{
    [_collView reloadData];
}

////用费xib方式写
////-(void)registerCellXibName:(NSString *)name
//{
//    [_collView registerNib:[UINib nibWithNibName:name bundle:nil] forCellWithReuseIdentifier:ktcCellId];
//}
//注册cell
//这里这册是这样写吗？？
-(void)registerCellXibName:(NSString *)name{
    [_collView registerClass:[TempleVow class] forCellWithReuseIdentifier:ptxCellId];
}
#pragma mark - UICollectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger num = 0;
    if (self.delegate) {
        //num = [self.delegate ktcCollectionView:self numberOfCellsInSection:section];
        num=[self.delegate ptxCollectionView:self numberOfCellsInSection:section];
    }
    return num;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ptxCellId forIndexPath:indexPath];
    if (self.delegate) {
        //显示数据
        //[self.delegate ktcCollectionView:self configCell:cell atIndexPath:indexPath];
        [self.delegate ptxCollectionView:self configCell:cell atIndexPath:indexPath];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate) {
        //[self.delegate ktcCollectionView:self didSelectCellAtIndexPath:indexPath];
        [self.delegate ptxCollectionView:self didSelectCellAtIndexPath:indexPath];
    }
}

//下拉加载更多
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //判断是否有更多
    BOOL hasMore = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ktcCollectionViewHasMoreData:)]) {
        //hasMore = [self.delegate ktcCollectionViewHasMoreData:self];
        hasMore =[self.delegate ptxCollectionViewHasMoreData:self];
    }
    if (!hasMore) {
        return;
    }
    
    //判断是否正在加载
    BOOL isLoading = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ktcCollectionViewIsLoading:)]) {
        //isLoading = [self.delegate ktcCollectionViewIsLoading:self];
        isLoading =[self.delegate ptxCollectionViewIsLoading:self];
    }
    if (isLoading) {
        return;
    }
    
    
    //加载更多
    if (scrollView.contentOffset.y+scrollView.bounds.size.height >= scrollView.contentSize.height - 60) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadMoreForKTCCollectionView:)]) {
            //[self.delegate loadMoreForKTCCollectionView:self];
            [self.delegate loadMoreForPTXCollectionView:self];
        }
        
    }
    
}




@end
