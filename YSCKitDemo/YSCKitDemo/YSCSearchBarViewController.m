//
//  YSCSearchBarViewController.m
//  YSCSearchBarExample
//
//  Created by yushichao on 16/7/31.
//  Copyright © 2016年 MMS. All rights reserved.
//

#import "YSCSearchBarViewController.h"
#import "YSCSearchBar.h"

@interface YSCSearchBarViewController ()<YSCSearchBarDelegate>

@end

@implementation YSCSearchBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    
    YSCSearchBar *searchBar = [[YSCSearchBar alloc] init];
    searchBar.delegate = self;
    UIEdgeInsets inset = UIEdgeInsetsMake(100, 100, self.view.bounds.size.height - 100 - 44, 100);
    [searchBar showInParentView:self.view withArea:inset withShowType:YSCSearchBarTypeCustom];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchButtonTouched:(id)sender
{
    NSLog(@"searchButtonTouched");
}

@end
