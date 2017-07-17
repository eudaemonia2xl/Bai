//
//  BSFriendTrendsViewController.m
//  BaiSiJie
//
//  Created by senyint on 2017/7/17.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSFriendTrendsViewController.h"
#import "BSRecommendController.h"

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
    BSRecommendController *recommendVC = [[BSRecommendController alloc] init];
    [self.navigationController pushViewController:recommendVC animated:YES];
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
