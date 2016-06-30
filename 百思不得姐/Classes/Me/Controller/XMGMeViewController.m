//
//  XMGMeViewController.m
//  百思不得姐
//
//  Created by 李金钊 on 16/6/27.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGMeViewController.h"

@interface XMGMeViewController ()

@end

@implementation XMGMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    UIBarButtonItem *settingItem =[UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightImage:@"mine-setting-icon-click" target:self action:@selector(settingButtonClick)];
    UIBarButtonItem *nightModeItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightImage:@"mine-moon-icon-click" target:self action:@selector(nightModeButtonClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, nightModeItem];
    self.view.backgroundColor = XMGGlobalBg;
}

-(void)settingButtonClick
{
    XMGLogFunc;
}

-(void)nightModeButtonClick
{
    XMGLogFunc;
}

@end
