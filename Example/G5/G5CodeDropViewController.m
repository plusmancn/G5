//
//  G5CodeDropViewController.m
//  G5
//
//  Created by plusman on 15/4/28.
//  Copyright (c) 2015年 plusmancn. All rights reserved.
//

#import "G5CodeDropViewController.h"
#import <G5/G5RemoteUpdate.h>
#import <G5/G5BrowserController.h>
#import "LineButton.h"

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
        
        
        // 更新按钮
        UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cloudDrop"] style:UIBarButtonItemStyleBordered target:self action:@selector(updateLocalHtml)];
        self.navigationItem.rightBarButtonItem = refresh;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    LineButton *openJsSdk = [[LineButton alloc] initWithFrame:CGRectZero LineButtonType:LineButtonBule];
    [openJsSdk addTarget:self action:@selector(showF7WebDemo) forControlEvents:UIControlEventTouchUpInside];
    [openJsSdk setTitle:@"push方式打开【fileSystem】网页" forState:UIControlStateNormal];
    [self.view addSubview:openJsSdk];
    
    
    [openJsSdk makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

/**
 * 展示web示例
 */
- (void)showF7WebDemo{
    
    G5BrowserController *G5Browser = [[G5BrowserController alloc] init];
    [G5Browser loadURLWithLocalfile:@"index" query:@"" isInMainBundle:NO];
    [self.navigationController pushViewController:G5Browser animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateLocalHtml{
    [G5RemoteUpdate updateLocalCodeSlient:NO showView:self.view];
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
