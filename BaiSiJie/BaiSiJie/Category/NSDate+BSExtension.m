//
//  NSDate+BSExtension.m
//  BaiSiJie
//
//  Created by senyint on 2017/7/31.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "NSDate+BSExtension.h"

@implementation NSDate (BSExtension)

- (NSDateComponents *)deltaFormDate:(NSDate *)from
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [cal components:unit fromDate:from toDate:self options:0];
}

/**
 * 判断是否是今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear == selfYear;
}

/**
 * 判断是否是今天
 */
- (BOOL)isToday
{
    /* 方式一：
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    return nowCmps.year == selfCmps.year && nowCmps.month == selfCmps.month && nowCmps.day == selfCmps.day;
     */
    //方式二：
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    
    NSString *selfTime = [fmt stringFromDate:self];
    
    return [nowStr isEqualToString:selfTime];
}

/**
 * 判断是否是昨天
 */
- (BOOL)isYesterday{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *now = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    
    NSDate *selfTime = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *cald = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [cald components:unit fromDate:selfTime toDate:now options:0];
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

@end
