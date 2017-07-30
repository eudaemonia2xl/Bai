//
//  BSWordModel.h
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/7/30.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSTopicModel : NSObject

//头像的图片url地址
@property (copy, nonatomic) NSString *profile_image;

//发帖人的昵称
@property (copy, nonatomic) NSString *name;

//转发的数量
@property (copy, nonatomic) NSString *repost;

//帖子的收藏量
@property (copy, nonatomic) NSString *favourite;

//踩的人数
@property (copy, nonatomic) NSString *cai;

//收藏量
@property (copy, nonatomic) NSString *ding;

//帖子的被评论数量
@property (copy, nonatomic) NSString *comment;

//帖子的内容
@property (copy, nonatomic) NSString *text;

//帖子的标签备注
@property (copy, nonatomic) NSString *tag;

//系统审核通过后创建帖子的时间
@property (copy, nonatomic) NSString *created_at;

@end