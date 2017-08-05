//
//  BSProgressView.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/8/5.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSProgressView.h"

@implementation BSProgressView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.progressLabel.textColor = [UIColor whiteColor];
    self.roundedCorners = 3;
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
}

@end
