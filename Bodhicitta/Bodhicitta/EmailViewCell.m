//
//  EmailViewCell.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/9/8.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "EmailViewCell.h"
#import "HeaderFile.h"
@interface EmailViewCell()
//@property(nonatomic,strong)UILabel * contenLabel;
@property(nonatomic,strong)UILabel * dayLabel;
@property(nonatomic,strong)UILabel * bgLabel;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UIImageView * bgImage;

@end
@implementation EmailViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}
-(void)createSubViews{
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.contentView.frame.size.width*0.4+300,109)];
    bgImageView.image =[UIImage imageNamed:@"登录背景"];
    [self.contentView addSubview:bgImageView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.01-5, SCREEN_WIDTH*0.6, SCREEN_HEIGHT*0.075)];
    _titleLabel.textColor=majorityColor;
    _titleLabel.font=[UIFont systemFontOfSize:16];
    [bgImageView addSubview:_titleLabel];

    _contenLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.05, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.075)];
    _contenLabel.numberOfLines=2;
    _contenLabel.font=[UIFont systemFontOfSize:15];
    [bgImageView addSubview:_contenLabel];
    
    _dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(_contenLabel.frame.origin.x+_contenLabel.frame.size.width-115, _contenLabel.frame.origin.y+30, SCREEN_WIDTH*0.6, SCREEN_HEIGHT*0.075)];
    _dayLabel.text=@"2015-4-9";
    _dayLabel.textColor=[UIColor lightGrayColor];
    _dayLabel.font=[UIFont systemFontOfSize:12];
    [bgImageView addSubview:_dayLabel];
    
    _bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.8, SCREEN_WIDTH*0.05, SCREEN_WIDTH*0.09, SCREEN_HEIGHT*0.03)];
    _bgImage.image=[UIImage imageNamed:@"message_label_gray"];
    [bgImageView addSubview:_bgImage];
    
    _bgLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.81, SCREEN_WIDTH*0.05, SCREEN_WIDTH*0.09, SCREEN_HEIGHT*0.03)];
    _bgLabel.text=@"系统";
    _bgLabel.font=[UIFont systemFontOfSize:12];
    _bgLabel.textColor=[UIColor whiteColor];
    [bgImageView addSubview:_bgLabel];
    
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, bgImageView.frame.origin.y+bgImageView.frame.size.height, SCREEN_WIDTH, 0.5)];
    line.backgroundColor=[UIColor lightGrayColor];
    [self.contentView addSubview:line];
}
-(void)setnewModel:(NewModel *)newmodel{
    
    _newmodel=newmodel;
    _titleLabel.text=_newmodel.title;
    _contenLabel.text=_newmodel.content;
    _dayLabel.text=_newmodel.createDate;
    
    if([_newmodel.readStatus isEqualToString:@"R"]){
    
        _bgImage.image = [UIImage imageNamed:@"message_label_yellow"];
    }
}
@end
