//
//  XMGUser.h
//  百思不得姐
//
//  Created by 李金钊 on 16/8/22.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGUser : NSObject
/**
 *  用户名
 */
@property (nonatomic, copy) NSString *username;
/**
 *  头像
 */
@property (nonatomic, copy) NSString *profile_name;
/**
 *  性别
 */
@property (nonatomic, copy) NSString *sex;
@end
