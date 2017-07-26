//
//  BSLoginRegisterController.m
//  BaiSiJie
//
//  Created by senyint on 2017/7/24.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSLoginRegisterController.h"

@interface BSLoginRegisterController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation BSLoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    DLog(@"%@", self.view.subviews);
}
- (IBAction)cancelBtn:(id)sender {
//    self.navigationController是nil,nil肯定无法调用dismissViewControllerAnimated方法，因为self是modal过来的控制器，没有self.navigationController
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)loginRegisterBtn:(UIButton *)sender {
    
    [self.view endEditing:YES];
    if (sender.selected == YES) {
        self.loginViewLeftMargin.constant = 0;
        sender.selected = NO;
    } else {
        sender.selected = YES;
        self.loginViewLeftMargin.constant = -self.view.width;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

/**
 * 设置状态栏颜色为白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
