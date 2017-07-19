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

@end

static NSString *categoryID = @"category";
static NSString *userID = @"user";
@implementation BSRecommendController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 控件的初始化
    [self configTableView];
    
    // 添加刷新控件
    [self configRefresh];
    
    // 显示指示器
    [SVProgressHUD show];
    
    // 发送请求
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSDictionary *dict = @{@"a":@"category",
                           @"c":@"subscribe"};
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        // 服务器返回的JSON数据 字典数组->模型数组
        NSArray *modelArr = [BSRecommandCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoriesArray addObjectsFromArray:modelArr];

         // 刷新表格
        [self.categoryTableView reloadData];
        
        //默认选中第一行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
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
    BSRecommandCategory *category = self.categoriesArray[self.categoryTableView.indexPathForSelectedRow.row];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 发送请求给服务器, 加载右侧的数据
        NSDictionary *dict = @{@"a":@"list",
                               @"c":@"subscribe",
                               @"category_id":@(category.ID),
                               @"page":@(++category.currentPage)};
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 字典数组 -> 模型数组
            NSArray *tempArray = [BSRecommandUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
            // 添加到当前类别对应的用户数组中
            [category.users addObjectsFromArray:tempArray];
            
            // 刷新右边的表格
            [self.userTableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DLog(@"%@",error);
        }];

    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.categoriesArray.count > 0 ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {// 左边的类别表格
        return self.categoriesArray.count;
    } else {// 右边的用户表格
        // 左边被选中的类别模型
        NSLog(@"%@",self.categoriesArray);
        BSRecommandCategory *category = self.categoriesArray[self.categoryTableView.indexPathForSelectedRow.row];
        return category.users.count;
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
    BSRecommandCategory *category = self.categoriesArray[indexPath.row];
    if (category.users.count) {
        // 显示曾经的数据
        [self.userTableView reloadData];
    }else{
        [self.userTableView reloadData];
        // 发送请求给服务器, 加载右侧的数据
        NSDictionary *dict = @{@"a":@"list",
                               @"c":@"subscribe",
                               @"category_id":@(category.ID),
                               @"page":@(1)};
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 字典数组 -> 模型数组
            NSArray *tempArray = [BSRecommandUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
            // 添加到当前类别对应的用户数组中
            [category.users addObjectsFromArray:tempArray];
            
            // 刷新右边的表格
            [self.userTableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DLog(@"%@",error);
        }];

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
