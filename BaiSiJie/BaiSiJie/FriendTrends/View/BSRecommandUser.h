//
//  BSRecommandUser.h
//  BaiSiJie
//
//  Created by senyint on 2017/7/18.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSRecommandUser : NSObject

//头像url
@property (nonatomic, copy) NSString *header;
//screen_name
@property (nonatomic, copy) NSString *screen_name;
//粉丝数
@property (nonatomic, assign) NSInteger fans_count;


@end
