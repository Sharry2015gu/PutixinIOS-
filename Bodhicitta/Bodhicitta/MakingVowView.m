//
//  MakingVowView.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/9/17.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "MakingVowView.h"
#import "HeaderFile.h"
#import "PlaceholderTextView.h"
@interface MakingVowView()<UITextFieldDelegate,UITextViewDelegate>
{
    NSInteger selectStyleIndex;
}
@property(nonatomic,strong)NSArray *styleTitleArray;
@property(nonatomic,strong)UITextField * nameField;
@property(nonatomic,strong)PlaceholderTextView * vowView;
@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic,strong)UIView   *selectView;
@end
@implementation MakingVowView
-(NSArray *)styleTitleArray
{
    if (_styleTitleArray == nil) {
        _styleTitleArray = @[@"10祈福币",@"100祈福币",@"1000祈福币"];
    }
    return _styleTitleArray;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        selectStyleIndex = 3;
        [self createSubViews];
    }
    return self;
}
-(void)createSubViews
{
    CGFloat  vowHeight;
    if (fabs(SCREEN_HEIGHT-667) < 1)
    {
        vowHeight = 90;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            vowHeight  = 80;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            vowHeight = 120;
        }
        else
        {
            vowHeight  =  60;
        }
    }
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
    bgImageView.image = [UIImage imageNamed:@"点心灯弹窗背景"];
    [self addSubview:bgImageView];

    //self.backgroundColor = [UIColor yellowColor];
    
    UIButton * deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 30, 10, 20, 20)] ;
    [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn  setImage:[UIImage imageNamed:@"bookshelf_delete"] forState:UIControlStateNormal];
    [self addSubview:deleteBtn];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,30,self.frame.size.width,20)];
    titleLabel.text = @"祈愿";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = majorityColor;
    titleLabel.font = [UIFont boldSystemFontOfSize:19];
    [self addSubview:titleLabel];
    
    CGFloat marginX = 10;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(marginX,CGRectGetMaxY(titleLabel.frame)+10,40,20)];
    nameLabel.text = @"姓名";
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = majorityColor;
    [self addSubview:nameLabel];
   
    self.nameField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame),nameLabel.frame.origin.y-5,self.frame.size.width * 0.4,30)];
    self.nameField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"make_wish_name_bg"]];
    self.nameField.font = [UIFont systemFontOfSize:13];
    self.nameField.placeholder = @"请输入你的名字";
    [self addSubview:self.nameField];

    UILabel *vowLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.frame.origin.x,CGRectGetMaxY(self.nameField.frame) + 15,nameLabel.frame.size.width,20)];
    vowLabel.font = [UIFont systemFontOfSize:14];
    vowLabel.textColor = majorityColor;
    vowLabel.text = @"心愿";
    [self addSubview:vowLabel];
    
    self.vowView = [[PlaceholderTextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(vowLabel.frame),CGRectGetMaxY(self.nameField.frame) + 10,self.frame.size.width - CGRectGetMaxX(vowLabel.frame) - 20,vowHeight)];
    self.vowView.font = [UIFont systemFontOfSize:13];
    self.vowView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"make_wish_name_bg"]];
    self.vowView.placeholder = @"请输入你的愿望";
    self.vowView.placeholderFont = [UIFont systemFontOfSize:14];
    self.vowView.textColor = [UIColor lightGrayColor];
    self.vowView.delegate = self;
    [self addSubview:self.vowView];
    
    UILabel *redeemLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.frame.origin.x,CGRectGetMaxY(self.vowView.frame)+10,nameLabel.frame.size.width,20)];
    redeemLabel.textColor = majorityColor;
    redeemLabel.font = [UIFont systemFontOfSize:14];
    redeemLabel.text = @"还愿";
    [self addSubview:redeemLabel];
   
    self.selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.vowView.frame.origin.x,redeemLabel.frame.origin.y,80,30)];
    [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"votive_wish_type_bg"] forState:UIControlStateNormal];
    self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.selectBtn setTitle:@"选择类型" forState:UIControlStateNormal];
    [self.selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.selectBtn addTarget:self action:@selector(selectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.selectBtn];

    UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.5 - 30,CGRectGetMaxY(self.selectBtn.frame)+10,60,30)];
    [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"light_share_friend_normal"] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:submitBtn];
}
#pragma mark ----确定
-(void)submitBtnClick
{
    if ([self.nameField.text isEqualToString:@""] ||[self.vowView.text isEqualToString:@""]) {
        UIAlertView * alrea=[[UIAlertView alloc]initWithTitle:@"名字或心愿不能为空" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alrea show];
    }
    else
    {
        if (selectStyleIndex == 3) {
            UIAlertView * alrea=[[UIAlertView alloc]initWithTitle:@"请选择还愿方式" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alrea show];
        }
        else
        {
            //将值传出去
            self.submitBlock(self.nameField.text,self.vowView.text,selectStyleIndex);
        }
        self.nameField.text = @"";
        self.vowView.text = @"";
         [self.selectBtn setTitle:@"选择类型" forState:UIControlStateNormal];
    }
}
#pragma mark -----
-(void)selectBtnClick
{
    self.selectView = [[UIView alloc]initWithFrame:CGRectMake(self.selectBtn.frame.origin.x,CGRectGetMaxY(self.selectBtn.frame),self.selectBtn.frame.size.width,20 * self.styleTitleArray.count)];
    for(int i = 0 ; i < self.styleTitleArray.count; i++)
    {
        NSString *titleStr = self.styleTitleArray[i];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0,i * 20,self.selectView.frame.size.width,20)];
        [btn setBackgroundImage:[UIImage imageNamed:@"make_wish_name_bg"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:titleStr forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
         btn.tag = 200 +i ;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.selectView addSubview:btn];
    }
    [self addSubview:self.selectView];
}
#pragma mark ----UITextField代理方法
-(void)deleteBtnClick
{
    self.nameField.text = @"";
    self.vowView.text = @"";
    self.deleteBlock();
}
#pragma mark ----- 选择许愿方式
-(void)btnClick:(UIButton *)btn
{
    selectStyleIndex = btn.tag - 200;
    NSString *title = self.styleTitleArray[selectStyleIndex];
    [self.selectBtn setTitle:title forState:UIControlStateNormal];
    [self.selectView removeFromSuperview];
}
#pragma mark  ----
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}
@end
