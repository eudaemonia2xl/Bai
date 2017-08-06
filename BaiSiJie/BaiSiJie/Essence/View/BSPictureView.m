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
#import "BSProgressView.h"
#import <UIImageView+WebCache.h>

@interface BSPictureView ()

@property (weak, nonatomic) IBOutlet UIButton *seeBigBtn;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet BSProgressView *progressView;
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

    // 立马显示最新的进度值(防止因为网速慢, 导致显示的是其他图片的下载进度)
    [self.progressView setProgress:topic.pictureProgress animated:YES];
    
    //再次下载图片时，会自动调用block
    [self.bgImageView sd_cancelCurrentImageLoad];

 
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {

        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        
        [self.progressView setProgress:topic.pictureProgress animated:YES];
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
