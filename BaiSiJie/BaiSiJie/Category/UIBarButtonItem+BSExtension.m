//
//  UIBarButtonItem+BSExtension.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/7/12.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "UIBarButtonItem+BSExtension.h"

@implementation UIBarButtonItem (BSExtension)

+ (instancetype)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    UIButton *tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagBtn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [tagBtn setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateHighlighted];
    tagBtn.size = tagBtn.currentBackgroundImage.size;
    [tagBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:tagBtn];
}

@end
