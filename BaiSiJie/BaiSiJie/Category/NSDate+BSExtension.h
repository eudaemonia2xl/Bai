//
//  NSDate+BSExtension.h
//  BaiSiJie
//
//  Created by senyint on 2017/7/31.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BSExtension)

/**
 * 创建分类，直接返回两个时间之间的差值
 */
- (NSDateComponents *)deltaFormDate:(NSDate *)from;

/**
 * 判断是否是今年
 */
- (BOOL)isThisYear;

/**
 * 判断是否是今天
 */
- (BOOL)isToday;

/**
 * 判断是否是昨天
 */
- (BOOL)isYesterday;

@end
