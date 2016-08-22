//
//  XMGComment.h
//  百思不得姐
//
//  Created by 李金钊 on 16/8/22.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMGUser;
@interface XMGComment : NSObject
/**
 *  评论正文
 */
@property (nonatomic, copy) NSString *content;
/**
 *  点赞数
 */
@property (nonatomic, assign) NSInteger like_count;
/**
 *  评论音频时长
 */
@property (nonatomic, assign) NSInteger voicetime;
/**
 *  评论用户
 */
@property (nonatomic, strong) XMGUser *user;

@end
