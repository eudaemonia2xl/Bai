//
//  BSTabBar.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/7/10.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSTabBar.h"

@interface BSTabBar ()

//发布按钮
@property (weak, nonatomic) UIButton *publishBtn;

@end

@implementation BSTabBar

//自定义控件第一步：重写initWithFrame方法，添加控件
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [self addSubview:publishBtn];
        self.publishBtn = publishBtn;
    }
    return self;
}

//自定义控件第二步：重写layoutSubviews方法，对控件进行布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.publishBtn.bounds = CGRectMake(0, 0, self.publishBtn.currentBackgroundImage.size.width, self.publishBtn.currentBackgroundImage.size.height);
    
    //注意：设置center属性是时相对于父视图的，跟布局里的center概念不一样
//    self.publishBtn.center = CGPointMake(self.center.x, self.center.y);
//    NSLog(@"%f  %f",self.center.x,self.center.y);
    self.publishBtn.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    
    NSInteger index = 0;
    
    CGFloat viewY = 0;
    CGFloat viewW = self.frame.size.width * 0.2;
    CGFloat viewH = self.frame.size.height;
    for (UIView *view in self.subviews) {
        if (![view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            continue;
        }
        //计算子控件的x时，跳过发布按钮位置，由于发布按钮与其他4个按钮在数组中的顺序不知道，所以依次设置x更麻烦，所以单独设置发布按钮的frame更简单
        CGFloat viewX = viewW * ((index > 1)?(index + 1):index);

        view.frame = CGRectMake(viewX, viewY, viewW, viewH);
        index++;
    }
}

@end
