//
//  YSCButton.h
//  YSCButtonDemo
//
//  Created by yushichao on 16/9/18.
//  Copyright © 2016年 YSC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YSCButtonActionType) {
    YSCButtonActionTypeTouchUpInside = 0,
    YSCButtonActionTypeTouchUpOutside,
    YSCButtonActionTypeTouchDragEnter,
    YSCButtonActionTypeTouchDragExit,
};

@interface YSCButton : UIButton

/**
 *  设置此属性后，button的UIControlEventTouchUpInside事件的响应范围扩大至button的bounds向上扩展touchExitInset.top，向左扩展touchExitInset.left，向右扩展 touchExitInset.right，向下扩展touchExitInset.bottom；UIControlEventTouchDragExit、UIControlEventTouchDragEnter和UIControlEventTouchUpOutside事件的范围也会做相应改变
 */
@property (nonatomic, assign) UIEdgeInsets touchExitInset;

@end
