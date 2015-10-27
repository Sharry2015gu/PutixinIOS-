


//
//  UserInfoEditingTableViewCell.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/9/11.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "UserInfoEditingTableViewCell.h"
#import "HeaderFile.h"
@interface UserInfoEditingTableViewCell()<UITextFieldDelegate>
@property(nonatomic,strong) UILabel  *hintLabel;
@end
@implementation UserInfoEditingTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}
-(void)createSubViews
{
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.filed = [[UITextField alloc] initWithFrame:CGRectMake(70,5,SCREEN_WIDTH - 60, 30)];
    self.filed.font = [UIFont systemFontOfSize:15];
    self.filed.delegate = self;
    UIView *accessaryView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 30)];
    UIButton * finishBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40 - 10,0,40,30)];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [accessaryView addSubview:finishBtn];
    // self.filed.inputAccessoryView = accessaryView;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,39,SCREEN_WIDTH,0.5)];
    lineView.backgroundColor = [UIColor darkGrayColor];
    lineView.alpha = 0.2;
    [self addSubview:lineView];
    [self.contentView addSubview:self.filed];

    self.hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60,0,60,30)];
    self.hintLabel.textColor  = [UIColor orangeColor];
    self.hintLabel.hidden  = YES;
    self.hintLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.hintLabel];
}
-(void)setTitle:(NSString *)title
{
    self.textLabel.text = title;
}
-(void)setHintString:(NSString *)hintString
{
    self.hintLabel.text = hintString;
    self.hintLabel.textColor=majorityColor;
}
-(void)setIsHintLabelShow:(BOOL)isHintLabelShow
{
    self.hintLabel.hidden = isHintLabelShow;
}
#pragma mark ------表示能否编辑
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSArray * titleArray = @[@"昵称",@"签名",@"姓名"];
    NSLog(@"%@",self.textLabel.text);
    for(int i = 0 ; i < titleArray.count; i++)
    {
        if ([self.textLabel.text isEqualToString:titleArray[i]]) {
            return YES;
        }
    }
    self.block();
    return NO;
}
@end
