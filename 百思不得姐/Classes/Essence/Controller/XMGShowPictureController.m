//
//  XMGShowPictureController.m
//  百思不得姐
//
//  Created by 李金钊 on 16/8/7.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGShowPictureController.h"
#import "XMGTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "XMGProgressView.h"
@interface XMGShowPictureController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet XMGProgressView *progressView;

@end

@implementation XMGShowPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //屏幕尺寸
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    CGFloat imageViewW = screenW;
    CGFloat imageViewH = self.topic.height * imageViewW / self.topic.width;
    
    if (imageViewH > screenH) {
        imageView.frame = CGRectMake(0, 0, imageViewW, imageViewH);
        self.scrollView.contentSize = CGSizeMake(0, imageViewH);
    }else{
        imageView.size = CGSizeMake(imageViewW, imageViewH);
        imageView.centerY = screenH * 0.5;
    }
    
    [self.progressView setProgress:self.topic.picProgress animated:NO];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image_large] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:progress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}

-(IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)saveImage
{
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片未下载完!"];
        return;
    }
    //将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

 - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

@end
