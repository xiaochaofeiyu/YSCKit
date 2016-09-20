//
//  YSCSwitchViewController.m
//  YSCKitDemo
//
//  Created by yushichao on 16/9/19.
//  Copyright © 2016年 YSC. All rights reserved.
//

#import "YSCSwitchViewController.h"
#import "YSCSwitch.h"

@interface YSCSwitchViewController ()

@property (nonatomic, strong) YSCSwitch *swich;

@end

@implementation YSCSwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.swich];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (YSCSwitch *)swich
{
    if (!_swich) {
        self.swich = [[YSCSwitch alloc] initWithFrame:CGRectMake(100, 300, 100, 50)];
    }
    
    return _swich;
}

@end
