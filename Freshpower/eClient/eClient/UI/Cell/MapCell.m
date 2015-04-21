//
//  MapCell.m
//  eClient
//
//  Created by Start on 4/20/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "MapCell.h"

#define TITLECOLOR [UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]

@implementation MapCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.image=[[UIImageView alloc]initWithFrame:CGRectMake1(5, 5, 30, 40)];
        [self.image setImage:[UIImage imageNamed:@"point"]];
        [self addSubview:self.image];
        self.lbl1=[[UILabel alloc]initWithFrame:CGRectMake(45, 5, 150, 20)];
        [self.lbl1 setFont:[UIFont systemFontOfSize:14]];
        [self.lbl1 setTextColor:TITLECOLOR];
        [self.lbl1 setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.lbl1];
        self.lbl2=[[UILabel alloc]initWithFrame:CGRectMake(200, 5, 110, 20)];
        [self.lbl2 setFont:[UIFont systemFontOfSize:14]];
        [self.lbl2 setTextColor:TITLECOLOR];
        [self.lbl2 setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.lbl2];
        self.lbl3=[[UILabel alloc]initWithFrame:CGRectMake(45, 25, 150, 20)];
        [self.lbl3 setFont:[UIFont systemFontOfSize:14]];
        [self.lbl3 setTextColor:TITLECOLOR];
        [self.lbl3 setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.lbl3];
        self.lbl4=[[UILabel alloc]initWithFrame:CGRectMake(200, 25, 110, 20)];
        [self.lbl4 setFont:[UIFont systemFontOfSize:14]];
        [self.lbl4 setTextColor:TITLECOLOR];
        [self.lbl4 setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.lbl4];
    }
    return self;
}

@end