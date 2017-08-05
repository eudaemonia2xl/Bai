//
//  BSProgressView.h
//  BaiSiJie
//
//  Created by 郑雪利 on 2017/8/5.
//  Copyright © 2017年 郑雪利. All rights reserved.
//

#import "DALabeledCircularProgressView.h"

/**
 * 避免使用第三方软件的风险，使用自定义的类，继承自第三方的类，项目中使用时继承自我们这个类就行，如果换掉第三方时，直接改这一个地方即可
 */
@interface BSProgressView : DALabeledCircularProgressView

@end
