//
//  Tab1ViewController.m
//  g5
//
//  Created by plusman on 15/4/27.
//  Copyright (c) 2015年 plusman. All rights reserved.
//

#import "Tab1ViewController.h"
#import "LineButton.h"
#

@interface Tab1ViewController ()

@end

@implementation Tab1ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 设置TabBar
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Tab1" image:[UIImage imageNamed:@"TabBrowser"] tag:0];
        self.tabBarItem = tabBarItem;
        self.title = @"tab1";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LineButton *openJsSdk = [[LineButton alloc] initWithFrame:CGRectZero LineButtonType:LineButtonBule];
    
    [openJsSdk setTitle:@"打开JS-SDK示例页面" forState:UIControlStateNormal];
    [self.view addSubview:openJsSdk];
    
    
    [openJsSdk makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
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
