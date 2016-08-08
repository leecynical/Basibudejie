//
//  XMGProgressView.m
//  百思不得姐
//
//  Created by 李金钊 on 16/8/7.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGProgressView.h"

@implementation XMGProgressView

-(void)awakeFromNib
{
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;
{
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.1f", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
