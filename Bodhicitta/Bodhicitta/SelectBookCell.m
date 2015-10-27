

//
//  SelectBookCell.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/24.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "SelectBookCell.h"
#import "HeaderFile.h"
@interface SelectBookCell ()
@property(nonatomic,strong) UIImageView *bookImageView;
@property(nonatomic,strong) UILabel *bookNameLabel;
@property(nonatomic,strong) UILabel *flowLabel;
@property(nonatomic,strong) UILabel *downLoadLabel;
@property(nonatomic,strong) UIButton *expandBtn;
@end
@implementation SelectBookCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super  initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}
-(void)createSubViews
{
    CGFloat marginX = 5;
    CGFloat marginV = 5;
    self.bookImageView = [[UIImageView alloc] initWithFrame:CGRectMake(marginX+10,marginV-10,30, 50 - 1 * marginV)];
    self.bookImageView.image = [UIImage imageNamed:@"book1"];
    [self.contentView addSubview:self.bookImageView];
    
    self.bookNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.bookImageView.frame)+ 30,marginV,self.frame.size.width - CGRectGetMaxX(self.bookImageView.frame)- 30 ,20)];
    self.bookNameLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.bookNameLabel];
    
    self.flowLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bookNameLabel.frame.origin.x,50 - 20 - marginV,100,20)];
    self.flowLabel.font = [UIFont systemFontOfSize:14];
    self.flowLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.flowLabel];
    
    self.downLoadLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.flowLabel.frame),self.flowLabel.frame.origin.y,100,20)];
    self.downLoadLabel.font = [UIFont systemFontOfSize:14];
    self.downLoadLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.downLoadLabel];
    
    self.expandBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 20 - 10, self.frame.size.height * 0.5 * 0.5 - 10,20,20)];
    [self.expandBtn setBackgroundImage:[UIImage imageNamed:@"music_arrow_down"] forState:UIControlStateNormal];
    [self.expandBtn addTarget:self action:@selector(expandBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.expandBtn];
    
    UIView *expandView = [[UIView alloc]initWithFrame:CGRectMake(0,50,SCREEN_WIDTH, 50)];
    expandView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:expandView];
    
    NSArray  *array = @[@"下载",@"回向",@"经排行",@"抄经排行"];
    CGFloat btnMarginX  =  0.1 * SCREEN_WIDTH;
    CGFloat btnRelativeX = 0.07  * SCREEN_WIDTH;
    CGFloat btnWidth = (SCREEN_WIDTH -  2 * btnMarginX - 3 * btnRelativeX) /  4;
    CGFloat btnMarginY  =  5;
    for(int i = 0 ; i < array.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(btnMarginX+(btnRelativeX + btnWidth) * i,btnMarginY,btnWidth,expandView.frame.size.height - btnMarginY)];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:array[i]];
        [expandView addSubview:imageView];
        UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(0, 0,imageView.frame.size.width, imageView.frame.size.height)];
        control.tag = 200 + i ;
        [imageView addSubview:control];
        [control addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)setModel:(WisdomModel *)model
{
    _model = model;
    self.bookNameLabel.text = model.title;
    self.downLoadLabel.text = [NSString stringWithFormat:@"共%ld下载次",model.clicks];
    self.flowLabel.text  = [NSString stringWithFormat:@"共%ldM",model.wordTotal];
}
-(void)expandBtnClick
{
    self.expandBlock(self.model);
}
-(void)btnClick:(UIControl * )control
{
    if ( control.tag == 200) {
        self.downloadBlock(self.model);
    }
    if (control.tag == 201) {
        self.reverseBlock(self.model);
    }
    if (control.tag == 202) {
        self.rankBlock1(self.model);
    }
    if (control.tag == 203) {
        self.rankBlock2(self.model);
    }
}
@end
