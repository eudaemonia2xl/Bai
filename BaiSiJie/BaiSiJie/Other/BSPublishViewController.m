//
//  BSPublishViewController.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/8/6.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSPublishViewController.h"
#import "BSVerticalButton.h"
#import <POP.h>

@interface BSPublishViewController ()

@property (nonatomic, strong) UIImageView *sloganView;

@end

@implementation BSPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.userInteractionEnabled = NO;
    
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
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i * 100 + 2;
        
        //计算x/y
        NSInteger col = i % btnCols;
        NSInteger row = i / btnCols;
        CGFloat buttonEndY = buttonStartY + row * (buttonH + buttonMarginY);
        CGFloat buttonEndX = buttonStartX + (buttonW + buttonMarginX) * col;
        CGFloat buttonBeginY = buttonEndY - BSScreenH;
        
        [self.view addSubview:btn];
        
        // 按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonStartX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonEndX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = 10;
        anim.springSpeed = 10;
        anim.beginTime = CACurrentMediaTime() + 0.1 * i;
        [btn pop_addAnimation:anim forKey:nil];
    }
    //添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    CGFloat centerX = BSScreenW * 0.5;
    sloganView.y = BSScreenH * 0.15 - BSScreenH;
    [self.view addSubview:sloganView];
    
    //标语动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, BSScreenH * 0.15 - BSScreenH)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, BSScreenH * 0.15)];
    anim.springBounciness = 10;
    anim.springSpeed = 10;
    anim.beginTime = CACurrentMediaTime() + images.count * 0.1;
    [sloganView pop_addAnimation:anim forKey:nil];
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        self.view.userInteractionEnabled = YES;
    }];
}

- (void)buttonClick:(UIButton *)sender
{
    //点击按钮是先执行退出动画然后弹出发视频
    [self dismissViewCompletionBlock:^{
        if (sender.tag == 2) {
            DLog(@"发视频");
        } else if (sender.tag == 102){
            DLog(@"发图片");
        }
    }];
}

- (IBAction)cancelClick {
    [self dismissViewCompletionBlock:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewCompletionBlock:nil];
}

- (void)dismissViewCompletionBlock:(void (^)())completionBlock
{
    for (NSInteger idx = 2; idx < self.view.subviews.count; idx++) {
        UIView *view = self.view.subviews[idx];
        //基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = view.centerY + BSScreenH;
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(view.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (idx - 2) * 0.1;
        [view pop_addAnimation:anim forKey:nil];
        
        if (idx == (self.view.subviews.count - 1)) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                if (completionBlock) {
                    completionBlock();
                }
            }];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
