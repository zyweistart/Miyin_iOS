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
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 5, 310, 180)];
        frame.layer.masksToBounds=YES;
        frame.layer.cornerRadius=CGWidth(5);
        frame.layer.borderWidth=1;
        frame.layer.borderColor=DEFAULTITLECOLOR(200).CGColor;
        [frame setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:frame];
        
        self.lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 40, 180)];
        [self.lblTitle setTextColor:[UIColor whiteColor]];
        [self.lblTitle setFont:[UIFont systemFontOfSize:18]];
        [self.lblTitle setBackgroundColor:DEFAULTITLECOLORRGB(242, 125, 0)];
        [self.lblTitle setTextAlignment:NSTextAlignmentCenter];
        [frame addSubview:self.lblTitle];
        
        self.lblCurrentSamllCentigrade=[[UIButton alloc]initWithFrame:CGRectMake1(60, 5, 60, 20)];
        [self.lblCurrentSamllCentigrade setTitleColor:DEFAULTITLECOLORRGB(242, 125, 0) forState:UIControlStateNormal];
        [self.lblCurrentSamllCentigrade setImage:[UIImage imageNamed:@"指针"] forState:UIControlStateNormal];
        [self.lblCurrentSamllCentigrade setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [frame addSubview:self.lblCurrentSamllCentigrade];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake1(60, 30, 224, 20)];
        [lineView setBackgroundColor:DEFAULTITLECOLOR(188)];
        [frame addSubview:lineView];
        
        self.viewCentigrade=[[UIView alloc]initWithFrame:CGRectMake1(2, 2, 150, 16)];
        [self.viewCentigrade setBackgroundColor:[UIColor redColor]];
        [lineView addSubview:self.viewCentigrade];
        
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(50, 80, 50, 20) Text:@"Current"];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [frame addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(50, 100, 50, 20) Text:@"Temp"];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [frame addSubview:lbl];
        
        self.lblCurrentCentigrade=[[UILabel alloc]initWithFrame:CGRectMake1(100, 80, 100, 40)];
        [self.lblCurrentCentigrade setTextColor:DEFAULTITLECOLORRGB(242, 125, 0)];
        [self.lblCurrentCentigrade setFont:[UIFont systemFontOfSize:40]];
        [self.lblCurrentCentigrade setTextAlignment:NSTextAlignmentCenter];
        [frame addSubview:self.lblCurrentCentigrade];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(45, 125, 155, 1)];
        [line setBackgroundColor:DEFAULTITLECOLOR(160)];
        [frame addSubview:line];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(50, 130, 50, 20) Text:@"Set"];
        [frame addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(50, 150, 50, 20) Text:@"Temp"];
        [frame addSubview:lbl];
        
        self.lblHighestCentigrade=[[UILabel alloc]initWithFrame:CGRectMake1(100, 130, 100, 40)];
        [self.lblHighestCentigrade setTextColor:DEFAULTITLECOLOR(100)];
        [self.lblHighestCentigrade setFont:[UIFont systemFontOfSize:30]];
        [self.lblHighestCentigrade setTextAlignment:NSTextAlignmentCenter];
        [frame addSubview:self.lblHighestCentigrade];
        
        UIButton *image=[[UIButton alloc]initWithFrame:CGRectMake1(202, 97, 46, 52)];
        [image setImage:[UIImage imageNamed:@"时间"] forState:UIControlStateNormal];
        [image addTarget:self action:@selector(setTimer:) forControlEvents:UIControlEventTouchUpInside];
        [frame addSubview:image];
        
        self.lblSetTime=[[UILabel alloc]initWithFrame:CGRectMake1(250, 97, 60, 52)];
        [self.lblSetTime setTextColor:DEFAULTITLECOLOR(41)];
        [self.lblSetTime setFont:[UIFont systemFontOfSize:18]];
        [self.lblSetTime setTextAlignment:NSTextAlignmentCenter];
        [frame addSubview:self.lblSetTime];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    return self;
}

- (void)setTimer:(id)sender
{
    NSLog(@"设置时间%@",self.data);
}

@end
