//
//  BSTextField.m
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/7/26.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "BSTextField.h"
#import <objc/runtime.h>

@implementation BSTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.tintColor = self.textColor;
    
    [self resignFirstResponder];
    
//    NSDictionary *dict = @{
//                           NSForegroundColorAttributeName:[UIColor whiteColor]
//                           };
//    
//    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"手机号" attributes:dict];
//    self.attributedPlaceholder = attrStr;
}

- (BOOL)becomeFirstResponder
{
    [super becomeFirstResponder];
    
    //使用运行时找到UITextField的其他成员变量，给其赋值
    [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    return YES;
}

- (BOOL)resignFirstResponder
{
    [super resignFirstResponder];
    
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    return YES;
}

- (void)findIvar
{
    unsigned int count = 0;
    //拷贝所有的成员变量列表，（数组名其实是指向数组第一个元素的指针）
    Ivar *ivar = class_copyIvarList([UITextField class], &count);
    
    for (int i = 0; i<count; i++) {
        //打印成员变量的名字
        DLog(@"%s ===== %s",ivar_getName(ivar[i]),ivar_getTypeEncoding(ivar[i]));
    }
    //使用copy、create、retain创建的变量需要手动释放内存
    free(ivar);
}

- (void)findProperty
{
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([UITextField class], &count);
    
    for (int i = 0; i<count; i++) {
        
        //打印属性的名字
        DLog(@"%s =====",property_getName(properties[i]));
    }
//    使用copy、create、retain创建的变量需要手动释放内存
    free(properties);
}

@end
