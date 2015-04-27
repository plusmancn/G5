//
//  MainViewController.m
//  JuHappy
//
//  Created by plusman on 14/12/16.
//  Copyright (c) 2014年 plusman. All rights reserved.
//

#import "MainViewController.h"
#import "Tab1ViewController.h"
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
    Tab1ViewController *tab1 = [[Tab1ViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:tab1];
    [self addChildViewController:nav];
    
    [self setSelectedIndex:0];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
