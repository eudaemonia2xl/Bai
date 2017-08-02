//
//  BSTopicViewController.h
//  BaiSiJie
//
//  Created by senyint on 2017/7/31.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSTopicViewController : UITableViewController

//创建的控制器类型
@property (nonatomic, assign) BSTopicType type;

- (void)setupRefresh;

@end
