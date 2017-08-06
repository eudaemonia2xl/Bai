//
//  BSPublishViewController.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/8/6.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSPublishViewController.h"
#import "BSVerticalButton.h"

@interface BSPublishViewController ()

@end

@implementation BSPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.y = BSScreenH * 0.15;
    sloganView.centerX = BSScreenW * 0.5;
    [self.view addSubview:sloganView];
    
    //数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    //计算位置
    NSInteger btnCols = 3;
    CGFloat buttonStartX = 15;
    CGFloat buttonW = 72;
    CGFloat buttonH = 72 + 30;
    CGFloat buttonStartY = (BSScreenH - buttonH * 2) * 0.5;
    CGFloat buttonMarginX = (BSScreenW - buttonStartX * 2 - buttonW * btnCols) / (btnCols - 1);
    CGFloat buttonMarginY = 10;
    
    //添加发布的6个按钮
    for (NSInteger i = 0; i < images.count; i++) {
        BSVerticalButton *btn = [BSVerticalButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        NSInteger col = i % btnCols;
        NSInteger row = i / btnCols;
        
        btn.x = buttonStartX + (buttonW + buttonMarginX) * col;
        btn.y = buttonStartY + row * (buttonH + buttonMarginY);
        btn.width = buttonW;
        btn.height = buttonH;
        
        [self.view addSubview:btn];
    }
    
}

- (IBAction)cancelClick {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
