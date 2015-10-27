//
//  MusicTableViewCell.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/9/2.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "MusicTableViewCell.h"
#import "HeaderFile.h"
@interface MusicTableViewCell()
@property(nonatomic,strong)UIImageView  * iconImageView;
@property(nonatomic,strong)UILabel  *titleLabel;
@property(nonatomic,strong)UILabel  *flowLabel;
@property(nonatomic,strong)UILabel  *downTimeLabel;
@property(nonatomic,strong)UILabel  * downLoadingLabel;
@property(nonatomic,strong)NSMutableDictionary  * musicPlayDict;
@end
@implementation MusicTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
    
    self.downButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50,(self.frame.size.height - 10) / 2, 20, 20)];
    [self.contentView addSubview:self.downButton];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineView];
}
-(void)setMusicPlayDict:(NSMutableDictionary  *) dict
{
    _musicPlayDict = dict;
    self.titleLabel.text =  [dict objectForKey:MusicName];
    NSNumber * wordTotalNumber  = [dict  objectForKey:MusicWordTotal];
    NSInteger wordNumber = [wordTotalNumber integerValue] / 1024;
    self.flowLabel.text = [NSString stringWithFormat:@"共%ldM",wordNumber/1024];
    NSLog(@"self.flowLabel.text=%@",self.flowLabel.text);
    self.downTimeLabel.text = [NSString stringWithFormat:@"下载%@次", [dict  objectForKey:MusicWordClicks]];
    NSNumber  * isPlayingFlag = [dict objectForKey:@"IsPlaying"];
    NSLog(@"^^^^^");
    if ([isPlayingFlag integerValue] == 0) {
        [self.downButton setImage:[UIImage imageNamed:@"music_no_play_list"] forState:UIControlStateNormal];
        
    }
    else
    {
        //表示正在播放中
        [self.downButton setImage:[UIImage imageNamed:@"music_is_playing_list"] forState:UIControlStateNormal];
    }
    //[playDict setObject:@0 forKey:@"IsPlaying"];
    [self.downButton addTarget:self action:@selector(playMusicClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)playMusicClick
{
    //正在播放的时候  防止滚动刷新
    NSLog(@"111^^^^^");
    [self.musicPlayDict setValue:@1 forKey:@"IsPlaying"];
    [self.downButton setImage:[UIImage imageNamed:@"music_is_playing_list"] forState:UIControlStateNormal];
    self.block(self.musicPlayDict);
    NSLog(@"222^^^^^");
}
@end
