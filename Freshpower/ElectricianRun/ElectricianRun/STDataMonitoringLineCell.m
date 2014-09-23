//
//  STDataMonitoringLineCell.m
//  ElectricianRun
//
//  Created by Start on 2/28/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STDataMonitoringLineCell.h"

@implementation STDataMonitoringLineCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 60, 30)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"线路名称:"];
        [self addSubview:lbl];
        
        self.lbl1=[[UILabel alloc]initWithFrame:CGRectMake(70, 5, 85, 30)];
        [self.lbl1 setFont:[UIFont systemFontOfSize:10]];
        [self.lbl1 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl1 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl1 setNumberOfLines:0];
        [self addSubview:self.lbl1];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(160, 5, 70, 30)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"开关状态:"];
        [self addSubview:lbl];
        
        self.lbl2=[[UILabel alloc]initWithFrame:CGRectMake(235, 5, 70, 30)];
        [self.lbl2 setFont:[UIFont systemFontOfSize:10]];
        [self.lbl2 setTextColor:[UIColor redColor]];
        [self.lbl2 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl2 setNumberOfLines:0];
        [self addSubview:self.lbl2];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 40, 60, 30)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"上线时间:"];
        [self addSubview:lbl];
        
        self.lbl3=[[UILabel alloc]initWithFrame:CGRectMake(70, 40, 85, 30)];
        [self.lbl3 setFont:[UIFont systemFontOfSize:10]];
        [self.lbl3 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl3 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl3 setNumberOfLines:0];
        [self addSubview:self.lbl3];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(160, 40, 70, 30)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"日耗量:"];
        [self addSubview:lbl];
        
        self.lbl4=[[UILabel alloc]initWithFrame:CGRectMake(235, 40, 70, 30)];
        [self.lbl4 setFont:[UIFont systemFontOfSize:10]];
        [self.lbl4 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl4 setNumberOfLines:0];
        [self addSubview:self.lbl4];
        
    }
    return self;
}
@end
