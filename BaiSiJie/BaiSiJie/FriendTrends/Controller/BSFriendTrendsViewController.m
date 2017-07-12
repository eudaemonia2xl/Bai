//
//  BSFriendTrendsViewController.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/7/10.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSFriendTrendsViewController.h"

@interface BSFriendTrendsViewController ()

@end

@implementation BSFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的关注";

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(click) image:@"friendsRecommentIcon" selectedImage:@"friendsRecommentIcon-click"];
    
    //设置背景色
    self.view.backgroundColor = RGBColor(223, 223, 223);
    
    DLog(@"BSFriendTrendsViewController");

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
