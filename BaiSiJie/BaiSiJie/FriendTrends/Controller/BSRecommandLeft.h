//
//  BSRecommandLeft.h
//  BaiSiJie
//
//  Created by senyint on 2017/7/17.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSRecommandLeft : NSObject

//count : 7,
//id : 36,
//name : 精品
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *name;

+ (instancetype)recommandWithDict:(NSDictionary *)dict;

@end
