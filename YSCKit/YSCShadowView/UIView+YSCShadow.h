//
//  UIView+YSCShadow.h
//  YSCKitDemo
//
//  Created by yushichao on 16/8/31.
//  Copyright © 2016年 YSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(YSCShadow)

@property (nonatomic, assign) BOOL ysc_enableShadow;
@property (nonatomic, assign) BOOL ysc_shadowIsShow;

- (void)ysc_showShadow;
- (void)ysc_hideShadow;

@end
