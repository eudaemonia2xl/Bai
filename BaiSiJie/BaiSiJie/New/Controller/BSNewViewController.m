//
//  BSNewViewController.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/7/10.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSNewViewController.h"

@interface BSNewViewController ()

@end

@implementation BSNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置导航栏左侧按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(click) image:@"MainTagSubIcon" selectedImage:@"MainTagSubIconClick"];
    
    //设置背景色
    self.view.backgroundColor = RGBColor(223, 223, 223);
    
    DLog(@"BSNewViewController");

}

- (void)click
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
