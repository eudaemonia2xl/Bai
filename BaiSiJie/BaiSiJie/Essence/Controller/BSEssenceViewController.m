//
//  BSEssenceViewController.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/7/10.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSEssenceViewController.h"
#import "BSRecommandTagViewController.h"
#import "BSAllViewController.h"
#import "BSVideoViewController.h"
#import "BSVoiceViewController.h"
#import "BSPictureViewController.h"
#import "BSWordViewController.h"

@interface BSEssenceViewController ()<UIScrollViewDelegate>

//标示当前选中的button
@property (strong, nonatomic) UIView *indicatorView;
//记录当前选中的button
@property (strong, nonatomic) UIButton *selectedBtn;

//创建标签栏背景
@property (strong, nonatomic) UIView *bgView;
//创建scrollView
@property (strong, nonatomic) UIScrollView *contentScrollView;

@end

@implementation BSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNav];
    
    //添加子控制器
    [self addChildVCs];
    
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
    bgView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.6];
    self.bgView = bgView;
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
        titleBtn.tag = (i + 1) * 10;
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
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * contentScrollView.width, self.view.height);
    contentScrollView.delegate = self;
    contentScrollView.pagingEnabled = YES;
    //设置内边距，可以让用户能够看到完整的内容
//    contentScrollView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(self.bgView.frame), 0, self.tabBarController.tabBar.height, 0);

    [self.view insertSubview:contentScrollView atIndex:0];
    
    self.contentScrollView = contentScrollView;
    
    //第一次调用时，显示第一个控制器
    [self scrollViewDidEndScrollingAnimation:contentScrollView];
}

//添加子控制器
- (void)addChildVCs
{
    BSAllViewController *all = [[BSAllViewController alloc] init];
    [self addChildViewController:all];
    
    BSVideoViewController *video = [[BSVideoViewController alloc] init];
    [self addChildViewController:video];
    
    BSVoiceViewController *voice = [[BSVoiceViewController alloc] init];
    [self addChildViewController:voice];
    
    BSPictureViewController *picture = [[BSPictureViewController alloc] init];
    [self addChildViewController:picture];
    
    BSWordViewController *word = [[BSWordViewController alloc] init];
    [self addChildViewController:word];
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
    
    //scrollView滚动
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = self.view.width * (sender.tag / 10 - 1);
//    self.contentScrollView.contentOffset = offset;
    //只有这么设置scrollView的contentOffset，才会走scrollView的scrollViewDidEndScrollingAnimation代理方法
    [self.contentScrollView setContentOffset:offset animated:YES];
}

- (void)click
{
    BSRecommandTagViewController *vc = [[BSRecommandTagViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIScrollViewDelegate
//当scrollView滚动结束时调用此方法，前提是设置scrollView的contentOffset是用[self.contentScrollView setContentOffset:offset animated:YES];这种方式实现
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //首先获取到索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    //取出子控制器
    UITableViewController *tableVC = self.childViewControllers[index];
    tableVC.view.frame = CGRectMake(scrollView.contentOffset.x, 0, self.view.width, scrollView.height);
    
    //设置tableView的内边距
    CGFloat top = CGRectGetMaxY(self.bgView.frame);

    CGFloat bottom = self.tabBarController.tabBar.height;
    tableVC.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    // 设置滚动条的内边距
    tableVC.tableView.scrollIndicatorInsets = tableVC.tableView.contentInset;
    [scrollView addSubview:tableVC.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
