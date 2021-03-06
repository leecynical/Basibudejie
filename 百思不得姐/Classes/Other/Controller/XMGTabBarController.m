//
//  XMGTabBarController.m
//  百思不得姐
//
//  Created by 李金钊 on 16/6/26.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGTabBarController.h"
#import "XMGEssenceViewController.h"
#import "XMGNewViewController.h"
#import "XMGFriendTrendsViewController.h"
#import "XMGMeViewController.h"
#import "XMGTabBar.h"
#import "XMGNavigationController.h"

@interface XMGTabBarController ()

@end

@implementation XMGTabBarController
+(void)initialize
{
    //initalize只初始化一次
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    //通过appearance统一设置所有UITabBarItem的文字属性
    //后面带有UI_APPEARANCE_SELECTOR的方法，都可以通过appearance对象统一设置
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setChildViewController:[[XMGEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setChildViewController:[[XMGNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setChildViewController:[[XMGFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setChildViewController:[[XMGMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    //tabBar属性readonly, 可通过kvc， kvc可直接访问成员变量_tabBar
    [self setValue:[[XMGTabBar alloc] init] forKeyPath:@"tabBar"];
}

-(void)setChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:vc];
    
    XMGNavigationController *nav = [[XMGNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}


@end
