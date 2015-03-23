//
//  DetialView.h
//  test
//
//  Created by apple on 14-6-10.
//  Copyright (c) 2014年 zhuhuaxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
@interface DetialView : UIView
{
    //根据model需求 创建所需控件
    UILabel*_label1;
    UILabel*_label2;
}

//下边方法可以自己实现 用于计算view高度 或者单元格高度

//+(CGFloat)getHeightByModel:(Model*)model;

@property(nonatomic,strong)Model*model;

@end
