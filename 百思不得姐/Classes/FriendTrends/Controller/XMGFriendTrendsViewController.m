//
//  XMGFriendTrendsViewController.m
//  百思不得姐
//
//  Created by 李金钊 on 16/6/27.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGFriendTrendsViewController.h"
#import "XMGRecommendationViewController.h"
#import "XMGLoginRegisterController.h"

@interface XMGFriendTrendsViewController ()

@end

@implementation XMGFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightImage:@"friendsRecommentIcon-click" target:self action:@selector(friendButtonClick)];
    self.view.backgroundColor = XMGGlobalBg;
}

-(void)friendButtonClick
{
    XMGRecommendationViewController *vc = [[XMGRecommendationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)loginRegister
{
    XMGLoginRegisterController *login = [[XMGLoginRegisterController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
}

@end
