//
//  BSTopicViewModel.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/8/16.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSTopicViewModel.h"
#import "BSTopicModel.h"
#import <AFHTTPSessionManager.h>
#import <MJExtension.h>
#import <AFNetworking.h>

@interface BSTopicViewModel ()

@property (assign, nonatomic) NSInteger currentPage;

@property (strong, nonatomic) NSDictionary *params;
//每次加载下一页的时候，需要传入上一页返回参数中对应的此内容
@property (copy, nonatomic) NSString *maxtime;

@end

@implementation BSTopicViewModel

- (void)loadNewTopicDataSuccess:(void (^)())success failure:(void (^)())failure
{
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

        //移除旧数据
        if (self.wordsArray.count != 0) {
            [self.wordsArray removeAllObjects];
        }

        //字典 -> 模型数组
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *wordArray = [BSTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        //保存到数据源数组中
        [self.wordsArray addObjectsFromArray:wordArray];

        success();
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) {
            return ;
        }
        failure();
    }];
}

- (void)loadMoreTopicDataSuccess:(void (^)())success failure:(void (^)())failure
{
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
        
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //如果失败，++之后的currentPage要变回原值
        _currentPage--;
        if (self.params != params) {
            return ;
        }
        failure();
    }];

}

- (NSMutableArray *)wordsArray
{
    if (!_wordsArray) {
        _wordsArray = [NSMutableArray array];
    }
    return _wordsArray;
}

@end
