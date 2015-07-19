//
//  NewsItemCell.m
//  ZMCY
//
//  Created by Start on 15/7/19.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "NewsItemCell.h"

@implementation NewsItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(10, 0, 300, 80)];
        [self addSubview:frame];
        self.image=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 60, 60)];
        [self.image setBackgroundColor:[UIColor redColor]];
        [frame addSubview:self.image];
        self.lblTitle=[[CLabel alloc]initWithFrame:CGRectMake1(80, 10, 200, 20) Text:@""];
        [self.lblTitle setTextColor:[UIColor blackColor]];
        [self.lblTitle setFont:[UIFont systemFontOfSize:16]];
        [frame addSubview:self.lblTitle];
        self.lblContent=[[CLabel alloc]initWithFrame:CGRectMake1(80, 30, 200, 40) Text:@""];
        [self.lblContent setFont:[UIFont systemFontOfSize:14]];
        [self.lblContent setNumberOfLines:2];
        [frame addSubview:self.lblContent];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

@end
