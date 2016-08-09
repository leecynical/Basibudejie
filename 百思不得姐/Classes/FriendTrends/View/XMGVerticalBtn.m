//
//  XMGVerticalBtn.m
//  百思不得姐
//
//  Created by 李金钊 on 16/7/17.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGVerticalBtn.h"

@implementation XMGVerticalBtn

-(void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)awakeFromNib
{
    [self setup];
}
/**
 *  代码创建button时同样具有相同属性
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    //设置文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
