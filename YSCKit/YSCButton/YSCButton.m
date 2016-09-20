//
//  YSCButton.m
//  YSCButtonDemo
//
//  Created by yushichao on 16/9/18.
//  Copyright © 2016年 YSC. All rights reserved.
//

#import "YSCButton.h"

@interface YSCButton ()

@property (nonatomic, assign) BOOL touchIsOut;
@property (nonatomic, assign) UIControlEvents buttonEventType;
@property (nonatomic, strong) NSMutableDictionary *targetActionDic;

@end

static NSString *yscButtonTarget = @"yscButtonTarget";
static NSString *yscButtonAction = @"yscButtonAction";

@implementation YSCButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        _touchExitInset = UIEdgeInsetsZero;
        _targetActionDic = [NSMutableDictionary dictionary];
        [_targetActionDic setObject:[NSMutableArray array] forKey:[NSNumber numberWithInteger:UIControlEventTouchDragExit]];
        [_targetActionDic setObject:[NSMutableArray array] forKey:[NSNumber numberWithInteger:UIControlEventTouchDragEnter]];
        [_targetActionDic setObject:[NSMutableArray array] forKey:[NSNumber numberWithInteger:UIControlEventTouchUpOutside]];
        [_targetActionDic setObject:[NSMutableArray array] forKey:[NSNumber numberWithInteger:UIControlEventTouchUpInside]];
    }
    return self;
}

- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    if (controlEvents & 0xF0 && !UIEdgeInsetsEqualToEdgeInsets(_touchExitInset, UIEdgeInsetsZero)) {
        NSMutableArray *eventActionArray = [_targetActionDic objectForKey:[NSNumber numberWithInteger:controlEvents]];
        NSMutableDictionary *targetActionDic = [NSMutableDictionary dictionary];
        NSString *actionString = NSStringFromSelector(action);
        [targetActionDic setObject:target forKey:yscButtonTarget];
        [targetActionDic setObject:actionString forKey:yscButtonAction];
        [eventActionArray addObject:targetActionDic];
    } else {
        [super addTarget:target action:action forControlEvents:controlEvents];
    }
}

- (void)handleButtonAction
{
    NSMutableArray *eventActionArray = [_targetActionDic objectForKey:[NSNumber numberWithInteger:_buttonEventType]];
    for (NSDictionary *dic in eventActionArray) {
        id target = [dic objectForKey:yscButtonTarget];
        SEL selector = NSSelectorFromString([dic objectForKey:yscButtonAction]);
        if (target && selector) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:selector withObject:self];
#pragma clang diagnostic pop
        }
    }
}

//- (void)sendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event
//{
//    NSString *actionString = NSStringFromSelector(action);
//    NSLog(@"%@", actionString);
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    _touchIsOut = NO;
    NSLog(@"touch begin");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSLog(@"point x : %f y: %f", point.x, point.y);
    
    CGRect outRect = CGRectMake(self.bounds.origin.x - self.touchExitInset.left, self.bounds.origin.y - self.touchExitInset.top, self.bounds.size.width + self.touchExitInset.left + self.touchExitInset.right, self.bounds.size.height + self.touchExitInset.top + self.touchExitInset.bottom);
    if (!CGRectContainsPoint(outRect, point) && !_touchIsOut) {
        _touchIsOut = YES;
        _buttonEventType = UIControlEventTouchDragExit;
        [self handleButtonAction];

    } else if (CGRectContainsPoint(outRect, point) && _touchIsOut) {
        _touchIsOut = NO;
        _buttonEventType = UIControlEventTouchDragEnter;
        [self handleButtonAction];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSLog(@"point x : %f y: %f", point.x, point.y);
    
    CGRect outRect = CGRectMake(self.bounds.origin.x - self.touchExitInset.left, self.bounds.origin.y - self.touchExitInset.top, self.bounds.size.width + self.touchExitInset.left + self.touchExitInset.right, self.bounds.size.height + self.touchExitInset.top + self.touchExitInset.bottom);
    if (CGRectContainsPoint(outRect, point)) {
        _buttonEventType = UIControlEventTouchUpInside;
    } else {
        _buttonEventType = UIControlEventTouchUpOutside;
    }
    [self handleButtonAction];
}

@end
