//
//  BSEssenceViewController.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/7/10.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSEssenceViewController.h"

@interface BSEssenceViewController ()

@end

@implementation BSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置导航栏左侧按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(click) image:@"MainTagSubIcon" selectedImage:@"MainTagSubIconClick"];
    
    //设置背景色
    self.view.backgroundColor = RGBColor(223, 223, 223);
    DLog(@"BSEssenceViewController");
}

- (void)click
{
    DLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
