
//
//  UIView+BSView.m
//  BaiSiJie
//
//  Created by senyint on 2017/7/11.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "UIView+BSView.h"

@implementation UIView (BSView)

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.height;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.y;
}


@end
