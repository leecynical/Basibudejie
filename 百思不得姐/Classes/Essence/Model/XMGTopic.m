//
//  XMGTopic.m
//  百思不得姐
//
//  Created by 李金钊 on 16/7/26.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGTopic.h"
#import <MJExtension.h>
#import "XMGComment.h"
#import "XMGUser.h"
@implementation XMGTopic
{
    /**
     *  readonly属性之生成get,如果重写了get方法，必须重写声明成员变量
     *  外部引用可通过KVC修改 readonly属性
     *  [topic setValue: forKeyPath:@"cellHeight"];
     */
    CGFloat _cellHeight;
}
/**
 *  将服务器返回的字段转化为相对好理解的字段，用于属性名
 */
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"image_small" : @"image0",
             @"image_middle" : @"image2",
             @"image_large" : @"image1"
             };
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"top_cmt": @"XMGComment"};
}

-(NSString *)create_time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *create_date = [dateFormatter dateFromString:_create_time];
    
    if (create_date.isThisYear) {
        if (create_date.isToday) {
            NSDateComponents *components = [[NSDate date] deltaFromDate:create_date];
            if (components.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前", components.hour];
            }else if (components.minute >= 1){
                return [NSString stringWithFormat:@"%zd分钟前", components.minute];
            }else{
                return @"刚刚";
            }
        }else if (create_date.isYesterday){
            dateFormatter.dateFormat = @"昨天 HH:mm:ss";
            return [dateFormatter stringFromDate:create_date];
        }else{
            dateFormatter.dateFormat = @"MM-dd HH:mm:ss";
            return [dateFormatter stringFromDate:create_date];
        }
    }else{
        return _create_time;
    }
}
-(CGFloat)cellHeight
{
    /**
     *  保证cellHeight不重复计算
     */
    if (!_cellHeight) {
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * XMGTopicCellMargin, MAXFLOAT);
        //计算文字高度
        CGFloat textHeight = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        //计算cell高度
        //文字部分高度
        _cellHeight = XMGTopicCellTextY + textHeight + XMGTopicCellMargin;
        //图片部分高度
        if (self.type == XMGTopicTypePic) {//图片帖子
            CGFloat picViewW = maxSize.width;
            CGFloat picViewH = picViewW * self.height / self.width;
            
            if (picViewH >= XMGTopicCellPicMaxHeight) {
                picViewH = XMGTopicCellPicBreakHeight;
                self.bigPic = YES;
            }
            CGFloat picViewX = XMGTopicCellMargin;
            CGFloat picViewY = XMGTopicCellTextY + textHeight + XMGTopicCellMargin;
            _picViewF = CGRectMake(picViewX, picViewY, picViewW, picViewH);
            //_cellHeight += picViewH + XMGTopicCellMargin;
            _cellHeight = CGRectGetMaxY(_picViewF) + XMGTopicCellMargin;
        }else if (self.type == XMGTopicTypeVoice) {//声音帖子
            CGFloat voiceViewX = XMGTopicCellMargin;
            CGFloat voiceViewY = XMGTopicCellTextY + textHeight + XMGTopicCellMargin;
            CGFloat voiceViewW = maxSize.width;
            CGFloat voiceViewH = voiceViewW * self.height / self.width;
            _voiceViewF = CGRectMake(voiceViewX, voiceViewY, voiceViewW, voiceViewH);
            _cellHeight = CGRectGetMaxY(_voiceViewF) + XMGTopicCellMargin;
        }else if (self.type == XMGTopicTypeVideo) {//视频帖子
            CGFloat videoViewX = XMGTopicCellMargin;
            CGFloat videoViewY = XMGTopicCellTextY + textHeight + XMGTopicCellMargin;
            CGFloat videoViewW = maxSize.width;
            CGFloat videoViewH = videoViewW * self.height / self.width;
            _videoViewF = CGRectMake(videoViewX, videoViewY, videoViewW, videoViewH);
            
            _cellHeight = CGRectGetMaxY(_videoViewF) + XMGTopicCellMargin;
        }
        
        XMGComment *cmt = [self.top_cmt firstObject];
        //存在最热评论时，最热评论View高度
        if (cmt) {
            NSString *cmt_content = [NSString stringWithFormat:@"%@ : %@", cmt.user.username, cmt.content];
            CGFloat cmt_contentH = [cmt_content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize: 13]} context:nil].size.height;
            _cellHeight += XMGTopicCellTopCmtTitleH + cmt_contentH + XMGTopicCellMargin;
        }
        
        _cellHeight += XMGTopicCellBottomBarHeight + XMGTopicCellMargin;
    }
    return _cellHeight;
}
@end
