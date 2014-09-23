//
//  STTaskManagerCell.m
//  ElectricianRun
//
//  Created by Start on 3/10/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STTaskManagerCell.h"

@implementation STTaskManagerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 70, 30)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"客户名称:"];
        [self addSubview:lbl];
        
        self.lbl1=[[UILabel alloc]initWithFrame:CGRectMake(80, 5, 70, 30)];
        [self.lbl1 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl1 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl1 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl1 setNumberOfLines:0];
        [self addSubview:self.lbl1];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(160, 5, 70, 30)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"变压器数量:"];
        [self addSubview:lbl];
        
        self.lbl2=[[UILabel alloc]initWithFrame:CGRectMake(235, 5, 70, 30)];
        [self.lbl2 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl2 setTextColor:[UIColor redColor]];
        [self.lbl2 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl2 setNumberOfLines:0];
        [self addSubview:self.lbl2];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 40, 70, 30)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"负荷时间:"];
        [self addSubview:lbl];
        
        self.lbl3=[[UILabel alloc]initWithFrame:CGRectMake(80, 40, 70, 30)];
        [self.lbl3 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl3 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl3 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl3 setNumberOfLines:0];
        [self addSubview:self.lbl3];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(160, 40, 70, 30)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"最高负荷:"];
        [self addSubview:lbl];
        
        self.lbl4=[[UILabel alloc]initWithFrame:CGRectMake(235, 40, 70, 30)];
        [self.lbl4 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl4 setTextColor:[UIColor redColor]];
        [self.lbl4 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl4 setNumberOfLines:0];
        [self addSubview:self.lbl4];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
