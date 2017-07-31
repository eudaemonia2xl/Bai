//
//  BSTopicViewController.h
//  BaiSiJie
//
//  Created by senyint on 2017/7/31.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import <UIKit/UIKit.h>

//1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
typedef enum : NSUInteger {
    BSTopicTypeALL = 1,
    BSTopicTypeVideo = 41,
    BSTopicTypeVoice = 31,
    BSTopicTypePicture = 10,
    BSTopicTypeWord = 29
} BSTopicType;
@interface BSTopicViewController : UITableViewController

//创建的控制器类型
@property (nonatomic, assign) BSTopicType type;

@end
