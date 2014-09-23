//
//  STMonitoringLineDetailCell.m
//  ElectricianRun
//
//  Created by Start on 3/3/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STMonitoringLineDetailCell.h"

@implementation STMonitoringLineDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 60, 30)];
        [lbl setFont:[UIFont systemFontOfSize:10]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"线路名称:"];
        [self addSubview:lbl];
        
        self.lbl1=[[UILabel alloc]initWithFrame:CGRectMake(70, 0, 90, 30)];
        [self.lbl1 setFont:[UIFont systemFontOfSize:10]];
        [self.lbl1 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl1 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl1 setNumberOfLines:0];
        [self addSubview:self.lbl1];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(165, 0, 60, 30)];
        [lbl setFont:[UIFont systemFontOfSize:10]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"通道:"];
        [self addSubview:lbl];
        
        self.lbl2=[[UILabel alloc]initWithFrame:CGRectMake(230, 0, 90, 30)];
        [self.lbl2 setFont:[UIFont systemFontOfSize:10]];
        [self.lbl2 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl2 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl2 setNumberOfLines:0];
        [self addSubview:self.lbl2];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 35, 60, 30)];
        [lbl setFont:[UIFont systemFontOfSize:10]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"上线时间:"];
        [self addSubview:lbl];
        
        self.lbl3=[[UILabel alloc]initWithFrame:CGRectMake(70, 35, 90, 30)];
        [self.lbl3 setFont:[UIFont systemFontOfSize:10]];
        [self.lbl3 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl3 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl3 setNumberOfLines:0];
        [self addSubview:self.lbl3];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(165, 35, 60, 30)];
        [lbl setFont:[UIFont systemFontOfSize:10]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"电网频率:"];
        [self addSubview:lbl];
        
        self.lbl4=[[UILabel alloc]initWithFrame:CGRectMake(230, 35, 90, 30)];
        [self.lbl4 setFont:[UIFont systemFontOfSize:10]];
        [self.lbl4 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl4 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl4 setNumberOfLines:0];
        [self addSubview:self.lbl4];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 70, 60, 30)];
        [lbl setFont:[UIFont systemFontOfSize:10]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"A相电压:"];
        [self addSubview:lbl];
        
        self.lbl5=[[UILabel alloc]initWithFrame:CGRectMake(70, 70, 90, 30)];
        [self.lbl5 setFont:[UIFont systemFontOfSize:10]];
        [self.lbl5 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl5 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl5 setNumberOfLines:0];
        [self addSubview:self.lbl5];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(165, 70, 60, 30)];
        [lbl setFont:[UIFont systemFontOfSize:10]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"A相电流:"];
        [self addSubview:lbl];
        
        self.lbl6=[[UILabel alloc]initWithFrame:CGRectMake(230, 70, 90, 30)];
        [self.lbl6 setFont:[UIFont systemFontOfSize:10]];
        [self.lbl6 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl6 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl6 setNumberOfLines:0];
        [self addSubview:self.lbl6];

        lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 105, 60, 30)];
        [lbl setFont:[UIFont systemFontOfSize:10]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"B相电压:"];
        [self addSubview:lbl];
        
        self.lbl7=[[UILabel alloc]initWithFrame:CGRectMake(70, 105, 90, 30)];
        [self.lbl7 setFont:[UIFont systemFontOfSize:10]];
        [self.lbl7 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl7 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl7 setNumberOfLines:0];
        [self addSubview:self.lbl7];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(165, 105, 60, 30)];
        [lbl setFont:[UIFont systemFontOfSize:10]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"B相电流:"];
        [self addSubview:lbl];
        
        self.lbl8=[[UILabel alloc]initWithFrame:CGRectMake(230, 105, 90, 30)];
        [self.lbl8 setFont:[UIFont systemFontOfSize:10]];
        [self.lbl8 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl8 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl8 setNumberOfLines:0];
        [self addSubview:self.lbl8];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 140, 60, 30)];
        [lbl setFont:[UIFont systemFontOfSize:10]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"C相电压:"];
        [self addSubview:lbl];
        
        self.lbl9=[[UILabel alloc]initWithFrame:CGRectMake(70, 140, 90, 30)];
        [self.lbl9 setFont:[UIFont systemFontOfSize:10]];
        [self.lbl9 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl9 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl9 setNumberOfLines:0];
        [self addSubview:self.lbl9];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(165, 140, 60, 30)];
        [lbl setFont:[UIFont systemFontOfSize:10]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"C相电流:"];
        [self addSubview:lbl];
        
        self.lbl10=[[UILabel alloc]initWithFrame:CGRectMake(230, 140, 90, 30)];
        [self.lbl10 setFont:[UIFont systemFontOfSize:10]];
        [self.lbl10 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl10 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl10 setNumberOfLines:0];
        [self addSubview:self.lbl10];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 175, 60, 30)];
        [lbl setFont:[UIFont systemFontOfSize:10]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"总有功率:"];
        [self addSubview:lbl];
        
        self.lbl11=[[UILabel alloc]initWithFrame:CGRectMake(70, 175, 90, 30)];
        [self.lbl11 setFont:[UIFont systemFontOfSize:10]];
        [self.lbl11 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl11 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl11 setNumberOfLines:0];
        [self addSubview:self.lbl11];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(165, 175, 60, 30)];
        [lbl setFont:[UIFont systemFontOfSize:10]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"总功率因数:"];
        [self addSubview:lbl];
        
        self.lbl12=[[UILabel alloc]initWithFrame:CGRectMake(230, 175, 90, 30)];
        [self.lbl12 setFont:[UIFont systemFontOfSize:10]];
        [self.lbl12 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl12 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl12 setNumberOfLines:0];
        [self addSubview:self.lbl12];
        
    }
    return self;
}

@end
