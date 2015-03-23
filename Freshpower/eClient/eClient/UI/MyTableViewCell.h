//
//  MyTableViewCell.h
//  test
//
//  Created by apple on 14-6-10.
//  Copyright (c) 2014年 zhuhuaxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "DetialView.h"

@interface MyTableViewCell : UITableViewCell

//此处label无论单元格展开与否都显示
@property(nonatomic,strong) UILabel *TitleLabel;

@property(nonatomic,strong)Model *model;
@property(nonatomic,strong)DetialView *detialView;

@end
