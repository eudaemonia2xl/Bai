//
//  BSVoiceView.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/8/9.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSVoiceView.h"
#import "BSTopicModel.h"
#import <UIImageView+WebCache.h>

@interface BSVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;


@end
@implementation BSVoiceView

+ (instancetype)voiceView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setTopic:(BSTopicModel *)topic
{
    _topic = topic;
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    NSInteger miniute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",miniute,second];
}

@end
