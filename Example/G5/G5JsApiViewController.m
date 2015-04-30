//
//  G5JsApiViewController.m
//  g5
//
//  Created by plusman on 15/4/27.
//  Copyright (c) 2015年 plusman. All rights reserved.
//

#import "G5JsApiViewController.h"
#import "LineButton.h"
#import <G5/G5BrowserController.h>

@interface G5JsApiViewController ()

@end

@implementation G5JsApiViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 设置TabBar
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"JsApi" image:[UIImage imageNamed:@"TabBrowser"] tag:0];
        self.tabBarItem = tabBarItem;
        self.title = @"JsApi";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *tips = [[UILabel alloc] init];
    tips.text = @"浏览器弹出方式，目前只支持 push 方式";
    [self.view addSubview:tips];
    
    LineButton *openJsSdk = [[LineButton alloc] initWithFrame:CGRectZero LineButtonType:LineButtonBule];
    [openJsSdk addTarget:self action:@selector(showF7WebDemo) forControlEvents:UIControlEventTouchUpInside];
    [openJsSdk setTitle:@"打开JsApi示例页面" forState:UIControlStateNormal];
    [self.view addSubview:openJsSdk];
    
    [tips makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NAVIGATION_HEIGHT + 20);
        make.width.lessThanOrEqualTo(SCREEN_WIDTH);
        make.centerX.equalTo(self.view);
    }];
    
    [openJsSdk makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tips.bottom).offset(20);
        make.centerX.equalTo(self.view);
    }];
}

/**
 * 展示web示例
 */
- (void)showF7WebDemo{
    
    G5BrowserController *G5Browser = [[G5BrowserController alloc] init];
    [G5Browser loadURLWithLocalfile:@"index" query:@""];
    [self.navigationController pushViewController:G5Browser animated:YES];
    
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
