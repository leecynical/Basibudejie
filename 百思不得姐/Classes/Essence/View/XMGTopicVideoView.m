//
//  XMGTopicVideoView.m
//  百思不得姐
//
//  Created by 李金钊 on 16/8/21.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGTopicVideoView.h"
#import "XMGTopic.h"
#import <UIImageView+WebCache.h>
#import "XMGShowPictureController.h"
@interface XMGTopicVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
@end
@implementation XMGTopicVideoView

+(instancetype)topicVideoView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)awakeFromNib
{
    /**
     *  autoresizing会影响自定义的frame
     */
    self.autoresizingMask = UIViewAutoresizingNone;
    self.backgroundImageView.userInteractionEnabled = YES;
    [self.backgroundImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(showPicture)]];
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
    
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:topic.image_large]];
    
    NSString *playCount = nil;
    if (topic.playcount > 10000) {
        playCount = [NSString stringWithFormat:@"%.1f次播放", topic.playcount / 10000.0];
    }else{
        playCount = [NSString stringWithFormat:@"%zd次播放", topic.playcount];
    }
    self.playcountLabel.text = playCount;
    
    NSInteger min = topic.videotime / 60;
    NSInteger sec = topic.videotime % 60;
    //%02zd 保留2位，用0填补
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", min, sec];
}

@end
