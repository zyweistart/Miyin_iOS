//
//  STAuditBuildCell.m
//  ElectricianRun
//
//  Created by Start on 2/28/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STAuditBuildCell.h"

@implementation STAuditBuildCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 65, 20)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"客户名称:"];
        [self addSubview:lbl];
        
        self.lbl1=[[UILabel alloc]initWithFrame:CGRectMake(75, 5, 200, 20)];
        [self.lbl1 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl1 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl1 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl1 setNumberOfLines:0];
        [self addSubview:self.lbl1];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 30, 65, 20)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"站点名称:"];
        [self addSubview:lbl];
        
        self.lbl2=[[UILabel alloc]initWithFrame:CGRectMake(75, 30, 200, 20)];
        [self.lbl2 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl2 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl2 setNumberOfLines:0];
        [self addSubview:self.lbl2];
        
    }
    return self;
}
@end