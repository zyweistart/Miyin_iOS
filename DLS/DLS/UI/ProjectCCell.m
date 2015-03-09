//
//  ProjectCCell.m
//  DLS
//
//  Created by Start on 3/8/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "ProjectCCell.h"
#define TITLECOLOR [UIColor colorWithRed:(70/255.0) green:(70/255.0) blue:(70/255.0) alpha:1]
#define CHILDCOLOR [UIColor colorWithRed:(77/255.0) green:(77/255.0) blue:(77/255.0) alpha:1]

@implementation ProjectCCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        UIView *mainView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 80)];
        [self addSubview:mainView];
        self.image=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 60, 60)];
        [mainView addSubview:self.image];
        self.title=[[UILabel alloc]initWithFrame:CGRectMake1(80, 10, 210, 40)];
        [self.title setFont:[UIFont systemFontOfSize:15]];
        [self.title setTextColor:TITLECOLOR];
        [self.title setNumberOfLines:2];
        [self.title setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:self.title];
        self.name=[[UILabel alloc]initWithFrame:CGRectMake1(80, 55, 140, 20)];
        [self.name setFont:[UIFont systemFontOfSize:13]];
        [self.name setTextColor:CHILDCOLOR];
        [self.name setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:self.name];
        self.distance=[[UILabel alloc]initWithFrame:CGRectMake1(230, 55, 80, 20)];
        [self.distance setFont:[UIFont systemFontOfSize:13]];
        [self.distance setTextColor:CHILDCOLOR];
        [self.distance setTextAlignment:NSTextAlignmentRight];
        [mainView addSubview:self.distance];
    }
    return self;
}

- (void)setData:(NSDictionary *)data
{
}

@end
