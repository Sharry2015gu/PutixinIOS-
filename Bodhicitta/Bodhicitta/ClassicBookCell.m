//
//  ClassicBookCell.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/21.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "ClassicBookCell.h"
#import "HeaderFile.h"
@interface ClassicBookCell()
@property(nonatomic,strong) UIImageView *bookImageView;
@property(nonatomic,strong) UILabel *bookNameLabel;
@property(nonatomic,strong) UILabel *flowLabel;
@property(nonatomic,strong) UILabel *downLoadLabel;
@property(nonatomic,strong) UIButton *expandBtn;
@end
@implementation ClassicBookCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}
-(void)createSubViews
{
    CGFloat width;
    CGFloat height ;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        width = 205;
        height =  120;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            width = 180;
            height = 125;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            width = 230;
            height = 120;
        }
        else
        {
            width = 175;
            height  = 125;
        }
    }

    CGFloat marginX = 5;
    CGFloat marginV = 5;
    self.bookImageView = [[UIImageView alloc] initWithFrame:CGRectMake(marginX+10,marginV-8,30, 50 - 1 * marginV)];
    self.bookImageView.image = [UIImage imageNamed:@"book1"];
    [self.contentView addSubview:self.bookImageView];
    
    self.bookNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.bookImageView.frame)+ 30,marginV-5,self.frame.size.width - CGRectGetMaxX(self.bookImageView.frame)- 30 ,20)];
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
    
    self.expandBtn = [[UIButton alloc] initWithFrame:CGRectMake(width+SCREEN_WIDTH*0.3, height*0.1 ,20,20)];
    [self.expandBtn setBackgroundImage:[UIImage imageNamed:@"no_download"] forState:UIControlStateNormal];
    [self.expandBtn addTarget:self action:@selector(expandBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.expandBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,self.frame.size.height + 5, SCREEN_WIDTH,1)];
    lineView.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"line"]];
    [self.contentView addSubview:lineView];
}
-(void)setModel:(WisdomModel *)model
{
    _model = model;
    self.bookNameLabel.text = model.title;
    NSInteger  wordTotalNumber=model.wordTotal;
    
    self.flowLabel.text = [NSString stringWithFormat:@"共%ldM",wordTotalNumber/1024/1024];
    NSLog(@"self.flowLabel.text=%@",self.flowLabel.text);

    self.downLoadLabel.text = [NSString stringWithFormat:@"共%ld下载次",model.clicks];
//    self.flowLabel.text  = [NSString stringWithFormat:@"共%ldM",model.wordTotal];
}
-(void)expandBtnClick
{
    self.expandBlock(self.model);
    [self.expandBtn setBackgroundImage:[UIImage imageNamed:@"has_download"] forState:UIControlStateNormal];
}
@end

