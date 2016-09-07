//
//  YSCShadowViewController.m
//  YSCKitDemo
//
//  Created by yushichao on 16/8/31.
//  Copyright © 2016年 YSC. All rights reserved.
//

#import "YSCShadowViewController.h"
#import "UIView+YSCShadow.h"

@interface YSCShadowViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label;

@end

@implementation YSCShadowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.button];
    [self.view addSubview:self.label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonTouched:(UIButton *)sender
{
    [_button ysc_showShadow];
}

- (void)labelTouched:(UITapGestureRecognizer *)tap
{
    [_label ysc_showShadow];
}

- (UIButton *)button
{
    if (!_button) {
        self.button = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 50)];
        _button.center = CGPointMake(self.view.bounds.size.width / 2.0, 100);
        [_button setTitle:@"test button" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _button.ysc_enableShadow = YES;
        
        [_button addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button;
}

- (UILabel *)label
{
    if (!_label) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 200, 50)];
        _label.center = CGPointMake(self.view.bounds.size.width / 2.0, 250);
        _label.text = @"test lable";
        _label.textColor = [UIColor greenColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.ysc_enableShadow = YES;
        _label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTouched:)];
        [_label addGestureRecognizer:tap];
    }
    
    return _label;
}

@end
