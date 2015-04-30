//
//  MainViewController.m
//  JuHappy
//
//  Created by plusman on 14/12/16.
//  Copyright (c) 2014年 plusman. All rights reserved.
//

#import "MainViewController.h"
#import "G5JsApiViewController.h"
#import "G5CodeDropViewController.h"
#import "G5FirstLevelViewController.h"
#import "BaseNavigationController.h"

@interface MainViewController ()

@end

@implementation MainViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    /*self.tabBar.tintColor = RGBCOLOR(255, 155, 72);*/
    
    
    //初始化我的
    G5JsApiViewController *JsApi = [[G5JsApiViewController alloc] init];
    BaseNavigationController *navJsApi = [[BaseNavigationController alloc] initWithRootViewController:JsApi];
    [self addChildViewController:navJsApi];
    
    
    G5CodeDropViewController *CodeDrop = [[G5CodeDropViewController alloc] init];
    BaseNavigationController *navCodeDrop = [[BaseNavigationController alloc] initWithRootViewController:CodeDrop];
    [self addChildViewController:navCodeDrop];
    
    
    G5FirstLevelViewController *firstLevel = [[G5FirstLevelViewController alloc] init];
    BaseNavigationController *navFirst = [[BaseNavigationController alloc] initWithRootViewController:firstLevel];
    [self addChildViewController:navFirst];
    
    [self setSelectedIndex:2];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
