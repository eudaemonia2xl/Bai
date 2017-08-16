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
#import "BSTopicViewModel.h"
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>

@interface BSTopicViewController ()

//viewmodel
@property (strong, nonatomic) BSTopicViewModel *topicViewModel;

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

    [self.topicViewModel loadNewTopicDataSuccess:^{

        //刷新表格
        [self.tableView reloadData];

        //结束加载新的数据
        [self.tableView.mj_header endRefreshing];

    } failure:^{
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
    
    [self.topicViewModel loadMoreTopicDataSuccess:^{
        //刷新表格
        [self.tableView reloadData];

        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^{
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topicViewModel.wordsArray.count == 0);
    return self.topicViewModel.wordsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BSTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicID forIndexPath:indexPath];
    
    BSTopicModel *topic = self.topicViewModel.wordsArray[indexPath.row];
    
    cell.topic = topic;
    
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSTopicModel *topic = self.topicViewModel.wordsArray[indexPath.row];
    
    return topic.cellHeight;
}

- (BSTopicViewModel *)topicViewModel
{
    if (!_topicViewModel) {
        _topicViewModel = [[BSTopicViewModel alloc] init];
        _topicViewModel.type = self.type;
    }
    return _topicViewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
