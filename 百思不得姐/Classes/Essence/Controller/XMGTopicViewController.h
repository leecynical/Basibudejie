//
//  XMGTopicViewController.h
//  百思不得姐
//
//  Created by 李金钊 on 16/8/3.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    XMGTopicTypeAll = 1,
    XMGTopicTypePic = 10,
    XMGTopicTypeWord = 29,
    XMGTopicTypeVoice = 31,
    XMGTopicTypeVideo = 41
} XMGTopicType;
@interface XMGTopicViewController : UITableViewController
/**
 *  请求服务器发送参数中的type
 */
@property (nonatomic, assign) XMGTopicType type;
@end
