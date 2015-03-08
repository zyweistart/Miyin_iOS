//
//  ProjectBCell.m
//  DLS
//
//  Created by Start on 3/8/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "ProjectBCell.h"
#define TITLECOLOR [UIColor colorWithRed:(70/255.0) green:(70/255.0) blue:(70/255.0) alpha:1]
#define MONEYCOLOR [UIColor colorWithRed:(251/255.0) green:(0/255.0) blue:(7/255.0) alpha:1]

@implementation ProjectBCell

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
        self.money=[[UILabel alloc]initWithFrame:CGRectMake1(80, 55, 210, 20)];
        [self.money setFont:[UIFont systemFontOfSize:17]];
        [self.money setTextColor:MONEYCOLOR];
        [self.money setNumberOfLines:2];
        [self.money setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:self.money];
    }
    return self;
}


@end
