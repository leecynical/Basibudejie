//
//  XMGTextField.m
//  百思不得姐
//
//  Created by 李金钊 on 16/7/17.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGTextField.h"
#import <objc/runtime.h>

@implementation XMGTextField

//+(void)initialize
//{
//    unsigned int count = 0;
//    //拷贝所有成员变量列表
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    
//    for (int i = 0; i < count; i++) {
//        //取出成员变量
//        //Ivar var = *(ivars + i);
//        Ivar var = ivars[i];
//        XMGLog(@"%s", ivar_getName(var));
//    }
//    // 释放所有成员变量
//    free(ivars);
//}

-(void)awakeFromNib
{
    /**
     *  设置光标颜色和文字颜色一样
     */
    self.tintColor = self.textColor;
    
    [self resignFirstResponder];
}

-(BOOL)becomeFirstResponder
{
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}

-(BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}

/**
 * 运行时(Runtime):
 * 苹果官方一套C语言库
 * 能做很多底层操作(比如访问隐藏的一些成员变量\成员方法....)
 */
@end
