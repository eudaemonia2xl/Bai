//
//  BSTopicViewModel.h
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/8/16.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSTopicViewModel : NSObject

//创建的控制器类型
@property (nonatomic, assign) BSTopicType type;

//数据源数组，放段子数据
@property (strong, nonatomic) NSMutableArray *wordsArray;

- (void)loadNewTopicDataSuccess:(void(^)())success failure:(void(^)())failure;

- (void)loadMoreTopicDataSuccess:(void(^)())success failure:(void(^)())failure;

@end
