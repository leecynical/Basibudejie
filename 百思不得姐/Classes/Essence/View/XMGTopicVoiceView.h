//
//  XMGTopicVoiceView.h
//  百思不得姐
//
//  Created by 李金钊 on 16/8/18.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGTopic;
@interface XMGTopicVoiceView : UIView
+ (instancetype)topicVoiceView;

@property (nonatomic, strong) XMGTopic *topic;
@end
