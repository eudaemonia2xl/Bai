//
//  BSWordModel.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/7/30.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSTopicModel.h"
#import "NSDate+BSExtension.h"
#import "MJExtension.h"

@implementation BSTopicModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"small_image":@"image0",
             @"middle_image":@"image1",
             @"large_image":@"image2"
             };
}

/**
 今年
    今天
        1分钟内
            刚刚
        1小时内
            xx分钟前
        其他
            xx小时前
    昨天
        昨天 18:56:34
    其他
        06-23 19:56:23
 
 非今年
    2014-05-08 18:45:30
 */
/**
 * 直接在返回时间设置的get方法里，调整时间格式
 */
- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [fmt dateFromString:_created_at];
    if ([createDate isThisYear]) { //今年
        if ([createDate isToday]) {//今天
            NSDateComponents *cmps = [[NSDate date] deltaFormDate:createDate];
            if (cmps.hour >= 1) { //大于1小时
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            } else if (cmps.minute >= 1) { //大于1分钟
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            } else { //刚刚
                return @"刚刚";
            }
        } else if ([createDate isYesterday]) {//昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else {//其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createDate];
        }
    }else {//非今年
        return _created_at;
    }
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        CGFloat contentLabelW = [UIScreen mainScreen].bounds.size.width - 4 * BSTopicCellMargin;
        CGFloat contentLabelH = [_text boundingRectWithSize:CGSizeMake(contentLabelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        
        //文字的高度
        _cellHeight = BStopicCellTextY + contentLabelH + BSTopicCellMargin;
        
        if (self.type == BSTopicTypePicture) {//图片帖子
            CGFloat pictureW = contentLabelW;
            CGFloat pictureH = pictureW * self.height / self.width;
            
            if (pictureH >= 1000) { //高度超过1000的大图
                self.bigPicture = YES; //是大图
                pictureH = 250; //超过1000的大图高度变为固定的250
            }
            
            CGFloat pictureX = BSTopicCellMargin;
            CGFloat pictureY = BStopicCellTextY + contentLabelH + BSTopicCellMargin;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            _cellHeight += pictureH + BSTopicCellMargin;
        } else if(self.type == BSTopicTypeVoice) {
            CGFloat voiceX = BSTopicCellMargin;
            CGFloat voiceY = BStopicCellTextY + contentLabelH + BSTopicCellMargin;
            CGFloat voiceW = contentLabelW;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + BSTopicCellMargin;
        }
         _cellHeight += BSTopicCellBottomBarH + BSTopicCellMargin;
    }
    return _cellHeight;
}

@end
