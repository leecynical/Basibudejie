//
//  XMGTabBar.m
//  百思不得姐
//
//  Created by 李金钊 on 16/6/27.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGTabBar.h"
@interface XMGTabBar()
@property (nonatomic, weak) UIButton *publishButton;
@end
@implementation XMGTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    self.publishButton.height = self.publishButton.currentBackgroundImage.size.height;
    self.publishButton.width = self.publishButton.currentBackgroundImage.size.width;
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    CGFloat buttonH = height;
    CGFloat buttonW = width / 5;
    CGFloat buttonY = 0;
    NSUInteger index = 0;
    for (UIView *button in self.subviews) {
        if(![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
        
        CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) : index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index++;
    }
}

@end
