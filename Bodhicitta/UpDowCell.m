//
//  UpDowCell.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/5/7.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "UpDowCell.h"

@implementation UpDowCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        InfoLabel = [[UILabel alloc]init];
        InfoLabel.textColor=[[UIColor alloc]initWithRed:102/255.0f green:169/255.0f blue:251/255.0f alpha:1];
        InfoLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:InfoLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    InfoLabel.frame = CGRectMake(140, (self.frame.size.height-20)/2, 140, 20);
}

-(void)setData:(UpDowModel *)dicdata{
    cellData = dicdata;
   
    InfoLabel.text = dicdata.title;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if(selected){
        self.backgroundColor = RGBCOLOR(12, 102, 188);
            InfoLabel.textColor = [UIColor whiteColor];
    }else{
        self.backgroundColor = [UIColor whiteColor];
        
        InfoLabel.textColor=[[UIColor alloc]initWithRed:102/255.0f green:169/255.0f blue:251/255.0f alpha:1];
    }
    // Configure the view for the selected state
}

@end
