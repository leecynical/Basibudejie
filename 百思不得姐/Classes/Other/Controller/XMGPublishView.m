//
//  XMGPublishView.m
//  百思不得姐
//
//  Created by 李金钊 on 16/8/8.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGPublishView.h"
#import "XMGVerticalBtn.h"
#import <POP.h>
static CGFloat const XMGAnimationDelay = 0.1;
static CGFloat const XMGSpringFactor = 10;
@interface XMGPublishView ()

@end

@implementation XMGPublishView
//全局变量 下划线加在后面 命名规范
static UIWindow *window_;
+(void)show
{
    window_ = [[UIWindow alloc] init];
    window_.frame = [UIScreen mainScreen].bounds;
    window_.hidden = NO;
    window_.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    XMGPublishView *publishView = [XMGPublishView publishView];
    publishView.frame = window_.bounds;
    [window_ addSubview:publishView];
}

+ (instancetype)publishView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
-(void)awakeFromNib{

    //进入界面所有控件不能点击
    self.userInteractionEnabled = NO;
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    int maxCols = 3;//共3列
    CGFloat btnWidth = 72;//图片宽度
    CGFloat btnHeight = btnWidth + 30; //图片高度 ＋ 文字高度
    CGFloat btnStartY = (XMGScreenH - btnHeight * 2) * 0.5; //btn起始Y
    CGFloat btnStartMarginX = 20;//btn左右margin
    CGFloat btnMarginX = (XMGScreenW - btnStartMarginX * 2 - maxCols * btnWidth) / (maxCols - 1);//btn中间margin
    
    for (int i = 0; i < images.count; i++) {
        XMGVerticalBtn *btn = [[XMGVerticalBtn alloc] init];
        [self addSubview:btn];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //setImage 不是setBackgroundImage
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        int col = i % maxCols; 
        int row = i / maxCols;
        CGFloat btnX = btnStartMarginX + col * (btnMarginX + btnWidth);
        CGFloat btnAnimationEndY = btnStartY + row * btnHeight;
        CGFloat btnAnimataionStartY = btnAnimationEndY - XMGScreenH;
        //button pop动画
        POPSpringAnimation *btnSpringAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        btnSpringAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnAnimataionStartY, btnWidth, btnHeight)];
        btnSpringAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnAnimationEndY, btnWidth, btnHeight)];
        btnSpringAnimation.springBounciness = XMGSpringFactor;
        btnSpringAnimation.springSpeed = XMGSpringFactor;
        btnSpringAnimation.beginTime = CACurrentMediaTime() + XMGAnimationDelay * i;
        [btn pop_addAnimation:btnSpringAnimation forKey:nil];
    }
    
    //标语
    UIImageView *sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    CGFloat sloganEndY = XMGScreenH * 0.2;
    CGFloat sloganStartY = sloganEndY - XMGScreenH;
    CGFloat sloganX = XMGScreenW * 0.5;
    [self addSubview:sloganView];
    
    POPSpringAnimation *sloganAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    sloganAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(sloganX, sloganStartY)];
    sloganAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(sloganX, sloganEndY)];
    sloganAnimation.springSpeed = XMGSpringFactor;
    sloganAnimation.springBounciness = XMGSpringFactor;
    sloganAnimation.beginTime = CACurrentMediaTime() + images.count * XMGAnimationDelay;
    [sloganAnimation setCompletionBlock:^(POPAnimation *sloganAnimation, BOOL finished){
        //等所有控件动画执行完毕，恢复点击事件
        self.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:sloganAnimation forKey:nil];
}

- (IBAction)cancel
{
    [self cancelWithCompletionBlock:nil];
}
/**
 *  先执行退出动画，动画结束后再执行completionBlock中内容
 */
-(void)cancelWithCompletionBlock:(void(^)())completionBlock
{
    //    [self dismissViewControllerAnimated:NO completion:nil];
    //    XMGLog(@"%@",self.view.subviews);
    self.userInteractionEnabled = NO;
    int startIndex = 1;
    for (int i = startIndex; i < self.subviews.count; i++) {
        UIView *subview = self.subviews[i];
        
        POPBasicAnimation *cancelAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + XMGScreenH;
        cancelAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        //动画的节奏
        cancelAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        cancelAnimation.beginTime = CACurrentMediaTime() + (i - startIndex) * XMGAnimationDelay;
        [subview pop_addAnimation:cancelAnimation forKey:nil];
        
        if (i == self.subviews.count - 1) {
            [cancelAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                //[self dismissViewControllerAnimated:NO completion:nil];
                
//                if (completionBlock) {
//                    completionBlock();
//                }
                //销毁窗口
                //必须设置hidden属性为YES,否则window一直显示
                window_.hidden = YES;
                window_ = nil;
                //window_.hidden = YES;
                //XMGLog(@"%@",NSStringFromCGRect(window_.frame));
                !completionBlock ? : completionBlock();
            }];
        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancelWithCompletionBlock:nil];
}

@end
