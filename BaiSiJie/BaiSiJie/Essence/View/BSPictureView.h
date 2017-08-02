//
//  BSPictureView.h
//  BaiSiJie
//
//  Created by senyint on 2017/8/2.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSTopicModel;
@interface BSPictureView : UIImageView
//模型数据
@property (strong, nonatomic) BSTopicModel *topic;

+ (instancetype)pictureView;
@end
