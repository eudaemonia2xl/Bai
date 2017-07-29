//
//  BSWordViewController.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/7/29.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSWordViewController.h"
#import <AFNetworking.h>

@interface BSWordViewController ()

@end

@implementation BSWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWordData];
}

- (void)loadWordData
{
    NSDictionary *params = @{@"a":@"list",
                             @"c":@"data",
                             @"type":@(29)
                             };
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    return cell;
}
@end
