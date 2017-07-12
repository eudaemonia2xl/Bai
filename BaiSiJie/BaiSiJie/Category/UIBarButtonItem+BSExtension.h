//
//  UIBarButtonItem+BSExtension.h
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/7/12.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BSExtension)

+ (instancetype)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image selectedImage:(NSString *)selectedImage;

@end
