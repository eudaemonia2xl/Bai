//
//  BSRecommandTagCell.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/7/22.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSRecommandTagCell.h"
#import "BSRecommandTag.h"
#import <UIImageView+WebCache.h>

@interface BSRecommandTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNametLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end
@implementation BSRecommandTagCell

/*
 
 cell 的分割线的3种实现方式：
 1.给cell的contantView添加一个view，将其他控件添加在view上
 2.修改contantView的frame，将contantView的高度减少
 3.重写cell的setFrame方法，修改cell的frame,外界再也不能修改cell的frame
 */

- (void)setRecommandTag:(BSRecommandTag *)recommandTag
{
    _recommandTag = recommandTag;
    
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommandTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNametLabel.text = recommandTag.theme_name;
    
    NSString *subString = nil;
    if (recommandTag.sub_number > 10000) {
        subString = [NSString stringWithFormat:@"%.1f万人订阅",recommandTag.sub_number / 10000.0];
    }else {
        subString = [NSString stringWithFormat:@"%zd人订阅",recommandTag.sub_number];
    }
    self.subNumberLabel.text = subString;
}

/**
 * 重写cell的frame，留出前后空白和分割线的效果
 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 10;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
