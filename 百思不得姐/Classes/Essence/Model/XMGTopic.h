//
//  XMGTopic.h
//  百思不得姐
//
//  Created by 李金钊 on 16/7/26.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGTopic : NSObject
/**
 *  名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  头像图片
 */
@property (nonatomic, copy) NSString *profile_image;
/**
 *  发帖时间
 */
@property (nonatomic, copy) NSString *create_time;
/**
 *  正文
 */
@property (nonatomic, copy) NSString *text;
/**
 *  顶
 */
@property (nonatomic, assign) NSInteger ding;
/**
 *  踩
 */
@property (nonatomic, assign) NSInteger cai;
/**
 *  评论
 */
@property (nonatomic, assign) NSInteger comment;
/**
 *  转发
 */
@property (nonatomic, assign) NSInteger repost;
/**
 *  新浪加V
 */
@property (nonatomic, assign, getter=isSinaV) BOOL sina_v;
/**
 *  cell行高
 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
