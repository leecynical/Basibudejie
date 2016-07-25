//
//  XMGEssenceViewController.m
//  百思不得姐
//
//  Created by 李金钊 on 16/6/27.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGEssenceViewController.h"
#import "XMGRecommendTagsViewController.h"
#import "XMGAllViewController.h"
#import "XMGPicViewController.h"
#import "XMGWordViewController.h"
#import "XMGVideoViewController.h"
#import "XMGVoiceViewController.h"

@interface XMGEssenceViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIView *indicatorView;
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, weak) UIView *titlesView;
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation XMGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    //
    [self setupChildViewControllers];
    //标签栏
    [self setupTitlesView];
    //
    [self setupContentView];
    
}

-(void)setupChildViewControllers
{
    XMGAllViewController *all = [[XMGAllViewController alloc] init];
    [self addChildViewController:all];
    XMGVideoViewController *video = [[XMGVideoViewController alloc] init];
    [self addChildViewController:video];
    XMGVoiceViewController *voice = [[XMGVoiceViewController alloc] init];
    [self addChildViewController:voice];
    XMGPicViewController *pic = [[XMGPicViewController alloc] init];
    [self addChildViewController:pic];
    XMGWordViewController *word = [[XMGWordViewController alloc] init];
    [self addChildViewController:word];
}

-(void)setupTitlesView
{
    //设置标签view
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.y = 64;
    titlesView.width = self.view.width;
    titlesView.height = 35;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //设置红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    for (int i = 0; i < titles.count; i++) {
        UIButton *titleBtn = [[UIButton alloc] init];
        titleBtn.width = width;
        titleBtn.height = height;
        titleBtn.tag = i;
        titleBtn.x = i * (width);
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
//        [button layoutIfNeeded]; // 强制布局(强制更新子控件的frame)
        [titleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:titleBtn];
        
        // 默认点击第一个button
        if (i == 0) {
            titleBtn.enabled = NO;
            self.selectedBtn = titleBtn;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [titleBtn.titleLabel sizeToFit];
            
            self.indicatorView.width = titleBtn.titleLabel.width;
            self.indicatorView.centerX = titleBtn.centerX;
        }
    }
    [titlesView addSubview:indicatorView];
}

-(void)titleBtnClick:(UIButton *)button
{
    //修改button状态
    self.selectedBtn.enabled = YES;
    button.enabled = NO;
    self.selectedBtn = button;
    //点击动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    //
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

-(void)setupContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    contentView.contentSize = CGSizeMake(self.contentView.width * self.childViewControllers.count, 0);
    //
    [self.view insertSubview:contentView atIndex:0];
    self.contentView = contentView;
    
    [self scrollViewDidEndScrollingAnimation:contentView];
}

-(void)setupNav
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(tagButtonClick)];
    self.view.backgroundColor = XMGGlobalBg;
}

-(void)tagButtonClick
{
    XMGRecommendTagsViewController *tags = [[XMGRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
}

#pragma mark -<UIScrollViewDelegate>
// setContentOffset 调用此方法
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;//controller默认y值20
    vc.view.height = scrollView.height; //设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)

    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
    CGFloat bottom = self.tabBarController.tabBar.height;
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    [scrollView addSubview:vc.view];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleBtnClick:self.titlesView.subviews[index]];
}

@end
