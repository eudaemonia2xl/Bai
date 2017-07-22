//
//  BSRecommendController.m
//  BaiSiJie
//
//  Created by senyint on 2017/7/17.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSRecommendController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension/MJExtension.h>
#import "BSRecommandCategory.h"
#import "BSCategoryCell.h"
#import "BSUserCell.h"
#import "BSRecommandUser.h"
#import <MJRefresh.h>

@interface BSRecommendController ()<UITableViewDelegate,UITableViewDataSource>

//左侧数据源数组
@property (nonatomic, strong) NSMutableArray *categoriesArray;
//右侧数据源数组
//@property (nonatomic, strong) NSMutableArray *usersArray;
/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右边的用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

//中间变量：用户多次点击后，记录最后一次请求的请求参数
@property (strong, nonatomic) NSDictionary *params;

//全局用一个manager,防止用户等不及请求结果，直接返回，控制器销毁后导致崩溃
@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

static NSString *categoryID = @"category";
static NSString *userID = @"user";
@implementation BSRecommendController

/*
   因为右侧数据公用一个tableView，所以会有很多细节问题：
    1.重复下载数据的问题
    2.类别切换后，右侧tableView的footer状态的改变要时刻监测问题
    3.加载多页数据问题:每次下拉刷新时，数据追加之前要移除之前的旧数据

    4.网络加载慢时的问题，用户连续点击多次，只处理最后一次点击：可以通过判断现在的请求参数与之前的请求参数是否一致，所以就需要一个中间变量记录最新的请求参数，self.params == params??

    5.请求数据过程中，直接返回，控制器销毁，可能导致崩溃。所以就将AFHTTPSessionManager设置为懒加载形式，全局用这一个manager，因为每次创建操作后会把请求放在self.manager.operationQueue中
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 控件的初始化
    [self configTableView];
    
    // 添加刷新控件
    [self configRefresh];
    
    //加载左侧类别数据
    [self loadCategoryData];
}

- (void)loadCategoryData
{
    // 显示指示器
    [SVProgressHUD show];
    // 发送请求
    NSDictionary *dict = @{@"a":@"category",
                           @"c":@"subscribe"};
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        // 服务器返回的JSON数据 字典数组->模型数组
        NSArray *modelArr = [BSRecommandCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoriesArray addObjectsFromArray:modelArr];
        
        // 刷新表格
        [self.categoryTableView reloadData];
        
        //默认选中第一行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        //开始刷新右侧用户数据
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",error]];
    }];
}

- (void)configTableView
{
    //设置标题
    self.navigationItem.title = @"推荐关注";
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    
    //从nib中注册cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSCategoryCell class]) bundle:nil] forCellReuseIdentifier:categoryID];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSUserCell class]) bundle:nil] forCellReuseIdentifier:userID];
    
    //设置背景色
    self.view.backgroundColor = RGBColor(223, 12, 240);
}

- (void)configRefresh
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
}

/**
 *  功能介绍:刷新最新的数据
 */
- (void)loadNewUsers
{
    BSRecommandCategory *category = self.categoriesArray[self.categoryTableView.indexPathForSelectedRow.row];
    category.currentPage = 1;
    // 发送请求给服务器, 加载右侧的最新数据
    NSDictionary *dict = @{@"a":@"list",
                           @"c":@"subscribe",
                           @"category_id":@(category.ID),
                           @"page":@(category.currentPage)};
    self.params = dict;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        // 字典数组 -> 模型数组
        NSArray *tempArray = [BSRecommandUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //删除以前的旧数据
        [category.users removeAllObjects];
        
        // 添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:tempArray];
        
        //保存总数
        category.total = [responseObject[@"total"] integerValue];
        
        //不是最后一次请求数据
        if (self.params != dict) {
            return ;
        }
        
        // 刷新右边的表格
        [self.userTableView reloadData];

        [self.userTableView.mj_header endRefreshing];

        //检查第一页数据有没有显示完
        [self checkFooterStatus];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.params != dict) {
            return ;
        }
        [SVProgressHUD showErrorWithStatus:@"请求最新数据失败"];
        //停止刷新
        [self.userTableView.mj_header endRefreshing];
    }];

}

- (void)loadMoreUsers
{
    DLog(@"%s",__func__);
    BSRecommandCategory *category = self.categoriesArray[self.categoryTableView.indexPathForSelectedRow.row];
    // 发送请求给服务器, 加载右侧的数据
    NSDictionary *dict = @{@"a":@"list",
                           @"c":@"subscribe",
                           @"category_id":@(category.ID),
                           @"page":@(++category.currentPage)};
    self.params = dict;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     
        // 字典数组 -> 模型数组
        NSArray *tempArray = [BSRecommandUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:tempArray];
        
        //不是最后一次请求数据
        if (self.params != dict) {
            return ;
        }
        
        // 刷新右边的表格
        [self.userTableView reloadData];

        //停止刷新
        [self checkFooterStatus];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != dict) {
            return ;
        }
        [SVProgressHUD showErrorWithStatus:@"请求最新数据失败"];
        //停止刷新
        [self.userTableView.mj_header endRefreshing];
    }];

}

/**
 * 时刻检测右侧footer的状态
 */
- (void)checkFooterStatus
{
    BSRecommandCategory *category = self.categoriesArray[self.categoryTableView.indexPathForSelectedRow.row];
    
    //每次刷新右边数据时, 都控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden = (category.users.count == 0);
    
    if (category.users.count == category.total) { //数据加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    } else {//数据没有加载完毕，等待下次刷新
        [self.userTableView.mj_footer endRefreshing];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {// 左边的类别表格
        return self.categoriesArray.count;
    } else {// 右边的用户表格
        // 左边被选中的类别模型
        if (self.categoriesArray.count > self.categoryTableView.indexPathForSelectedRow.row) {
            [self checkFooterStatus];
            
            BSRecommandCategory *category = self.categoriesArray[self.categoryTableView.indexPathForSelectedRow.row];
        
            return category.users.count;
        }else {
            return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {// 左边的类别表格
        BSCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryID];
        cell.category = self.categoriesArray[indexPath.row];
        return cell;
    } else {// 右边的用户表格
        BSRecommandCategory *category = self.categoriesArray[self.categoryTableView.indexPathForSelectedRow.row];
        BSUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userID];
        cell.user = category.users[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        [self.userTableView.mj_header endRefreshing];
        [self.userTableView.mj_footer endRefreshing];
        BSRecommandCategory *category = self.categoriesArray[indexPath.row];
        if (category.users.count) {
            // 显示曾经的数据
            [self.userTableView reloadData];
        }else{
            //这次刷新表格是为了当网络较慢时，数据还是显示在点击之前的类别数据
            [self.userTableView reloadData];
            
            //开始刷新
            [self.userTableView.mj_header beginRefreshing];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        return 44;
    }else {
        return 70;
    }
}

- (void)dealloc
{
    //取消所有操作
    [self.manager.operationQueue cancelAllOperations];
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (NSMutableArray *)categoriesArray
{
    if (_categoriesArray == nil) {
        _categoriesArray = [NSMutableArray array];
    }
    return _categoriesArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
