//
//  InformationCell.m
//  DLS
//
//  Created by Start on 3/4/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "InformationCell.h"
#define MAINTITLECOLOR [UIColor colorWithRed:(50/255.0) green:(50/255.0) blue:(50/255.0) alpha:1]
#define CHILDTITLECOLOR [UIColor colorWithRed:(150/255.0) green:(150/255.0) blue:(150/255.0) alpha:1]

@implementation InformationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        UIView *mainView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 80)];
        [self addSubview:mainView];
        self.image=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 60, 60)];
        [mainView addSubview:self.image];
        self.mainTitle=[[UILabel alloc]initWithFrame:CGRectMake1(80, 10, 230, 25)];
        [self.mainTitle setFont:[UIFont systemFontOfSize:18]];
        [self.mainTitle setTextColor:MAINTITLECOLOR];
        [self.mainTitle setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:self.mainTitle];
        self.childTitle=[[UILabel alloc]initWithFrame:CGRectMake1(80, 35, 230, 40)];
        [self.childTitle setFont:[UIFont systemFontOfSize:13]];
        [self.childTitle setTextColor:CHILDTITLECOLOR];
        [self.childTitle setNumberOfLines:2];
        [self.childTitle setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:self.childTitle];
    }
    return self;
}

- (void)setData:(NSDictionary *)data
{
}

@end
