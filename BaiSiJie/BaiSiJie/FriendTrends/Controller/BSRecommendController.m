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
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"推荐关注";
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    
    //从nib中注册cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSCategoryCell class]) bundle:nil] forCellReuseIdentifier:categoryID];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSUserCell class]) bundle:nil] forCellReuseIdentifier:userID];
    
    self.view.backgroundColor = RGBColor(223, 12, 240);
    
    [SVProgressHUD show];
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSDictionary *dict = @{@"a":@"category",
                           @"c":@"subscribe"};
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *modelArr = [BSRecommandCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoriesArray addObjectsFromArray:modelArr];
        
        [SVProgressHUD dismiss];
        [self.categoryTableView reloadData];
        
        //默认选中第一行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",error]];
    }];
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
    if (tableView == self.categoryTableView) {
        BSCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryID];
        cell.category = self.categoriesArray[indexPath.row];
        return cell;
    } else {
        BSRecommandCategory *category = self.categoriesArray[self.categoryTableView.indexPathForSelectedRow.row];
        BSUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userID];
        cell.user = category.users[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSRecommandCategory *category = self.categoriesArray[indexPath.row];
    if (category.users.count) {// 显示曾经的数据
        [self.userTableView reloadData];
    }else{
        NSDictionary *dict = @{@"a":@"list",
                               @"c":@"subscribe",
                               @"category_id":@(category.ID),
                               @"page":@(1)};
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *tempArray = [BSRecommandUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [category.users addObjectsFromArray:tempArray];
            
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
