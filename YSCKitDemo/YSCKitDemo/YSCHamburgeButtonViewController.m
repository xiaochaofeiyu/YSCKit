//
//  YSCHamburgeButtonViewController.m
//  YSCHamburgeButtonExample
//
//  Created by yushichao on 16/7/31.
//  Copyright © 2016年 MMS. All rights reserved.
//

#import "YSCHamburgeButtonViewController.h"
#import "YSCHamburgeButton.h"

@interface YSCHamburgeButtonViewController ()

@end

@implementation YSCHamburgeButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    YSCHamburgeButton *menuButton = [[YSCHamburgeButton alloc] init];
    menuButton.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.4];
    UIEdgeInsets inset = UIEdgeInsetsMake(100, 0, self.view.bounds.size.height - 100 - 54, self.view.bounds.size.width - 54);
    [menuButton showInParentView:self.view withArea:inset withShowType:YSCHamburgeButtonShowTypeHamburge];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
