//
//  XMGRecommendCategory.h
//  百思不得姐
//
//  Created by 李金钊 on 16/7/1.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGRecommendCategory : NSObject
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) NSString *name;
/**
 *  此category对应的用户数据
 */
@property (nonatomic, strong) NSMutableArray *users;
/**
 *  <#Description#>
 */
@property (nonatomic, assign) NSInteger total;
/**
 *
 */
@property (nonatomic, assign) NSInteger currentPage;
@end
