//
//  XMGPublishViewController.m
//  百思不得姐
//
//  Created by 李金钊 on 16/8/8.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGPublishViewController.h"
#import "XMGVerticalBtn.h"

@interface XMGPublishViewController ()

@end

@implementation XMGPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 标语
    UIImageView *sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.y = XMGScreenH * 0.2;
    sloganView.centerX = XMGScreenW * 0.5;
    [self.view addSubview:sloganView];
    
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    int maxCols = 3;//共3列
    CGFloat btnWidth = 72;//图片宽度
    CGFloat btnHeight = btnWidth + 30; //图片高度 ＋ 文字高度
    CGFloat btnStartY = (XMGScreenH - btnHeight * 2) * 0.5; //btn起始Y
    CGFloat btnStartMarginX = 20;//btn左右margin
    CGFloat btnMarginX = (XMGScreenW - btnStartMarginX * 2 - maxCols * btnWidth) / (maxCols - 1);//btn中间margin
    
    for (int i = 0; i < images.count; i++) {
        XMGVerticalBtn *btn = [[XMGVerticalBtn alloc] init];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //setImage 不是setBackgroundImage
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        int col = i % maxCols; 
        int row = i / maxCols;
        btn.width = btnWidth;
        btn.height = btnHeight;
        btn.x = btnStartMarginX + col * (btnWidth + btnMarginX);
        btn.y = btnStartY + btnHeight * row;
        [self.view addSubview:btn];
    }
}

- (IBAction)cancel
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
