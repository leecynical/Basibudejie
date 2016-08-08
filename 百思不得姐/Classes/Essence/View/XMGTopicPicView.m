//
//  XMGTopicPicView.m
//  百思不得姐
//
//  Created by 李金钊 on 16/8/3.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGTopicPicView.h"
#import "XMGTopic.h"
#import <UIImageView+WebCache.h>
#import "XMGProgressView.h"
#import "XMGShowPictureController.h"
@interface XMGTopicPicView()
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**
 *  gif图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/**
 *  查看大图按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigBtn;
/**
 *  进度条
 */
@property (weak, nonatomic) IBOutlet XMGProgressView *progressView;

@end
@implementation XMGTopicPicView
+ (instancetype)topicPicView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)awakeFromNib
{
    /**
     *  autoresizing会影响自定义的frame
     */
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(showPicture)]];
}

-(void)showPicture
{
    XMGShowPictureController *showPictureController = [[XMGShowPictureController alloc] init];
    showPictureController.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPictureController animated:YES completion:nil];
}

-(void)setTopic:(XMGTopic *)topic
{
    _topic = topic;
    //防止cell循环调用时出现progress错位
    [self.progressView setProgress:topic.picProgress animated:NO];
    
    [self.imageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:topic.image_large] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
        self.progressView.hidden = NO;
        topic.picProgress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:topic.picProgress animated:NO];
    }completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        self.progressView.hidden = YES;
        
        if (topic.isBigPic == NO) return;
        //将大图片的预览图显示为顶部
        //开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.picViewF.size, YES, 0);
        //将下载完的image对象绘制到图形上下文
        CGFloat width = topic.picViewF.size.width;
        CGFloat height = image.size.height * width / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        //获取图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        //结束图形上下文
        UIGraphicsEndImageContext();
        
    }];
    
    NSString *extension = topic.image_large.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    if (topic.isBigPic) {
        self.seeBigBtn.hidden = NO;
        //self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
        self.seeBigBtn.hidden = YES;
        //self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
}
@end
