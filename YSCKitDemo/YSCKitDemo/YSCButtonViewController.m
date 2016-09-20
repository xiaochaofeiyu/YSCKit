//
//  YSCButtonViewController.m
//  YSCKitDemo
//
//  Created by yushichao on 16/9/19.
//  Copyright © 2016年 YSC. All rights reserved.
//

#import "YSCButtonViewController.h"
#import "YSCButton.h"

@interface YSCButtonViewController ()

@property (nonatomic, strong) YSCButton *originButton;

@end

@implementation YSCButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.originButton];
    _originButton.frame = CGRectMake(100, 400, 200, 50);
    
    CGRect exitButtonActionArea = CGRectMake(50, 380, 300, 90);
    UIView *exitButtonActionAreaView = [[UIView alloc] initWithFrame:exitButtonActionArea];
    exitButtonActionAreaView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.3];

    
    [self.view insertSubview:exitButtonActionAreaView belowSubview:_originButton];
}

- (void)touchDownAction:(id)sender
{
    NSLog(@"touchDownAction - out");
}

- (void)touchUpInsideAction:(id)sender
{
    NSLog(@"touchUpInsideAction - out");
}

- (void)touchUpOutsideAction:(id)sender
{
    NSLog(@"touchUpOutsideAction - out");
}

- (void)touchDragEnterAction:(id)sender
{
    NSLog(@"touchDragEnterAction - out");
}

- (void)touchDragExitAction:(id)sender
{
    NSLog(@"touchDragExitAction - out");
}

- (void)touchCancelAction:(id)sender
{
    NSLog(@"touchCancelAction - out");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (YSCButton *)originButton
{
    if (!_originButton) {
        self.originButton = [[YSCButton alloc] init];
        _originButton.layer.borderWidth = 2;
        _originButton.layer.cornerRadius = 10;
        _originButton.layer.masksToBounds = YES;
        _originButton.layer.borderColor = [UIColor grayColor].CGColor;
        
        _originButton.exclusiveTouch = YES;
        _originButton.touchExitInset = UIEdgeInsetsMake(20, 50, 20, 50);
        
        [_originButton addTarget:self action:@selector(touchDownAction:) forControlEvents:UIControlEventTouchDown];
        [_originButton addTarget:self action:@selector(touchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
        [_originButton addTarget:self action:@selector(touchUpOutsideAction:) forControlEvents:UIControlEventTouchUpOutside];
        [_originButton addTarget:self action:@selector(touchDragEnterAction:) forControlEvents:UIControlEventTouchDragEnter];
        [_originButton addTarget:self action:@selector(touchDragExitAction:) forControlEvents:UIControlEventTouchDragExit];
        [_originButton addTarget:self action:@selector(touchCancelAction:) forControlEvents:UIControlEventTouchCancel];
    }
    
    return _originButton;
}

@end
