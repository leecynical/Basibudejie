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
 *  图片宽度
 */
@property (nonatomic, assign) CGFloat width;
/**
 *  图片高度
 */
@property (nonatomic, assign) CGFloat height;
/**
 *  小图片url
 */
@property (nonatomic, copy) NSString *image_small;
/**
 *  中图片url
 */
@property (nonatomic, copy) NSString *image_middle;
/**
 *  大图片url
 */
@property (nonatomic, copy) NSString *image_large;
/**
 *  帖子的类型
 */
@property (nonatomic, assign) XMGTopicType type;
/****** 额外的辅助属性 ******/
/**
 *  cell行高
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/**
 *  pic Frame
 */
@property (nonatomic, assign, readonly) CGRect picViewF;
/**
 *  是否为大图
 */
@property (nonatomic, assign, getter=isBigPic) BOOL bigPic;
/**
 *  图片下载进度
 */
@property (nonatomic, assign) CGFloat picProgress;
@end
