//
//  BSTopicCell.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/7/30.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSTopicCell.h"
#import "BSTopicModel.h"
#import "BSPictureView.h"
#import "BSVoiceView.h"
#import "BSVideoView.h"
#import <UIImageView+WebCache.h>

@interface BSTopicCell ()

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 创建时间 */
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
/** 转发 */
@property (weak, nonatomic) IBOutlet UIButton *repostBtn;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *sineVImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

/* 图片帖子*/
@property (weak, nonatomic) BSPictureView *pictureView;
/* 声音帖子*/
@property (weak, nonatomic) BSVoiceView *voiceView;
/* 视频帖子*/
@property (weak, nonatomic) BSVideoView *videoView;

@end
@implementation BSTopicCell

- (void)setTopic:(BSTopicModel *)topic
{
    _topic = topic;
    
    self.sineVImageView.hidden = !topic.sina_v;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.nameLabel.text = topic.name;
    self.contentLabel.text = topic.text;
    
    if (topic.type == BSTopicTypePicture) { //图片帖子
        //防止cell复用时，页面混乱
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        
        //赋值
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
    } else if (topic.type == BSTopicTypeVoice) { //声音帖子
        self.voiceView.hidden = NO;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        
        self.voiceView.frame = topic.voiceF;
        self.voiceView.topic = topic;
    } else if(topic.type == BSTopicTypeVideo) { //视频帖子
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
        
        self.videoView.frame = topic.videoF;
        self.videoView.topic = topic;
    } else {
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    
    //对于时间的处理，封装在create_at的get方法里，这里获取到的直接是处理完好的时间样式
    self.creatTimeLabel.text = topic.created_at;

    [self setupButton:self.dingBtn count:topic.ding placeHolder:@"顶"];
    [self setupButton:self.caiBtn count:topic.cai placeHolder:@"踩"];
    [self setupButton:self.repostBtn count:topic.repost placeHolder:@"转发"];
    [self setupButton:self.commentBtn count:topic.comment placeHolder:@"评论"];
}

/**
 * 修改人数，
 */
- (void)setupButton:(UIButton *)btn count:(NSString *)count placeHolder:(NSString *)placeholder
{
    if ([count integerValue] > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1ld万",[count integerValue] / 10000];
    } else if ([count integerValue] > 0) {
        placeholder = [NSString stringWithFormat:@"%@",count];
    }
    [btn setTitle:placeholder forState:UIControlStateNormal];
}

/**
 * 重写setFrame方法，改变cell的frame，出现间距
 */
- (void)setFrame:(CGRect)frame
{
    CGFloat margin = 10;
    frame.origin.x = margin;
    frame.size.width -= margin * 2;
    frame.origin.y += margin;
    frame.size.height -= margin;
    
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgImageView;
}

- (BSPictureView *)pictureView
{
    if (!_pictureView) {
        BSPictureView *pictureView = [BSPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (BSVoiceView *)voiceView
{
    if (!_voiceView) {
        BSVoiceView *voiceView = [BSVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (BSVideoView *)videoView
{
    if (!_videoView) {
        BSVideoView *videoView = [BSVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
