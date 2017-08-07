//
//  BSShowPictureViewController.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/8/3.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSShowPictureViewController.h"
#import "BSTopicModel.h"
#import "BSProgressView.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface BSShowPictureViewController ()

//图片
@property (nonatomic, strong) UIImageView *bgImageView;
//存放图片的scrollView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet BSProgressView *progressView;
 
@end

@implementation BSShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加图片
    _bgImageView = [[UIImageView alloc] init];
    _bgImageView.userInteractionEnabled = YES;
    [self.scrollView addSubview:_bgImageView];
    [_bgImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)]];
    
    //图片尺寸
    CGFloat pictureW = BSScreenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    if (pictureH > BSScreenH) { // 图片显示高度超过一个屏幕, 需要滚动查看
        _bgImageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        _scrollView.contentSize = CGSizeMake(0, pictureH);
    }else {
        _bgImageView.size = CGSizeMake(pictureW, pictureH);
        _bgImageView.centerY = BSScreenH * 0.5;
    }
    
    //防止图片下载过程中，用户点击图片，查看大图时，进度条能够接着点击之前的进度值显示
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    
    //显示图片
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:_topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        //设置进度条
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];

    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}

/**
 * 返回按钮
 */
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 * 保存按钮
 */
- (IBAction)saveImage:(id)sender {
    //将图片保存到系统相册
    UIImageWriteToSavedPhotosAlbum(self.bgImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

//将图片保存到系统相册，系统建议调用的方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败！"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功！"];
    }
}

/**
 * 转发按钮
 */
- (IBAction)repost:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
