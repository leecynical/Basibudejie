//
//  XMGEssenceViewController.m
//  百思不得姐
//
//  Created by 李金钊 on 16/6/27.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGEssenceViewController.h"
#import "XMGRecommendTagsViewController.h"

@interface XMGEssenceViewController ()

@end

@implementation XMGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(tagButtonClick)];
    self.view.backgroundColor = XMGGlobalBg;
}

-(void)tagButtonClick
{
    XMGRecommendTagsViewController *tags = [[XMGRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
}

@end
