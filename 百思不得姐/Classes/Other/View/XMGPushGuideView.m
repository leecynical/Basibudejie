//
//  XMGPushGuideView.m
//  百思不得姐
//
//  Created by 李金钊 on 16/7/18.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGPushGuideView.h"

@implementation XMGPushGuideView

+(void)show
{
    NSString *key = @"CFBundleShortVersionString";
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    NSString *sandboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sandboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        XMGPushGuideView *pushGuideView = [XMGPushGuideView guideView];
        pushGuideView.frame = window.bounds;
        [window addSubview:pushGuideView];
        
        //存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+(instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (IBAction)closePushGuideView
{
    [self removeFromSuperview];
}

@end
