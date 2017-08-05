//
//  BSPictureView.m
//  BaiSiJie
//
//  Created by senyint on 2017/8/2.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSPictureView.h"
#import "BSTopicModel.h"
#import "BSShowPictureViewController.h"
#import <DALabeledCircularProgressView.h>
#import <UIImageView+WebCache.h>

@interface BSPictureView ()

@property (weak, nonatomic) IBOutlet UIButton *seeBigBtn;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@end
@implementation BSPictureView

+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
        
    self.progressView.roundedCorners = 4;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    
    self.bgImageView.userInteractionEnabled = YES;
    [self.bgImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureTap)]];
}

/**
 * 图片的单击事件
 */
- (void)pictureTap
{
    BSShowPictureViewController *showPictureVC = [[BSShowPictureViewController alloc] init];
    showPictureVC.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPictureVC animated:YES completion:nil];
}


/**
 * 在不知道图片扩展名的情况下, 如何知道图片的真实类型?
 * 取出图片数据的第一个字节, 就可以判断出图片的真实类型
 */
- (void)setTopic:(BSTopicModel *)topic
{
    _topic = topic;
    self.gifImageView.hidden = !topic.is_gif;
//    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.progressView setProgress:receivedSize / expectedSize * 1 animated:YES];
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0ld%%",receivedSize / expectedSize * 100];
        self.progressView.hidden = NO;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
    
    if (topic.isBigPicture) {
        self.seeBigBtn.hidden = NO;
        self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    } else {
        self.seeBigBtn.hidden = YES;
        self.bgImageView.contentMode = UIViewContentModeScaleToFill;
    }
}

@end
