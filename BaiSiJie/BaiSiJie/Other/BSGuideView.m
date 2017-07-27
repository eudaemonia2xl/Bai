//
//  BSGuideView.m
//  BaiSiJie
//
//  Created by senyint on 2017/7/27.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSGuideView.h"

@interface BSGuideView ()



@end
@implementation BSGuideView

+ (instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (void)show
{
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [[NSBundle mainBundle].infoDictionary objectForKey:key];
    
    NSString *sandboxVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if (![currentVersion isEqualToString:sandboxVersion]) {
        BSGuideView *guideView = [BSGuideView guideView];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        guideView.frame = window.bounds;
        
        [window addSubview:guideView];
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction)cancelGuideView:(UIButton *)sender {
    
    [self removeFromSuperview];
}

@end
