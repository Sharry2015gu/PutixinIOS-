//
//  BookView.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/27.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "BookView.h"
#import "HeaderFile.h"
@interface BookView()
@property(nonatomic,strong)UIButton *deleteBtn;
@end
@implementation BookView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor lightGrayColor];
        [self  createSubViews];
    }
    return self;
}
-(void)createSubViews
{
    //关于适配
    CGFloat width;
    CGFloat height;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        width =  200;
        height  =  133;
       
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            width = 165;
            height =   125;
            
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            width  = 233;
            height  =  155;
            
        }
        else
        {
            width = 170;
            height = 100;
        }
    }

    UIImageView * bookImageView = [[UIImageView  alloc] initWithFrame:CGRectMake(width*0.09,0,width*0.4,self.frame.size.height)];
    bookImageView.image = [UIImage imageNamed:@"mybook_shelf_bookbg"];
    //bookImageView.backgroundColor = [UIColor redColor];
    bookImageView.userInteractionEnabled = YES;
    [self addSubview:bookImageView];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(bookImageView.frame.size.width - 0.1 *bookImageView.frame.size.width,0,20,bookImageView.frame.size.height)];
#pragma mark  ------要调整
    self.titleLabel.numberOfLines = 6;
    self.titleLabel.font = [UIFont systemFontOfSize:9];
    //self.titleLabel.backgroundColor = [UIColor yellowColor];
    [bookImageView addSubview:self.titleLabel];
    
    UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(0,0,bookImageView.frame.size.width, bookImageView.frame.size.height)];
    [control addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    [bookImageView addSubview:control];
    
    self.deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0-15,20,20)];
    self.deleteBtn.hidden = YES;
    [self.deleteBtn setImage:[UIImage imageNamed:@"bookshelf_delete"] forState:UIControlStateNormal];
    [self.deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteBtn];
}
-(void)setModel:(CollectModel *)model
{
    
    _model = model;
    
    
    NSInteger characterFont = 10;
    CGFloat  marginRight  = 30;
    CGFloat  marginTop   = 10 ;
    CGFloat width;
    //关于适配
    
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        characterFont =  11;
        marginRight  =  33;
        marginTop =   13;
        width =  200;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            characterFont = 8;
            marginRight =   25;
            marginTop  =  12 ;
            width =  165;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            characterFont  = 13;
            marginRight  =  35;
            marginTop = 15;
            width =  233;
        }
        else
        {
            marginRight = 23.5;
            characterFont  = 8;
            width = 170;
        }
    }
    
    CGFloat maxHeight  = self.frame.size.height -  20;
    CGSize  size = CGSizeMake(MAXFLOAT,MAXFLOAT);
    NSString * singleStr = @"方";
    CGFloat  singleStrWidth = [singleStr sizeWithFont:[UIFont systemFontOfSize:characterFont] maxSize:size].width;
    CGFloat  singleStrHeight = [singleStr sizeWithFont:[UIFont systemFontOfSize:characterFont] maxSize:size].height;
    //第几列
    int  column = 0 ;
    //第几行
    int  rank  = 0 ;
    
    for(int i = 0 ; i < model.title.length;i ++)
    {
        CGFloat yCoordinate = marginTop + rank * singleStrHeight ;
        if (yCoordinate > maxHeight) {
            rank = 0 ;
            column ++;
        }
        UILabel  * label  = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - marginRight - singleStrWidth*column+15,marginTop + rank * singleStrHeight, singleStrWidth,singleStrHeight)];
        rank ++;
        NSString * newStr = [NSString stringWithFormat:@"%C",[model.title characterAtIndex:i]];
        label.text  =  newStr;
        label.font = [UIFont systemFontOfSize:characterFont];
        label.textColor = TempleNameLa;
       
        [self addSubview:label];
    }
    //表示空的
    if (model.title == nil) {
        for(UIView * subView in  self.subviews)
        {
            [subView  removeFromSuperview];
            //           UIImageView *  addImageView = [[UIImageView alloc] initWithFrame:self.frame];
            //           addImageView.image = [UIImage imageNamed:@""];
            UIButton * addBtn = [[UIButton alloc]initWithFrame:CGRectMake(width*0.09,0,width*0.4,self.frame.size.height)];
            [addBtn setBackgroundImage:[UIImage imageNamed:@"book_empty"] forState:UIControlStateNormal];
            [addBtn addTarget:self action:@selector(addBookBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:addBtn];
        }
    }
}
-(void)addBookBtnClick
{
    self.addBlock();
}
-(void)setIsDelete:(BOOL)isDelete
{
    self.deleteBtn.hidden = isDelete;
}
-(void)controlClick
{
    self.selectBlock(self.model);
}
-(void)deleteBtnClick
{
    self.deleteBlock(self.model);
    
}
@end
