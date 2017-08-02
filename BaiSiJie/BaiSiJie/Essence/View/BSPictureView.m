//
//  BSPictureView.m
//  BaiSiJie
//
//  Created by senyint on 2017/8/2.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSPictureView.h"
#import "BSTopicModel.h"
#import <UIImageView+WebCache.h>

@interface BSPictureView ()

@property (weak, nonatomic) IBOutlet UIButton *seeBigBtn;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@end
@implementation BSPictureView

+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setTopic:(BSTopicModel *)topic
{
    _topic = topic;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:topic.small_image]];
}

@end
