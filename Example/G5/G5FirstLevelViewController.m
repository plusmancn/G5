//
//  G5FirstLevelViewController.m
//  G5
//
//  Created by plusman on 15/4/30.
//  Copyright (c) 2015年 plusmancn. All rights reserved.
//

#import "G5FirstLevelViewController.h"
#import <G5/G5BrowserController.h>

@interface G5FirstLevelViewController ()

@end

@implementation G5FirstLevelViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 设置TabBar
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"一级网页" image:[UIImage imageNamed:@"firstLevel"] tag:2];
        self.tabBarItem = tabBarItem;
        self.title = @"一级网页";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
