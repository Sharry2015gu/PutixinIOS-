
//
//  BgImagViewCollectionViewCell.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/9/15.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "BgImagViewCollectionViewCell.h"
#import "HeaderFile.h"
@interface  BgImagViewCollectionViewCell()
@property(nonatomic,strong)UIImageView  *imageView;
@property(nonatomic,strong)UILabel      *imageNameLabel;
@end
@implementation BgImagViewCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self   = [super initWithFrame:frame];
    if (self) {
        [self createSubView];
    }
    return self;
}
-(void)createSubView
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height- 20)];
    [self addSubview:self.imageView];
    
    self.imageNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,self.imageView.frame.size.height,self.frame.size.width,20)];
    self.imageNameLabel.textAlignment = NSTextAlignmentCenter;
    self.imageNameLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.imageNameLabel];

    self.selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-20,0,20,20)];
    self.selectBtn.hidden = YES;
    [self.selectBtn setImage:[UIImage imageNamed:@"cover_choosed"] forState:UIControlStateNormal];
    [self addSubview:self.selectBtn];
    UIControl *control = [[UIControl alloc] initWithFrame:self.contentView.frame];
    [control addTarget:self action:@selector(selectTheImage) forControlEvents:UIControlEventTouchUpInside];
    //control.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:control];
}
-(void)setModel:(BgImageModel *)model
{
    [self.imageView setImageWithURL:[NSURL URLWithString:model.materialUrl]placeholderImage:[UIImage imageNamed:@"bluesky_fozu.jpg"]];
     self.imageNameLabel.text = model.materialName;
    NSLog(@"self.imageNameLabel.text=%@",self.imageNameLabel.text);
}
-(void)selectTheImage
{
    self.block(self.imageView.image);
}
@end
