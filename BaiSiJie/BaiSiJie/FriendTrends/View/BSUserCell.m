//
//  BSUserCell.m
//  BaiSiJie
//
//  Created by senyint on 2017/7/18.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSUserCell.h"
#import "BSRecommandUser.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BSUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end
@implementation BSUserCell

- (void)setUser:(BSRecommandUser *)user
{
    _user = user;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.screenNameLabel.text = user.screen_name;
    
    NSString *fansCountString = nil;
    if (user.fans_count > 10000) {
        fansCountString = [NSString stringWithFormat:@"%.1f万人关注",user.fans_count / 10000.0];
    }else {
        fansCountString = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    }
    
    self.fansCountLabel.text = fansCountString;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
