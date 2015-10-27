//
//  OnlineMusicTableViewCell.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/10/6.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "OnlineMusicTableViewCell.h"
#import "HeaderFile.h"
@interface OnlineMusicTableViewCell()
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel  * titleLabel;
@property(nonatomic,strong)UILabel  * flowLabel;
@property(nonatomic,strong)UILabel  * downTimeLabel;
//当设置的字典中isDownLoad是0时hidden属性为NO isDownLoad为1显示标签
@property(nonatomic,strong)NSMutableArray  * alreadyHasArray;
@property(nonatomic,strong)WisdomModel  *model;
@end
@implementation OnlineMusicTableViewCell
-(NSMutableArray *) alreadyHasArray
{
    if (_alreadyHasArray == nil) {
        _alreadyHasArray = [[NSMutableArray alloc] init];
    }
    return _alreadyHasArray;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self  = [super  initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}
-(void)createSubViews
{
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,12,self.contentView.frame.size.height - 2 *  5,self.frame.size.height - 2 * 5)];
    self.iconImageView.image = [UIImage imageNamed:@"music_icon1"];
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame)+ 10, 10,SCREEN_WIDTH - CGRectGetMaxX(self.iconImageView.frame) - 15 - 50,20)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:self.titleLabel];
    
    self.flowLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x,self.frame.size.height - 5 - 8,self.titleLabel.frame.size.width * 0.5, 20)];
    self.flowLabel.font = [UIFont systemFontOfSize: 12];
    self.flowLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.flowLabel];
    
    self.downTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.flowLabel.frame),self.flowLabel.frame.origin.y,self.flowLabel.frame.size.width,20)];
    self.downTimeLabel.font = [UIFont systemFontOfSize:12];
    self.downTimeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.downTimeLabel];
    
    self.downButton  = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50,(self.frame.size.height - 10) / 2, 20, 20)];
    self.downButton.hidden =  YES;
    [self.downButton addTarget:self action:@selector(downLoadButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.downButton];
    
    self.downLoadingLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100,(self.frame.size.height - 20), 100, 20)];
    self.downLoadingLabel.text = @"正在下载中...";
    self.downLoadingLabel.textColor = [UIColor blackColor];
    self.downLoadingLabel.font = [UIFont systemFontOfSize:11];
    self.downLoadingLabel.textAlignment = NSTextAlignmentRight;
    self.downLoadingLabel.hidden = YES;
    [self.contentView addSubview:self.downLoadingLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineView];
}
-(void)downLoadButtonClick
{
    // 先判断是否下载
    NSInteger  index =  self.downButton.tag;
    if (index == 200) {
        //没有下载的
        self.block(self.model);
        self.downLoadingLabel.hidden = NO;
        self.downButton.hidden = YES;
       //表示正在下载中
        [self.musicInfoDictionary setObject:@1 forKey:@"isDownLoad"];
    }
    else
    {
        self.hintBlock(self.model);
    }
}
-(void)setMusicInfoDictionary:(NSMutableDictionary *)musicInfoDictionary
{
    _musicInfoDictionary = musicInfoDictionary;
    [self getStoreMusicList];
    WisdomModel  * model = [musicInfoDictionary objectForKey:@"model"];
    _model  = model;
    self.titleLabel.text = model.title;
    
    NSLog(@"self.flowLabel.text=%@",self.flowLabel.text);
    NSInteger  wordTotalNumber=model.wordTotal;
    
    self.flowLabel.text = [NSString stringWithFormat:@"共%ldM",wordTotalNumber/1024/1024];
    self.downTimeLabel.text = [NSString stringWithFormat:@"下载%ld次",model.clicks];
    NSNumber * isDownLoadNumber = [musicInfoDictionary objectForKey:@"isDownLoad"];
    if ([isDownLoadNumber integerValue] == 0) {
        self.downButton.hidden = NO;
        self.downLoadingLabel.hidden = YES;
        if (![self hasDownLoad:model.title]) {
             self.downButton.tag = 200;
             [self.downButton setImage: [UIImage imageNamed:@"no_download"] forState:UIControlStateNormal];
        }
        else
        {
            [self.downButton setImage: [UIImage imageNamed:@"has_download"] forState:UIControlStateNormal];
            self.downButton.tag = 201;
        }
    }
    else
    {
        self.downLoadingLabel.hidden = NO;
        self.downButton.hidden  =  YES;
    }
}
//判断是否已经下载完成
-(BOOL)hasDownLoad:(NSString *) title
{
    for(int i = 0 ; i < self.alreadyHasArray.count; i++)
    {
         NSMutableDictionary * dict  = self.alreadyHasArray[i];
        if ([[dict objectForKey:MusicName] isEqualToString:title]) {
            //表示已经下载
            return  true;
        }
    }
    return false;
}
//提取持久化中的数据
-(void)getStoreMusicList
{
    NSMutableArray * musicArray = [[NSUserDefaults standardUserDefaults] objectForKey:StoreMusic];
    NSString * muiscArrayStr = [NSString stringWithFormat:@"%@",musicArray];
    if ( [muiscArrayStr isEqualToString:@"(null)"]) {
        NSMutableArray  *  musicArray = [[NSMutableArray alloc]init];
        [[NSUserDefaults standardUserDefaults] setObject:musicArray forKey:StoreMusic];
    }
    self.alreadyHasArray = musicArray;
}
@end
