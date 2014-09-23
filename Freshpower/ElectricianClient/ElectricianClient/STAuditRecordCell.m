//
//  STAuditRecordCell.m
//  ElectricianRun
//
//  Created by Start on 2/28/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STAuditRecordCell.h"

@implementation STAuditRecordCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 55, 30)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"巡检人:"];
        [self addSubview:lbl];
        
        self.lbl1=[[UILabel alloc]initWithFrame:CGRectMake(65, 5, 70, 30)];
        [self.lbl1 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl1 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl1 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl1 setNumberOfLines:0];
        [self addSubview:self.lbl1];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(150, 5, 80, 30)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"任务时间:"];
        [self addSubview:lbl];
        
        self.lbl2=[[UILabel alloc]initWithFrame:CGRectMake(235, 5, 80, 30)];
        [self.lbl2 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl2 setTextColor:[UIColor redColor]];
        [self.lbl2 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl2 setNumberOfLines:0];
        [self addSubview:self.lbl2];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 40, 55, 30)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"站点名称:"];
        [self addSubview:lbl];
        
        self.lbl3=[[UILabel alloc]initWithFrame:CGRectMake(65, 40, 70, 30)];
        [self.lbl3 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl3 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl3 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl3 setNumberOfLines:0];
        [self addSubview:self.lbl3];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(150, 40, 80, 30)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"要求完成时间:"];
        [self addSubview:lbl];
        
        self.lbl4=[[UILabel alloc]initWithFrame:CGRectMake(235, 40, 80, 30)];
        [self.lbl4 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl4 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl4 setNumberOfLines:0];
        [self addSubview:self.lbl4];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 75, 55, 30)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"是否完成:"];
        [self addSubview:lbl];
        
        self.lbl5=[[UILabel alloc]initWithFrame:CGRectMake(65, 75, 70, 30)];
        [self.lbl5 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl5 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl5 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl5 setNumberOfLines:0];
        [self addSubview:self.lbl5];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(150, 75, 80, 30)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"实际完成时间:"];
        [self addSubview:lbl];
        
        self.lbl6=[[UILabel alloc]initWithFrame:CGRectMake(235, 75, 80, 30)];
        [self.lbl6 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl6 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl6 setNumberOfLines:0];
        [self addSubview:self.lbl6];
    }
    return self;
}
@end