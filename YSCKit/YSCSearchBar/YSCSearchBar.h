//
//  YSCSearchBar.h
//  YSCSearchBarExample
//
//  Created by yushichao on 16/7/31.
//  Copyright © 2016年 MMS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, YSCSearchBarShowType) {
    YSCSearchBarTypeCustom              = 0,
    YSCSearchBarShowTypeSpread          = 1,
};

@protocol YSCSearchBarDelegate <NSObject>

- (void)searchButtonTouched:(id)sender;
@end

@interface YSCSearchBar : UIView

@property (nonatomic, assign) YSCSearchBarShowType showType;
@property (nonatomic, weak) id<YSCSearchBarDelegate> delegate;

- (void)showInParentView:(UIView *)parentView withArea:(UIEdgeInsets)viewEdgeInsets withShowType:(YSCSearchBarShowType)showType;
- (void)removeFromParentView;
@end
