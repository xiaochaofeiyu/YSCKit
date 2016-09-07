//
//  UIView+YSCShadow.m
//  YSCKitDemo
//
//  Created by yushichao on 16/8/31.
//  Copyright © 2016年 YSC. All rights reserved.
//

#import "UIView+YSCShadow.h"
#import <objc/runtime.h>

static const void *ysc_enableShadowKey = "ysc_enableShadowKey";
static const void *ysc_shadowIsShowKey = "ysc_shadowIsShowKey";
static const void *ysc_shadowLayerKey = "ysc_shadowLayerKey";
static const void *ysc_backgroundViewKey = "ysc_backgroundViewKey";

@implementation UIView(YSCShadow)

- (void)ysc_showShadow
{
    if (!self.ysc_enableShadow || self.ysc_shadowIsShow) {
        return;
    }
    self.ysc_shadowLayer.opacity = 1.0;
    [self.superview.layer insertSublayer:self.ysc_shadowLayer below:self.layer];
    self.ysc_shadowIsShow = YES;
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self.ysc_backgroundView];
}

- (void)ysc_hideShadow
{
    if (!self.ysc_enableShadow || !self.ysc_shadowIsShow ) {
        return;
    }
    self.ysc_shadowLayer.opacity = 0.0;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @1.0;
    opacityAnimation.toValue = @0.0;
    opacityAnimation.duration = 0.25;
    opacityAnimation.delegate = self;
    [self.ysc_shadowLayer addAnimation:opacityAnimation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.ysc_shadowLayer removeFromSuperlayer];
    self.ysc_shadowIsShow = NO;
    [self.ysc_backgroundView removeFromSuperview];
}

- (void)backgroundViewTouched:(UITapGestureRecognizer *)gesture
{
    [self ysc_hideShadow];
}

- (UIColor *)ysc_shadowBackgroundColor
{
    UIColor *backgroundColor = self.backgroundColor;
    UIView *superView = self;
    while (superView) {
        BOOL isEqualToClearColor = YES;
        backgroundColor = superView.backgroundColor;
        if (backgroundColor) {
            isEqualToClearColor = CGColorEqualToColor(backgroundColor.CGColor, [UIColor clearColor].CGColor);
            if (!isEqualToClearColor) {
                break;
            }
        }
        superView = superView.superview;
        backgroundColor = [UIColor whiteColor];
    }
    
    return backgroundColor;
}

#pragma mark - var

- (BOOL)ysc_enableShadow
{
    NSNumber *_enableShadow = objc_getAssociatedObject(self, ysc_enableShadowKey);
    
    if (nil == _enableShadow) {
        _enableShadow = [NSNumber numberWithBool:NO];
        objc_setAssociatedObject(self,
                                 ysc_enableShadowKey,
                                 _enableShadow,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return [_enableShadow boolValue];
}

- (void)setYsc_enableShadow:(BOOL)enableShadow
{
    NSNumber *_enableShadow = [NSNumber numberWithBool:enableShadow];
    objc_setAssociatedObject(self,
                             ysc_enableShadowKey,
                             _enableShadow,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)ysc_shadowIsShow
{
    NSNumber *_shadowIsShow = objc_getAssociatedObject(self, ysc_shadowIsShowKey);
    
    if (nil == _shadowIsShow) {
        _shadowIsShow = [NSNumber numberWithBool:NO];
        objc_setAssociatedObject(self,
                                 ysc_shadowIsShowKey,
                                 _shadowIsShow,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return [_shadowIsShow boolValue];
}

- (void)setYsc_shadowIsShow:(BOOL)shadowIsShow
{
    NSNumber *_shadowIsShow = [NSNumber numberWithBool:shadowIsShow];
    objc_setAssociatedObject(self,
                             ysc_shadowIsShowKey,
                             _shadowIsShow,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)ysc_shadowLayer
{
    CALayer *_shadowLayer = objc_getAssociatedObject(self, ysc_shadowLayerKey);
    
    if (nil == _shadowLayer) {
        _shadowLayer = [[CALayer alloc] init];
        _shadowLayer.position = self.layer.position;
        _shadowLayer.bounds = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        _shadowLayer.cornerRadius = 5;
        _shadowLayer.shadowColor = [UIColor blackColor].CGColor;
        _shadowLayer.shadowOffset = CGSizeMake(3, 3);
        _shadowLayer.shadowOpacity = 0.5;
        //        _shadowLayer.opacity = 0.0;
        //layer要有内容才能显出阴影，如本身contents，backgroundColor，border
        _shadowLayer.backgroundColor = [self ysc_shadowBackgroundColor].CGColor;
        
        objc_setAssociatedObject(self,
                                 ysc_shadowLayerKey,
                                 _shadowLayer,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return _shadowLayer;
}

- (UIView *)ysc_backgroundView
{
    UIView *_backgroundView = objc_getAssociatedObject(self, ysc_backgroundViewKey);
    
    if (nil == _backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.frame = [UIScreen mainScreen].bounds;
        _backgroundView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTouched:)];
        [_backgroundView addGestureRecognizer:tap];
        
        objc_setAssociatedObject(self,
                                 ysc_backgroundViewKey,
                                 _backgroundView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return _backgroundView;
}

@end
