//
//  BSRecommandLeft.h
//  BaiSiJie
//
//  Created by senyint on 2017/7/17.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSRecommandCategory : NSObject

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *name;

/** 这个类别对应的用户数据,为了解决重复发送请求新增属性 */
@property (nonatomic, strong) NSMutableArray *users;

//当前页
@property (assign, nonatomic) NSInteger currentPage;


@end
