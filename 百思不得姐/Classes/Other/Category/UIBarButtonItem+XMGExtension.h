//
//  UIBarButtonItem+XMGExtension.h
//  百思不得姐
//
//  Created by 李金钊 on 16/6/28.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XMGExtension)
+(instancetype)itemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action;
@end
