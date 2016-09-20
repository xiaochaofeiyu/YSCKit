//
//  YSCSwitch.m
//  YSCKitDemo
//
//  Created by yushichao on 16/9/19.
//  Copyright © 2016年 YSC. All rights reserved.
//

#import "YSCSwitch.h"

@interface YSCSwitch ()

@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation YSCSwitch

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 500.0;
    transform = CATransform3DTranslate(transform, 0, 0, 50);
    
    [self addSubview:self.backgroundView];
}

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        CAShapeLayer *backgroundShapeLayer = [self backgroundShapeLayer];
        backgroundShapeLayer.frame = self.bounds;
        [_backgroundView.layer addSublayer:backgroundShapeLayer];
        
    }
    
    return _backgroundView;
}

- (CAShapeLayer *)backgroundShapeLayer
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor grayColor].CGColor;
    shapeLayer.lineWidth = 1.0;
    shapeLayer.fillColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
    shapeLayer.fillRule = @"even-odd";
    
    UIBezierPath *outpath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.bounds.size.height / 2.0];
    UIBezierPath *inpath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, 10, 10) cornerRadius:self.bounds.size.height / 2.0 - 10];
    [outpath appendPath:inpath];
    
    shapeLayer.path = outpath.CGPath;
    
    return shapeLayer;
}

@end
