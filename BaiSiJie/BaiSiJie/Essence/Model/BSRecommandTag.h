//
//  BSRecommandTag.h
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/7/22.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSRecommandTag : NSObject
//图片路径
@property (copy, nonatomic) NSString *image_list;
//名字
@property (copy, nonatomic) NSString *theme_name;
//关注人数
@property (assign, nonatomic) NSInteger sub_number;
@end
