//
//  BSVideoView.h
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/8/9.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSTopicModel;
@interface BSVideoView : UIView

//视频帖子上的模型
@property (strong, nonatomic) BSTopicModel *topic;
+ (instancetype)videoView;

@end
