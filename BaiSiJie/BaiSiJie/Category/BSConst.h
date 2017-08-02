//
//  BSConst.h
//  BaiSiJie
//
//  Created by senyint on 2017/8/2.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import <UIKit/UIKit.h>

//1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
typedef enum : NSUInteger {
    BSTopicTypeALL = 1,
    BSTopicTypePicture = 10,
    BSTopicTypeWord = 29,
    BSTopicTypeVoice = 31,
    BSTopicTypeVideo = 41
} BSTopicType;

/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const BSTitilesViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const BSTitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const BSTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const BStopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const BSTopicCellBottomBarH;
