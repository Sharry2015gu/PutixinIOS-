//
//  MySearchBar.h
//  MemoryWebApp
//
//  Created by 怀恩03 on 15/7/29.
//  Copyright (c) 2015年 怀恩03. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MySearchBarDelegate;

@interface MySearchBar : UIView

@property (nonatomic) NSString *text;
@property (nonatomic) UIFont *font;
@property (nonatomic) NSString *placeholder;

@property (nonatomic) UITextField *textField;

@property (nonatomic, getter = isCancelButtonHidden) BOOL cancelButtonHidden; //NO by Default

@property (nonatomic, weak) id <MySearchBarDelegate> delegate;

@end

@protocol MySearchBarDelegate <NSObject>
@optional
- (void)searchBarCancelButtonClicked:(MySearchBar *)searchBar;
- (void)searchBarSearchButtonClicked:(MySearchBar *)searchBar;

- (BOOL)searchBarShouldBeginEditing:(MySearchBar *)searchBar;
- (void)searchBarTextDidBeginEditing:(MySearchBar *)searchBar;
- (void)searchBarTextDidEndEditing:(MySearchBar *)searchBar;

- (void)searchBar:(MySearchBar *)searchBar textDidChange:(NSString *)searchText;
@end

@interface  MySRoundedView : UIView

@end