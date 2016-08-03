
#import <UIKit/UIKit.h>
typedef enum{
    XMGTopicTypeAll = 1,
    XMGTopicTypePic = 10,
    XMGTopicTypeWord = 29,
    XMGTopicTypeVoice = 31,
    XMGTopicTypeVideo = 41
} XMGTopicType;
/**
 *   精华-顶部标题的高度
 */
UIKIT_EXTERN CGFloat const XMGTitlesViewH;
/**
 *   精华-顶部标题的Y
 */
UIKIT_EXTERN CGFloat const XMGTitlesViewY;
/**
 *  精华－cell边距
 */
UIKIT_EXTERN CGFloat const XMGTopicCellMargin;
/**
 *  精华-cell-文字内容的Y值
 */
UIKIT_EXTERN CGFloat const XMGTopicCellTextY;
/**
 *  精华－cell-底部工具条高度
 */
UIKIT_EXTERN CGFloat const XMGTopicCellBottomBarHeight;