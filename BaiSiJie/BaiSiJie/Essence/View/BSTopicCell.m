//
//  BSTopicCell.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/7/30.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSTopicCell.h"
#import "BSTopicModel.h"
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

@end
@implementation BSTopicCell

- (void)setTopic:(BSTopicModel *)topic
{
    _topic = topic;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.nameLabel.text = topic.name;
    
    self.creatTimeLabel.text = topic.created_at;

    [self setupButton:self.dingBtn count:topic.ding placeHolder:@"顶"];
    [self setupButton:self.caiBtn count:topic.cai placeHolder:@"踩"];
    [self setupButton:self.repostBtn count:topic.repost placeHolder:@"转发"];
    [self setupButton:self.commentBtn count:topic.comment placeHolder:@"评论"];
}

- (void)setupCreatTime:(NSString *)created_at
{
    NSDate *now = [NSDate date];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    
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
    CGFloat margin = 8;
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
