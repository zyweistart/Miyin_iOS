//
//  InfoCell.m
//  BBQ
//
//  Created by Start on 15/7/28.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "InfoCell.h"

@implementation InfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:DEFAULTITLECOLORRGB(65, 51, 42)];
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 5, 310, 200)];
        frame.layer.masksToBounds=YES;
        frame.layer.cornerRadius=CGWidth(5);
        frame.layer.borderWidth=1;
        frame.layer.borderColor=DEFAULTITLECOLOR(200).CGColor;
        [frame setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:frame];
        
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(0, 0, 40, 200) Text:@"T1"];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setFont:[UIFont systemFontOfSize:18]];
        [lbl setBackgroundColor:DEFAULTITLECOLORRGB(242, 125, 0)];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [frame addSubview:lbl];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

@end
