//
//  BSRecommandTagViewController.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/7/22.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSRecommandTagViewController.h"
#import "BSRecommandTag.h"
#import "BSRecommandTagCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

@interface BSRecommandTagViewController ()
//订阅人数模型数组
@property (strong, nonatomic) NSArray *tagsArray;
@end

static NSString *BSTagId = @"tag";
@implementation BSRecommandTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configTableView];
    
    [self loadRecommandTagData];
}

- (void)configTableView
{
    self.navigationItem.title = @"推荐关注";
    
    self.tableView.rowHeight = 70;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = RGBColor(244, 244, 244);
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSRecommandTagCell class]) bundle:nil] forCellReuseIdentifier:BSTagId];
}

- (void)loadRecommandTagData
{
    [SVProgressHUD show];
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{@"a":@"tag_recommend",
                             @"action":@"sub",
                             @"c":@"topic",
                             };
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSArray *tagsArray = [BSRecommandTag mj_objectArrayWithKeyValuesArray:responseObject];
        _tagsArray = tagsArray;
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载订阅数据失败"];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tagsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSRecommandTagCell *cell = [tableView dequeueReusableCellWithIdentifier:BSTagId forIndexPath:indexPath];
    
    cell.recommandTag = self.tagsArray[indexPath.row];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
