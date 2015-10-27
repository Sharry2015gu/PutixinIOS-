//
//  Buddhadd_MyRanlTableViewCell.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/10/15.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "Buddhadd_MyRanlTableViewCell.h"
#import "HeaderFile.h"
@interface Buddhadd_MyRanlTableViewCell()
@property(nonatomic,strong)UILabel * rankLabel;
@property(nonatomic,strong)UILabel * leverLabel;
@property(nonatomic,strong)UILabel * gardLabel;
@property(nonatomic,strong)UILabel * tributePersonlabel;
@end
@implementation Buddhadd_MyRanlTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}
-(void)createSubViews
{
    CALayer *layer = self.contentView.layer;
    layer.masksToBounds = YES;
    self.backgroundColor = [UIColor redColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    CGFloat width;
    CGFloat height ;
    CGFloat font ;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        width = 230;
        height =  100;
        font  = 16;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            width = 180;
            height = 95;
            font = 14;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            width = 230;
            height = 100;
            font = 16;
        }
        else
        {
            width = 180;
            height  = 100;
            font = 14;
        }
    }
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.contentView.frame.size.width*0.4+300,39)];
    bgImageView.image =[UIImage imageNamed:@"temple_rank_items_normal_bg.jpg"];
    [self.contentView addSubview:bgImageView];
    
    _rankLabel =[[UILabel alloc]initWithFrame:CGRectMake(width*0.15, height*0.1, 50, 20)];
    _rankLabel.textColor = WorkDayColor;
    _rankLabel.font=[UIFont systemFontOfSize:font];
    [bgImageView addSubview:_rankLabel];
    
    _leverLabel = [[UILabel alloc]initWithFrame:CGRectMake(_rankLabel.frame.origin.x+40, _rankLabel.frame.origin.y,50,20)];
    _leverLabel.text=@"12";
    _leverLabel.font=[UIFont systemFontOfSize:font];
    _leverLabel.textColor=WorkDayColor;
    [bgImageView addSubview:_leverLabel];
    
    _gardLabel = [[UILabel alloc]initWithFrame:CGRectMake(_leverLabel.frame.origin.x+_leverLabel.frame.size.width+width*0.1, _rankLabel.frame.origin.y, 80, 20)];
    _gardLabel.text = @"33级";
    _gardLabel.font = [UIFont systemFontOfSize:font];
    _gardLabel.textColor = WorkDayColor;
    [bgImageView addSubview:_gardLabel];
    
    _tributePersonlabel = [[UILabel alloc]initWithFrame:CGRectMake(_gardLabel.frame.origin.x+_gardLabel.frame.size.width+width*0.1, height*0.2, 80, 15)];
    _tributePersonlabel.text=@"共分者";
    _tributePersonlabel.textColor=WorkDayColor;
    _tributePersonlabel.font=[UIFont systemFontOfSize:font];
    [bgImageView addSubview:_tributePersonlabel];
    
        
}
@end
