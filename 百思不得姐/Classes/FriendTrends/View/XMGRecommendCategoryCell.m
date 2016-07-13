//
//  XMGRecommendCategoryCell.m
//  百思不得姐
//
//  Created by 李金钊 on 16/7/1.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGRecommendCategoryCell.h"
#import "XMGRecommendCategory.h"
@interface XMGRecommendCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end
@implementation XMGRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = XMGRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = XMGRGBColor(219, 21, 26);
}

-(void)setCategory:(XMGRecommendCategory *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
}

-(void)layoutSubviews
{
    //don't forget to write [super layoutSubviews]
    [super layoutSubviews];
    //重新调整内部textLabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}
/**
 *  可以在这个方法中监听cell的选中和取消选中
 *  cell的selection 为None 时， 即使cell被选中，内部子控件就不会进入高亮状态 
 *
 *  @param selected <#selected description#>
 *  @param animated <#animated description#>
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : XMGRGBColor(78, 78, 78);
}

@end
