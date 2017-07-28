//
//  BSEssenceViewController.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/7/10.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSEssenceViewController.h"
#import "BSRecommandTagViewController.h"

@interface BSEssenceViewController ()

//标示当前选中的button
@property (strong, nonatomic) UIView *indicatorView;
//记录当前选中的button
@property (strong, nonatomic) UIButton *selectedBtn;

@end

@implementation BSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNav];
    
    //设置标签栏
    [self setupTab];
    
    //设置scrollView
    [self setupScrollView];
}

- (void)setupNav
{
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置导航栏左侧按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(click) image:@"MainTagSubIcon" selectedImage:@"MainTagSubIconClick"];
    
    //设置背景色
    self.view.backgroundColor = RGBColor(223, 223, 223);
}


//纯代码方式创建标签栏
- (void)setupTab
{
    //创建标签栏背景
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 44)];
    bgView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    [self.view addSubview:bgView];
    
    //创建底部红色指示view
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
    CGFloat indicatorViewH = 5;
    indicatorView.height = indicatorViewH;
    indicatorView.y = bgView.height - indicatorViewH;
    self.indicatorView = indicatorView;
    [bgView addSubview:indicatorView];
    
    //创建按钮
    NSArray *titles = @[@"全部全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat titleBtnX = 0;
    CGFloat titleBtnY = 0;
    CGFloat titleBtnW = bgView.width / 5;
    CGFloat titleBtnH = bgView.height - 5;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtnX = titleBtnW * i;
        titleBtn.frame = CGRectMake(titleBtnX, titleBtnY, titleBtnW, titleBtnH);
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[[UIColor redColor] colorWithAlphaComponent:0.7] forState:UIControlStateDisabled];
        [titleBtn addTarget:self action:@selector(tabBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:titleBtn];
        
        //默认选中的是第一个按钮
        if (i == 0) {
            titleBtn.enabled = NO;
            self.selectedBtn = titleBtn;
            
            //应该先设置indicatorView的宽度再设置centerX，否则第一次计算centerX会有问题
            [titleBtn.titleLabel sizeToFit];
            self.indicatorView.width = titleBtn.titleLabel.width;
            self.indicatorView.centerX = titleBtn.centerX;
        }
    }

}

- (void)setupScrollView
{
    DLog(@"fgsdf");
    UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    
    contentScrollView.contentSize = CGSizeMake(self.view.width, 800);
    
    [self.view insertSubview:contentScrollView atIndex:0];
    UISwitch *s = [[UISwitch alloc] init];
    s.y = 50;
    [contentScrollView addSubview:s];
    
    
}

//页签栏中按钮的点击事件
- (void)tabBtnClick:(UIButton *)sender
{
    //修改按钮的状态
    self.selectedBtn.enabled = YES;
    sender.enabled = NO;
    self.selectedBtn = sender;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = sender.titleLabel.width;
        self.indicatorView.centerX = sender.centerX;
    }];
}

- (void)click
{
    BSRecommandTagViewController *vc = [[BSRecommandTagViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
