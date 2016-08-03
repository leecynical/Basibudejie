//
//  XMGTopic.m
//  百思不得姐
//
//  Created by 李金钊 on 16/7/26.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGTopic.h"

@implementation XMGTopic

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
    if (!_cellHeight) {
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * XMGTopicCellMargin, MAXFLOAT);
        //计算文字高度
        CGFloat textHeight = [_text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        _cellHeight = XMGTopicCellTextY + textHeight + XMGTopicCellMargin + XMGTopicCellBottomBarHeight + XMGTopicCellMargin;
    }
    return _cellHeight;
}
@end
