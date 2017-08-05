//
//  BSShowPictureViewController.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/8/3.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSShowPictureViewController.h"
#import "BSTopicModel.h"
#import <UIImageView+WebCache.h>

@interface BSShowPictureViewController ()

//图片
@property (nonatomic, strong) UIImageView *bgImageView;
//存放图片的scrollView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation BSShowPictureViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    _bgImageView = [[UIImageView alloc] init];
    [self.scrollView addSubview:_bgImageView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    [_bgImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)]];
    
    CGFloat pictureW = screenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    if (pictureH > screenW) {
        _bgImageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        _scrollView.contentSize = CGSizeMake(0, pictureH);
    }else {
        _bgImageView.size = CGSizeMake(pictureW, pictureH);
        _bgImageView.centerY = screenH * 0.5;
    }
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:_topic.large_image]];
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
