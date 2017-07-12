//
//  BSMeViewController.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/7/10.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSMeViewController.h"

@interface BSMeViewController ()

@end

@implementation BSMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    
    self.navigationItem.rightBarButtonItems = @[
    [UIBarButtonItem itemWithTarget:self action:@selector(settingClick) image:@"mine-setting-icon" selectedImage:@"mine-setting-icon-click"],
    [UIBarButtonItem itemWithTarget:self action:@selector(moonClick) image:@"mine-moon-icon-click" selectedImage:@"mine-moon-icon-click-click"]];
    
    //设置背景色
    self.view.backgroundColor = RGBColor(223, 223, 223);
    
    DLog(@"BSMeViewController");
}

- (void)settingClick
{
    DLog(@"%s",__func__);
}

- (void)moonClick
{
    DLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
