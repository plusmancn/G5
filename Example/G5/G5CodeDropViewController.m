//
//  G5CodeDropViewController.m
//  G5
//
//  Created by plusman on 15/4/28.
//  Copyright (c) 2015年 plusmancn. All rights reserved.
//

#import "G5CodeDropViewController.h"

@interface G5CodeDropViewController ()

@end

@implementation G5CodeDropViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 设置TabBar
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"CodeDrop" image:[UIImage imageNamed:@"cloudDrop"] tag:1];
        self.tabBarItem = tabBarItem;
        self.title = @"CodeDrop";
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
