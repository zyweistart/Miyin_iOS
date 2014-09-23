//
//  STInspection1Cell.m
//  ElectricianClient
//
//  Created by Start on 4/1/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STInspection1Cell.h"

@implementation STInspection1Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(10, 0, 75, 100)];
        [view setBackgroundColor:[UIColor colorWithRed:(170/255.0) green:(170/255.0) blue:(170/255.0) alpha:1]];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 75, 20)];
        [lbl setText:@"有功(kWh)"];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 40, 75, 20)];
        [lbl setText:@"尖"];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 60, 75, 20)];
        [lbl setText:@"峰"];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, 75, 20)];
        [lbl setText:@"谷"];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:lbl];
        [self addSubview:view];
        
        view=[[UIView alloc]initWithFrame:CGRectMake(85, 0, 75, 100)];
        [view setBackgroundColor:[UIColor colorWithRed:(215/255.0) green:(151/255.0) blue:(104/255.0) alpha:1]];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 75, 20)];
        [lbl setText:@"本期读数"];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:lbl];
        self.lbl1=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 75, 20)];
        [self.lbl1 setText:@"236.0"];
        [self.lbl1 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl1 setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:self.lbl1];
        self.lbl2=[[UILabel alloc]initWithFrame:CGRectMake(0, 40, 75, 20)];
        [self.lbl2 setText:@"14.16"];
        [self.lbl2 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl2 setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:self.lbl2];
        self.lbl3=[[UILabel alloc]initWithFrame:CGRectMake(0, 60, 75, 20)];
        [self.lbl3 setText:@"141.6"];
        [self.lbl3 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl3 setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:self.lbl3];
        self.lbl4=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, 75, 20)];
        [self.lbl4 setText:@"80.24"];
        [self.lbl4 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl4 setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:self.lbl4];
        [self addSubview:view];
        
        view=[[UIView alloc]initWithFrame:CGRectMake(160, 0, 75, 100)];
        [view setBackgroundColor:[UIColor colorWithRed:(182/255.0) green:(211/255.0) blue:(100/255.0) alpha:1]];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 75, 20)];
        [lbl setText:@"上期读数"];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:lbl];
        self.lbl5=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 75, 20)];
        [self.lbl5 setText:@"78.09"];
        [self.lbl5 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl5 setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:self.lbl5];
        self.lbl6=[[UILabel alloc]initWithFrame:CGRectMake(0, 40, 75, 20)];
        [self.lbl6 setText:@"4.69"];
        [self.lbl6 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl6 setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:self.lbl6];
        self.lbl7=[[UILabel alloc]initWithFrame:CGRectMake(0, 60, 75, 20)];
        [self.lbl7 setText:@"46.85"];
        [self.lbl7 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl7 setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:self.lbl7];
        self.lbl8=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, 75, 20)];
        [self.lbl8 setText:@"26.55"];
        [self.lbl8 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl8 setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:self.lbl8];
        [self addSubview:view];
        
        view=[[UIView alloc]initWithFrame:CGRectMake(235, 0, 75, 100)];
        [view setBackgroundColor:[UIColor colorWithRed:(113/255.0) green:(172/255.0) blue:(202/255.0) alpha:1]];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 75, 20)];
        [lbl setText:@"实际耗量"];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:lbl];
        self.lbl9=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 75, 20)];
        [self.lbl9 setText:@"157.91"];
        [self.lbl9 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl9 setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:self.lbl9];
        self.lbl10=[[UILabel alloc]initWithFrame:CGRectMake(0, 40, 75, 20)];
        [self.lbl10 setText:@"9.47"];
        [self.lbl10 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl10 setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:self.lbl10];
        self.lbl11=[[UILabel alloc]initWithFrame:CGRectMake(0, 60, 75, 20)];
        [self.lbl11 setText:@"94.75"];
        [self.lbl11 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl11 setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:self.lbl11];
        self.lbl12=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, 75, 20)];
        [self.lbl12 setText:@"53.69"];
        [self.lbl12 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl12 setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:self.lbl12];
        [self addSubview:view];
    }
    return self;
}

@end
