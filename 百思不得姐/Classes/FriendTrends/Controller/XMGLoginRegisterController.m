//
//  XMGLoginRegisterController.m
//  百思不得姐
//
//  Created by 李金钊 on 16/7/15.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGLoginRegisterController.h"

@interface XMGLoginRegisterController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation XMGLoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
/**
 *  让当前控制器对应的状态栏是白色
 */
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (IBAction)loginOrRegisterBtn:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) {
        self.loginViewLeftMargin.constant -= self.view.width;
        sender.selected = YES;
    }else{
        self.loginViewLeftMargin.constant = 0;
        sender.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)closeBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
