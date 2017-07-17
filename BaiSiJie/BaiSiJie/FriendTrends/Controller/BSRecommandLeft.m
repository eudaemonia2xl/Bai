//
//  BSRecommandLeft.m
//  BaiSiJie
//
//  Created by senyint on 2017/7/17.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSRecommandLeft.h"
#import "MJExtension.h"

@implementation BSRecommandLeft

+ (instancetype)recommandWithDict:(NSDictionary *)dict
{
    BSRecommandLeft *recommand = [[self alloc] init];
    
    return recommand;
}

+ (void)load
{
    [self mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
}

@end
