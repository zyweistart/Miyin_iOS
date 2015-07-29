//
//  InfoCell.m
//  BBQ
//
//  Created by Start on 15/7/29.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "InfoCell.h"

@implementation InfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:DEFAULTITLECOLORA(150, 0.5)];
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 90)];
        [self addSubview:frame];
        self.lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(20, 0, 80, 40)];
        [self.lblTitle setTextColor:[UIColor blackColor]];
        [self.lblTitle setFont:[UIFont systemFontOfSize:30]];
        [self.lblTitle setTextAlignment:NSTextAlignmentLeft];
        [frame addSubview:self.lblTitle];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(20, 40, 150, 1)];
        [line setBackgroundColor:DEFAULTITLECOLOR(150)];
        [frame addSubview:line];
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(20, 45, 60, 20) Text:@"Timer"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [frame addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(100, 45, 80, 20) Text:@"Target Temp"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [frame addSubview:lbl];
        self.lblTimer=[[UILabel alloc]initWithFrame:CGRectMake1(20, 65, 60, 20) ];
        [self.lblTimer setTextColor:[UIColor blackColor]];
        [self.lblTimer setFont:[UIFont systemFontOfSize:14]];
        [self.lblTimer setTextAlignment:NSTextAlignmentCenter];
        [frame addSubview:self.lblTimer];
        self.lblTargetTemp=[[UILabel alloc]initWithFrame:CGRectMake1(100, 65, 80, 20)];
        [self.lblTargetTemp setTextColor:[UIColor blackColor]];
        [self.lblTargetTemp setFont:[UIFont systemFontOfSize:14]];
        [self.lblTargetTemp setTextAlignment:NSTextAlignmentCenter];
        [frame addSubview:self.lblTargetTemp];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [self.lblTitle setText:@"T1"];
        [self.lblTimer setText:@"10"];
        [self.lblTargetTemp setText:@"85"];
    }
    return self;
}

@end
