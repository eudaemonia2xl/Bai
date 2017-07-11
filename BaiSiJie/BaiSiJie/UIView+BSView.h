//
//  UIView+BSView.h
//  BaiSiJie
//
//  Created by senyint on 2017/7/11.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BSView)
//宽度
@property (nonatomic, assign) CGFloat width;
//宽度
@property (nonatomic, assign) CGFloat height;
//宽度
@property (nonatomic, assign) CGFloat x;
//宽度
@property (nonatomic, assign) CGFloat y;

//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/**
 * 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量
 */

@end
