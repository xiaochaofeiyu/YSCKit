//
//  YSCSearchBar.m
//  YSCSearchBarExample
//
//  Created by yushichao on 16/7/31.
//  Copyright © 2016年 MMS. All rights reserved.
//

#import "YSCSearchBar.h"

#define buttonRatio 0.667

@interface YSCSearchBar ()

@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIView *backgroundView;
@end

@implementation YSCSearchBar

- (void)removeFromParentView
{
    [_backgroundView removeFromSuperview];
    [self removeFromSuperview];
}

- (void)showInParentView:(UIView *)parentView withArea:(UIEdgeInsets)viewEdgeInsets withShowType:(YSCSearchBarShowType)showType
{
    if (![self.superview isKindOfClass:[parentView class]]) {
        [parentView addSubview:self];
    }
    //
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary * views = NSDictionaryOfVariableBindings(parentView,self);
    NSMutableArray *allConstraints = [NSMutableArray array];
    NSString *constraintsHFormat = [NSString stringWithFormat:@"H:|-%f-[self]-%f-|",viewEdgeInsets.left, viewEdgeInsets.right];
    NSArray *constraintsH = [NSLayoutConstraint constraintsWithVisualFormat:constraintsHFormat options:0 metrics:nil views:views];
    [allConstraints addObjectsFromArray:constraintsH];
    NSString *constraintsVFormat = [NSString stringWithFormat:@"V:|-%f-[self]-%f-|",viewEdgeInsets.top, viewEdgeInsets.bottom];
    NSArray *constraintsV = [NSLayoutConstraint constraintsWithVisualFormat:constraintsVFormat options:0 metrics:nil views:views];
    [allConstraints addObjectsFromArray:constraintsV];
    [parentView addConstraints:allConstraints];
    [parentView layoutIfNeeded];
    
    _showType = showType;
    [self addSubviews];
    
}

- (void)addSubviews
{
    [self.superview insertSubview:self.backgroundView belowSubview:self];
    [self addSubview:self.searchTextField];
    [self addSubview:self.searchButton];
    [self setSubViewsProperty];
}

- (void)setSubViewsProperty
{
    if (YSCSearchBarTypeCustom == _showType) {
        _searchTextField.frame = CGRectMake((self.frame.size.width - self.frame.size.height) / 2.0, 0, self.frame.size.height, self.frame.size.height);
        _searchTextField.layer.cornerRadius = 5.0;
        _searchTextField.backgroundColor = [UIColor whiteColor];
        _searchButton.frame = CGRectMake((self.frame.size.width - self.frame.size.height * buttonRatio) / 2.0, self.frame.size.height * (1 - buttonRatio) / 2.0, self.frame.size.height * buttonRatio, self.frame.size.height * buttonRatio);
    } else if (YSCSearchBarShowTypeSpread == _showType) {
        _searchTextField.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _searchTextField.layer.cornerRadius = self.frame.size.height / 2.0;
        _searchTextField.backgroundColor = [UIColor colorWithRed:52.0/255.0 green:53.0/255.0 blue:60.0/255.0 alpha:1.0];
        _searchButton.frame = CGRectMake(self.frame.size.width - self.frame.size.height * (1 + buttonRatio) / 2.0, self.frame.size.height * (1 - buttonRatio) / 2.0, self.frame.size.height * buttonRatio, self.frame.size.height * buttonRatio);
    }
    _backgroundView.frame = [UIScreen mainScreen].bounds;
}

- (void)addAnimations
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [weakSelf setSubViewsProperty];
    } completion:^(BOOL finished) {
        if (YSCSearchBarTypeCustom == _showType) {
            [weakSelf.searchTextField resignFirstResponder];
        } else if (YSCSearchBarShowTypeSpread == _showType) {
            [weakSelf.searchTextField becomeFirstResponder];
        }
    }];
}

- (void)searchButtonTouched:(id)sender
{
    if (YSCSearchBarTypeCustom == _showType) {
        _showType = YSCSearchBarShowTypeSpread;
        [self addAnimations];
    } else if (YSCSearchBarShowTypeSpread == _showType) {
        if ([_delegate respondsToSelector:@selector(searchButtonTouched:)]) {
            [_delegate searchButtonTouched:sender];
        }
    }
}

- (void)backgroundViewTouched:(UITapGestureRecognizer *)tap
{
    if (YSCSearchBarShowTypeSpread == _showType) {
        _showType = YSCSearchBarTypeCustom;
        [self addAnimations];
    }
}

#pragma mark - settersAndGetters

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTouched:)];
        [_backgroundView addGestureRecognizer:tap];
    }
    
    return _backgroundView;
}

- (UITextField *)searchTextField
{
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] init];
        _searchTextField.backgroundColor = [UIColor whiteColor];
        _searchTextField.layer.cornerRadius = 0;
        _searchTextField.layer.masksToBounds = YES;
    }
    
    return _searchTextField;
}

- (UIButton *)searchButton
{
    if (!_searchButton) {
        _searchButton = [[UIButton alloc] init];
        _searchButton.layer.masksToBounds = YES;
        [_searchButton setBackgroundImage:[UIImage imageNamed:@"searchBar"] forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(searchButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _searchButton;
}

@end
