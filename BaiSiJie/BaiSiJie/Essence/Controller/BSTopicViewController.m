//
//  BSTopicViewController.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/7/29.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSTopicViewController.h"
#import "BSTopicModel.h"
#import "BSTopicCell.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import <MJRefresh.h>

@interface BSTopicViewController ()

//数据源数组，放段子数据
@property (strong, nonatomic) NSMutableArray *wordsArray;

//每次加载下一页的时候，需要传入上一页返回参数中对应的此内容
@property (copy, nonatomic) NSString *maxtime;

//当前段子页数，用于加载更多数据时使用
@property (assign, nonatomic) NSInteger currentPage;

@property (strong, nonatomic) NSDictionary *params;

@end

static NSString *topicID = @"BSTopicCell";
@implementation BSTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupRefresh];
}

- (void)setupTableView
{
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置tableView的内边距
    CGFloat top = CGRectGetMaxY(self.navigationController.navigationBar.frame) + 44;
    
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSTopicCell class]) bundle:nil] forCellReuseIdentifier:topicID];
}

#pragma mark - 添加header/footer的刷新控件，加载最新、更多数据
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //一点击页面，就开始刷新
    [self.tableView.mj_header beginRefreshing];
    
    //设置刷新控件的透明度
    [self.tableView.mj_header setAutomaticallyChangeAlpha:YES];
    
    //添加footer
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

/**
 * 加载最新的数据
 */
- (void)loadNewData
{
    [self.tableView.mj_footer endRefreshing];
    _currentPage = 0;
    NSDictionary *params = @{@"a":@"list",
                             @"c":@"data",
                             @"type":@(self.type)
                             };
    self.params = params;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) {
            return ;
        }
        [responseObject writeToFile:@"/Users/senyint/Desktop/tiezi.plist" atomically:YES ];
        //移除旧数据
        if (self.wordsArray.count != 0) {
            [self.wordsArray removeAllObjects];
        }
        
        //字典 -> 模型数组
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *wordArray = [BSTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //保存到数据源数组中
        [self.wordsArray addObjectsFromArray:wordArray];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束加载新的数据
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) {
            return ;
        }
        //结束加载新的数据
        [self.tableView.mj_header endRefreshing];
    }];
}

/**
 * 加载更多数据
 */
- (void)loadMoreData
{
    [self.tableView.mj_header endRefreshing];
    _currentPage++;
    if (self.maxtime == nil) {
        self.maxtime = @"";
    }
    NSDictionary *params = @{@"a":@"list",
                             @"c":@"data",
                             @"type":@(self.type),
                             @"page":@(_currentPage),
                             @"maxtime":self.maxtime};
    self.params = params;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) {
            return ;
        }
        
        //每次刷新都需要重新存一下maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典 -> 模型数组
        NSArray *wordArray = [BSTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //保存到数据源数组中
        [self.wordsArray addObjectsFromArray:wordArray];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //如果失败，++之后的currentPage要变回原值
        _currentPage--;
        if (self.params != params) {
            return ;
        }
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.wordsArray.count == 0);
    return self.wordsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BSTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicID forIndexPath:indexPath];
    
    BSTopicModel *topic = self.wordsArray[indexPath.row];
    
    cell.topic = topic;
    
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSTopicModel *topic = self.wordsArray[indexPath.row];
    
    return topic.cellHeight;
}

- (NSMutableArray *)wordsArray
{
    if (_wordsArray == nil) {
        _wordsArray = [NSMutableArray array];
    }
    return _wordsArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
