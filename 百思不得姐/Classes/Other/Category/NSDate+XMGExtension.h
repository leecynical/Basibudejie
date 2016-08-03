//
//  NSDate+XMGExtension.h
//  百思不得姐
//
//  Created by 李金钊 on 16/7/29.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XMGExtension)
/**
 *  fromDate 与 self 时间差
 */
-(NSDateComponents *)deltaFromDate:(NSDate *)fromDate;

/**
 *  是否为今年
 */
-(BOOL)isThisYear;
/**
 *  是否为今天
 */
-(BOOL)isToday;
/**
 *  是否为昨天
 */
-(BOOL)isYesterday;
@end
