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
    
    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonW = self.frame.size.width / 5;
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
