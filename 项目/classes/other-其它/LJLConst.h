#import <UIKit/UIKit.h>

typedef enum{
    
    LJLTopicTypeAll = 1,
    LJLTopicTypePicture = 10,
    LJLTopicTypeWord = 29,
    LJLTopicTypeVoice = 31,
    LJLTopicTypeVideo = 41
    
} LJLTopicType;

UIKIT_EXTERN CGFloat const LJLTitilesViewH;
UIKIT_EXTERN CGFloat const LJLTitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const LJLTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const LJLTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const LJLTopicCellBottomBarH;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const LJLTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const LJLTopicCellPictureBreakH;

/** 精华-cell-最热评论标题的高度 */
UIKIT_EXTERN CGFloat const LJLTopicCellTopCmtTitleH;