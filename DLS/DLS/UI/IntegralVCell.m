//
//  IntegralVCell.m
//  DLS
//
//  Created by Start on 5/8/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "IntegralVCell.h"

@implementation IntegralVCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 45)];
        [self addSubview:frame];
        self.lbl1=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 110, 45)];
        [self.lbl1 setFont:[UIFont systemFontOfSize:14]];
        [self.lbl1 setTextAlignment:NSTextAlignmentCenter];
        [self.lbl1 setTextColor:[UIColor blackColor]];
        [frame addSubview:self.lbl1];
        self.lbl2=[[UILabel alloc]initWithFrame:CGRectMake1(110, 0, 100, 45)];
        [self.lbl2 setFont:[UIFont systemFontOfSize:14]];
        [self.lbl2 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl2 setTextColor:[UIColor blackColor]];
        [frame addSubview:self.lbl2];
        self.lbl3=[[UILabel alloc]initWithFrame:CGRectMake1(210, 0, 110, 45)];
        [self.lbl3 setFont:[UIFont systemFontOfSize:14]];
        [self.lbl3 setTextAlignment:NSTextAlignmentCenter];
        [self.lbl3 setTextColor:[UIColor blackColor]];
        [frame addSubview:self.lbl3];
    }
    return self;
}

@end
