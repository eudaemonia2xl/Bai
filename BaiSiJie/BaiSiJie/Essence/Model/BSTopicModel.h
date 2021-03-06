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

//是否是新浪会员
@property (assign, nonatomic, getter=isSina_v) BOOL sina_v;

//图片或视频等其他的内容的高度
@property (assign, nonatomic) CGFloat height;

//视频或图片类型帖子的宽度
@property (assign, nonatomic) CGFloat width;

//	string	显示在页面中的视频图片的url
@property (nonatomic, copy) NSString *small_image;
@property (nonatomic, copy) NSString *middle_image;
@property (nonatomic, copy) NSString *large_image;

//帖子类型 帖子的类型，1为全部 10为图片 29为段子 31为音频 41为视频*/
@property (nonatomic, assign) BSTopicType type;

//是否是gif动画
@property (nonatomic, assign) BOOL is_gif;

//播放时长
@property (assign, nonatomic) NSInteger playcount;
//如果为音频类帖子，则返回值为音频的时长
@property (assign, nonatomic) NSInteger voicetime;
//视频加载时候的静态显示的图片地址
@property (copy, nonatomic) NSString *cdn_img;
//如果含有视频则该参数为视频的长度
@property (assign, nonatomic) NSInteger videotime;

/** 最热评论(期望这个数组中存放的是BSComment模型) */
@property (nonatomic, strong) NSArray *top_cmt;

/****** 辅助属性 ******/
//cell高度
@property (nonatomic, assign) CGFloat cellHeight;

//图片的frame
@property (assign, nonatomic) CGRect pictureF;
//声音的frame
@property (assign, nonatomic) CGRect voiceF;
//视频的frame
@property (assign, nonatomic) CGRect videoF;

//是否是大图
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

//记录图片的当前进度
@property (assign, nonatomic) CGFloat pictureProgress;


@end
