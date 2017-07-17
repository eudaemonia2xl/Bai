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

@interface BSRecommendController ()<UITableViewDelegate,UITableViewDataSource>

//左侧数据源数组
@property (nonatomic, strong) NSMutableArray *categoriesArray;
/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@end

@implementation BSRecommendController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"推荐关注";
    
    self.view.backgroundColor = RGBColor(223, 12, 240);
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSDictionary *dict = @{@"a":@"category",
                           @"c":@"subscribe"};
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _categoriesArray = [NSMutableArray arrayWithArray:responseObject[@"list"]];
        DLog(@"%@",_categoriesArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoriesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identify"];
    return nil;
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
