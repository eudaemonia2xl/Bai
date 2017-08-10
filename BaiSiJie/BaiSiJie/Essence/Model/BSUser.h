//
//  BSUser.h
//  BaiSiJie
//
//  Created by senyint on 2017/8/10.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSUser : NSObject
/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
@end
