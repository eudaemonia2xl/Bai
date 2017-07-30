//
//  BSWordViewController.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/7/29.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSWordViewController.h"
#import "BSWordModel.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import <MJRefresh.h>

@interface BSWordViewController ()

//数据源数组，放段子数据
@property (strong, nonatomic) NSMutableArray *wordsArray;

//每次加载下一页的时候，需要传入上一页返回参数中对应的此内容
@property (copy, nonatomic) NSString *maxtime;

//当前段子页数，用于加载更多数据时使用
@property (assign, nonatomic) NSInteger currentPage;

@property (strong, nonatomic) NSDictionary *params;

@end

@implementation BSWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRefresh];
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
                             @"type":@(29)
                             };
    self.params = params;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) {
            return ;
        }
        
        //移除旧数据
        if (self.wordsArray.count != 0) {
            [self.wordsArray removeAllObjects];
        }
        
        //字典 -> 模型数组
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *wordArray = [BSWordModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
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
                             @"type":@(29),
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
        NSArray *wordArray = [BSWordModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
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
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
    }
    BSWordModel *model = self.wordsArray[indexPath.row];
    
    cell.textLabel.text = model.screen_name;
    cell.detailTextLabel.text = model.text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    return cell;
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
