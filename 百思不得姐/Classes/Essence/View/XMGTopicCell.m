//
//  XMGTopicCell.m
//  百思不得姐
//
//  Created by 李金钊 on 16/7/27.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGTopicCell.h"
#import "XMGTopic.h"
#import <UIImageView+WebCache.h>
#import "NSDate+XMGExtension.h"
#import "XMGTopicPicView.h"
@interface XMGTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *repostBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *sinaVImageView;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) XMGTopicPicView *picImageView;
@end

@implementation XMGTopicCell

-(XMGTopicPicView *)picImageView
{
    if (!_picImageView) {
        XMGTopicPicView *picImageView = [XMGTopicPicView topicPicView];
        [self.contentView addSubview:picImageView];
        _picImageView = picImageView;
    }
    return _picImageView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.backgroundView = bgView;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTopic:(XMGTopic *)topic
{
    _topic = topic;
    
    self.sinaVImageView.hidden = !topic.isSinaV;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.create_time;
    [self setupBtnTitle:self.dingBtn count:topic.ding placeholder:@"顶"];
    [self setupBtnTitle:self.caiBtn count:topic.cai placeholder:@"踩"];
    [self setupBtnTitle:self.repostBtn count:topic.repost placeholder:@"转发"];
    [self setupBtnTitle:self.commentBtn count:topic.comment placeholder:@"评论"];
    
    //[self testDate:topic.create_time];
    self.text_label.text = topic.text;
    if (topic.type == XMGTopicTypePic) {
        self.picImageView.topic = topic;
        self.picImageView.frame = topic.picViewF;
    }
}

//-(void)testDate:(NSString *)date
//{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    dateFormatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
//    
//    NSDate *now = [NSDate date];
//    
//    NSDate *create_time = [dateFormatter dateFromString:date];
//    XMGLog(@"%@", [now deltaFromDate:create_time]);
//}

-(void)setupBtnTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    }else if(count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}
/**
 *  重写setFrame方法，增加cell的边距
 */
-(void)setFrame:(CGRect)frame
{
    frame.origin.x = XMGTopicCellMargin;
    frame.size.width -= 2 * XMGTopicCellMargin;
    frame.size.height -= XMGTopicCellMargin;
    frame.origin.y += XMGTopicCellMargin;
    
    [super setFrame:frame];
}

@end
