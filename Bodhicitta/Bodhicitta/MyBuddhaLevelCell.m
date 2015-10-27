//
//  MyBuddhaLevelCell.m
//  Bodhicitta
//
//  Created by 怀恩11 on 15/10/18.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "MyBuddhaLevelCell.h"
#import "HeaderFile.h"
#import "CheckBuddhaHallLevel.h"
@interface MyBuddhaLevelCell()
@property(nonatomic,strong)UILabel *rankLabel;
@property(nonatomic,strong)UILabel *valueLabel;
@property(nonatomic,strong)UILabel *levelLabel;
@property(nonatomic,strong)UILabel *nameLabel;

@end
@implementation MyBuddhaLevelCell
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
    //    layer.cornerRadius = 3;
    layer.masksToBounds = YES;
    self.backgroundColor = [UIColor redColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    CGFloat width;
    CGFloat height ;
    CGFloat font ;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        width = 230;
        height =  100;
        font  = 14;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            width = 180;
            height = 95;
            font = 12;
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
    UIImageView *bgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    bgImageView.image=[UIImage imageNamed:@"temple_rank_items_normal_bg.jpg"];
    [self.contentView addSubview:bgImageView];
    self.rankLabel=[[UILabel alloc]initWithFrame:CGRectMake(25, 10, 50, 20)];
    self.rankLabel.textColor=WorkDayColor;
    self.rankLabel.font=[UIFont systemFontOfSize:font];
    [bgImageView addSubview:self.rankLabel];
    self.valueLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.rankLabel.frame.size.width+self.rankLabel.frame.origin.x+width*0.1, self.rankLabel.frame.origin.y, 50, 20)];
    self.valueLabel.textColor=WorkDayColor;
    self.valueLabel.font=[UIFont systemFontOfSize:font];
    [bgImageView addSubview:self.valueLabel];
    self.levelLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.valueLabel.frame.size.width+self.valueLabel.frame.origin.x+width*0.1, self.valueLabel.frame.origin.y, 50, 20)];
    self.levelLabel.font=[UIFont systemFontOfSize:font];
    self.levelLabel.textColor=WorkDayColor;
    [bgImageView addSubview:self.levelLabel];
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.levelLabel.frame.origin.x+self.levelLabel.frame.size.width+width*0.1, self.levelLabel.frame.origin.y, 100, 20)];
    self.nameLabel.textColor=WorkDayColor;
    self.nameLabel.font=[UIFont systemFontOfSize:font];
    [bgImageView addSubview:self.nameLabel];
}

- (void)setBuddhaModel:(BuddhaLevel *)model IndexPath:(NSIndexPath *)indexPath
{
    _model=model;
    self.rankLabel.text=[NSString stringWithFormat:@"%ld",model.templeOrder];
    self.valueLabel.text=[NSString stringWithFormat:@"%ld",model.templeIntegral];
    NSInteger value=model.templeIntegral;
    
    CheckBuddhaHallLevel *levelManager = [CheckBuddhaHallLevel   shareCheckBuddhaHallLevel];
    NSInteger   levelInteger = [levelManager checkBuddhaHallLevelWithValue:value];
    self.levelLabel.text=[NSString stringWithFormat:@"%ld级",levelInteger];
    if ([model.nickName isEqualToString:@""]){
        
        self.nameLabel.text=[NSString stringWithFormat:@"%ld",model.huaienID];
       
    }else{
        
        self.nameLabel.text=model.nickName;
      
    }
}

@end
