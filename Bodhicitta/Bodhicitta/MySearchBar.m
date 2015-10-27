
//
//  MySearchBar.m
//  MemoryWebApp
//
//  Created by 怀恩03 on 15/7/29.
//  Copyright (c) 2015年 怀恩03. All rights reserved.
//

#import "MySearchBar.h"
#import "HeaderFile.h"

#define kXMargin  10
#define kYMargin 2
#define kIconSize 16

#define kSearchBarHeight 32

@interface MySearchBar ()<UITextFieldDelegate>
{
    BOOL  _cancelButtonHidden;
}
@property(nonatomic,strong) UIButton  *cancelButton;
@property(nonatomic,strong) UIImageView *searchImageView;
@property(nonatomic,strong) MySRoundedView  *backgroundView;
@property(nonatomic,strong) UIImage *searchImage;
@end

@implementation MySearchBar

- (void)setDefaults {
    
    UIImage *searchIcon = [UIImage imageNamed:@"search-icon"];
    _searchImage = searchIcon;
    self.backgroundColor = [UIColor whiteColor];
    
    NSUInteger boundsWidth = self.bounds.size.width;
    NSUInteger textFieldHeight = self.bounds.size.height - kYMargin;
    
    //Background Rounded White Image
    self.backgroundView = [[MySRoundedView alloc] initWithFrame:CGRectMake(0, 0, boundsWidth, self.bounds.size.height)];
    [self addSubview:self.backgroundView];
    
    //Search Image
    self.searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 0, kIconSize, kIconSize)];
    self.searchImageView.image = self.searchImage;
    self.searchImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.searchImageView.center = CGPointMake(kIconSize/2 + kXMargin, CGRectGetMidY(self.bounds));
    [self addSubview:self.searchImageView];
    
    //TextField
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, SCREEN_WIDTH - 110,self.frame.size.height - 20)];
    //self.textField.backgroundColor = [UIColor greenColor];
    self.textField.delegate = self;
    self.textField.leftView = self.searchImageView;
    self.textField.leftViewMode = UITextFieldViewModeUnlessEditing;
    self.textField.returnKeyType = UIReturnKeySearch;
    self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    //UIFont *defaultFont = [UIFont fontWithName:@"Avenir Next" size:14];
    self.textField.font = [UIFont boldSystemFontOfSize:14];
    self.textField.textColor = [UIColor blackColor];
    [self addSubview:self.textField];
    
    //Cancel Button
    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 10, 60,self.textField.frame.size.height)];
    [self.cancelButton setTitle:@"搜索" forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    [self.cancelButton setTitleColor:majorityColor forState:UIControlStateNormal];
    self.cancelButton.contentMode = UIViewContentModeScaleAspectFit;
    self.cancelButton.center = CGPointMake(boundsWidth -50, CGRectGetMidY(self.bounds));
    [self.cancelButton addTarget:self action:@selector(pressedCancel:) forControlEvents:UIControlEventTouchUpInside];
    CALayer *cancelButtonLayer = self.cancelButton.layer;
    cancelButtonLayer.cornerRadius = 5;
    [self addSubview:self.cancelButton];
    
    
    //Listen to text changes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextFieldTextDidChangeNotification object:self.textField];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setDefaults];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    
    CGRect newFrame = frame;
    frame.size.height = kSearchBarHeight;
    frame = newFrame;
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaults];
    }
    return self;
}

- (id)init
{
    return [self initWithFrame:CGRectMake(10, 20, 300, 32)];
}

#pragma mark - Properties and actions

- (NSString *)text {
    return self.textField.text;
}
- (void)setText:(NSString *)text {
    self.textField.text = text;
}
- (NSString *)placeholder {
    return self.textField.placeholder;
}
- (void)setPlaceholder:(NSString *)placeholder {
    self.textField.placeholder = placeholder;
}

- (UIFont *)font {
    return self.textField.font;
}
- (void)setFont:(UIFont *)font {
    self.textField.font = font;
}

- (BOOL)isCancelButtonHidden {
    return _cancelButtonHidden;
}
- (void)setCancelButtonHidden:(BOOL)cancelButtonHidden {
    
    if (_cancelButtonHidden != cancelButtonHidden) {
        _cancelButtonHidden = cancelButtonHidden;
        self.cancelButton.hidden = cancelButtonHidden;
    }
}

- (void)pressedCancel: (id)sender {
    if ([self.delegate respondsToSelector:@selector(searchBarCancelButtonClicked:)])
        [self.delegate searchBarCancelButtonClicked:self];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
}
#pragma mark - Text Delegate
-(void)textChanged:(id) sender
{
    if ([self.delegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
        [self.delegate searchBarCancelButtonClicked:self];
    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)])
        [self.delegate  searchBarTextDidBeginEditing:self];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)])
        [self.delegate searchBarTextDidBeginEditing:self];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)])
        [self.delegate searchBarTextDidEndEditing:self];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)])
        [self.delegate searchBarSearchButtonClicked:self];
    
    return YES;
}

- (BOOL)isFirstResponder {
    return [self.textField isFirstResponder];
}
- (BOOL)becomeFirstResponder {
    return [self.textField becomeFirstResponder];
}
- (BOOL)resignFirstResponder {
    [self.textField resignFirstResponder];
    return YES;
}
#pragma mark - Cleanup
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

@implementation MySRoundedView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor whiteColor];
        //        CALayer *bgViewLayer = self.layer;
        //        bgViewLayer.borderColor = OrangeColor.CGColor;
        //        bgViewLayer.borderWidth = 0.5;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(30,10,SCREEN_WIDTH - 120,self.frame.size.height -20)];
    view.backgroundColor = [[UIColor alloc]initWithRed:192.0f/255.0f green:192.0f/255.0f blue:192.0f/255.0f alpha:1];
    CALayer *viewLayer = view.layer;
    viewLayer.borderWidth = 0.5;
    viewLayer.cornerRadius = 5;
    viewLayer.borderColor = [UIColor clearColor].CGColor;
    [self addSubview:view];
    //    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    //    CGContextSetFillColorWithColor(contextRef,LIGHTGREEN.CGColor);
    //    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(30,10,SCREEN_WIDTH - 60,self.frame.size.height -20) cornerRadius:5];
    //    [path fill];
}
@end


