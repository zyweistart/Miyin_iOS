//
//  ElecLoadDetailCell.m
//  eClient
//
//  Created by Start on 4/16/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "ElecLoadDetailCell.h"
#define TITLECOLOR [UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]

@implementation ElecLoadDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lbl1=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 150, 20)];
        [self.lbl1 setText:@"变3"];
        [self.lbl1 setFont:[UIFont systemFontOfSize:14]];
        [self.lbl1 setTextColor:TITLECOLOR];
        [self.lbl1 setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.lbl1];
        self.lbl2=[[UILabel alloc]initWithFrame:CGRectMake(5, 25, 150, 20)];
        [self.lbl2 setText:@"当前负荷"];
        [self.lbl2 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl2 setTextColor:TITLECOLOR];
        [self.lbl2 setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.lbl2];
        self.lbl3=[[UILabel alloc]initWithFrame:CGRectMake(160, 25, 150, 20)];
        [self.lbl3 setText:@"电流"];
        [self.lbl3 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl3 setTextColor:TITLECOLOR];
        [self.lbl3 setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.lbl3];
        self.lbl4=[[UILabel alloc]initWithFrame:CGRectMake(5, 45, 150, 20)];
        [self.lbl4 setText:@"总功率因数"];
        [self.lbl4 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl4 setTextColor:TITLECOLOR];
        [self.lbl4 setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.lbl4];
        self.lbl5=[[UILabel alloc]initWithFrame:CGRectMake(160, 45, 150, 20)];
        [self.lbl5 setText:@"电压"];
        [self.lbl5 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl5 setTextColor:TITLECOLOR];
        [self.lbl5 setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.lbl5];
    }
    return self;
}

@end
