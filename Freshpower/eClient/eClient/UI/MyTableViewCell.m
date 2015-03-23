//
//  MyTableViewCell.m
//  test
//
//  Created by apple on 14-6-10.
//  Copyright (c) 2014年 zhuhuaxi. All rights reserved.
//

#import "MyTableViewCell.h"
#import "DetialView.h"

@implementation MyTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initdata];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initdata];
    }
    return self;
}

//初始化Cell
- (void)initdata
{
    self.detialView = [[DetialView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.detialView];
//    self.detialView.frame=CGRectMake(0, 1, 0, 1);
//此处label无论单元格展开与否都显示 应通过另外的数据源赋值 此处写死了
    self.TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    self.TitleLabel.text=@"详细";
    [self addSubview:self.TitleLabel];
}

//自动布局 将model传给自定义View
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_model != nil ) {
        _detialView.model = self.model;
//下面这行代码只是为了开始自动布局
        [_detialView layoutSubviews];
//        _detialView.hidden=NO;
    } else {
        _detialView.model = nil;
        _detialView.frame = CGRectZero;
//        _detialView.hidden=YES;
    }
}

@end
