//
//  BSLoginRegisterController.m
//  BaiSiJie
//
//  Created by senyint on 2017/7/24.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSLoginRegisterController.h"

@interface BSLoginRegisterController ()

@end

@implementation BSLoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)cancelBtn:(id)sender {
//    self.navigationController是nil,nil肯定无法调用dismissViewControllerAnimated方法，因为self是modal过来的控制器，没有self.navigationController
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
