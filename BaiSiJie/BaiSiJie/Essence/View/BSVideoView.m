//
//  BSVideoView.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/8/9.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSVideoView.h"
#import "BSTopicModel.h"
#import "BSShowPictureViewController.h"
#import <UIImageView+WebCache.h>

@interface BSVideoView ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end
@implementation BSVideoView

+ (instancetype)videoView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    self.bgImageView.userInteractionEnabled = YES;
    [self.bgImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgImageViewTap)]];
}

- (void)bgImageViewTap
{
    BSShowPictureViewController *showPictureVC = [[BSShowPictureViewController alloc] init];
    showPictureVC.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPictureVC animated:YES completion:nil];
}

- (void)setTopic:(BSTopicModel *)topic
{
    _topic = topic;
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:topic.cdn_img]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    NSInteger miniute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",miniute,second];
}


@end
