//
//  SearchViewCell.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/18.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "SearchViewCell.h"
#import "HeaderFile.h"

@interface SearchViewCell()
@property(nonatomic,strong)UIImageView * bookImageView;
@property(nonatomic,strong)UILabel * titleLable;
@property(nonatomic,strong)UILabel * totalLabel;
@property(nonatomic,strong)UILabel * numLabel;
@property(nonatomic,strong)UIButton * hideBtn;
@end
@implementation SearchViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ) {
        self.backgroundColor = [UIColor redColor];
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    
    _bookImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 35, 45)];
    _bookImageView.image = [UIImage imageNamed:@"book1"];
    [self.contentView addSubview:_bookImageView];
    
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(_bookImageView.frame.origin.x+_bookImageView.frame.size.width+15, self.center.y - 10, 40, 20)];
    _titleLable.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:_titleLable];
    
    _totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLable.frame.origin.x, _titleLable.frame.origin.y+_titleLable.frame.size.height+5,100,20)];
    _totalLabel.textColor = [UIColor lightGrayColor];
    _totalLabel.font = [UIFont boldSystemFontOfSize:14];
    _totalLabel.text= @"共     M,下载       次";
    [self.contentView addSubview:_totalLabel];
    
    _hideBtn = [[UIButton alloc]initWithFrame:CGRectMake(_titleLable.frame.origin.x+100, _titleLable.frame.origin.y+10, SCREEN_WIDTH*0.06, SCREEN_HEIGHT*0.035)];
    [_hideBtn setBackgroundImage:[UIImage imageNamed:@"music_arrow_up"] forState:UIControlStateNormal];
    //    [_hideBtn addTarget:self action:@selector(yincangClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_hideBtn];
    
    
}
-(void)setWisModel:(WisdomModel *)wismodel{
    
    self.titleLable.text = wismodel.title;
    self.totalLabel.text = [NSString stringWithFormat:@"%ld",wismodel.wordTotal];
    
    
}
@end

