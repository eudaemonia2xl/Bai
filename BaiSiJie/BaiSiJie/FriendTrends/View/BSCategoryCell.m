//
//  BSCategoryCell.m
//  BaiSiJie
//
//  Created by senyint on 2017/7/18.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSCategoryCell.h"
#import "BSRecommandCategory.h"

@interface BSCategoryCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *selectedView;

@end
@implementation BSCategoryCell

- (void)setCategory:(BSRecommandCategory *)category
{
    _category = category;
    self.nameLabel.text = category.name;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = RGBColor(244, 244, 244);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectedView.hidden = !selected;
    self.nameLabel.textColor = selected ? [UIColor redColor] : [UIColor darkGrayColor];
}

@end
