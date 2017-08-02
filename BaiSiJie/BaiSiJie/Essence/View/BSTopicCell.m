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

@property (weak, nonatomic) BSPictureView *pictureView;

@end
@implementation BSTopicCell

- (void)setTopic:(BSTopicModel *)topic
{
    _topic = topic;
    
    self.sineVImageView.hidden = !topic.sina_v;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.nameLabel.text = topic.name;
    self.contentLabel.text = topic.text;
    
    if (topic.type == BSTopicTypePicture) {
        self.pictureView.topic = topic;
        self.pictureView.frame = CGRectMake(0, 0, 0, 0);
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
        _pictureView = [BSPictureView pictureView];
        [self.contentView addSubview:_pictureView];
    }
    return _pictureView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
