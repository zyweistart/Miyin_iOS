//
//  STElectricityCell.m
//  ElectricianClient
//
//  Created by Start on 3/26/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STElectricityCell.h"

@implementation STElectricityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lbln1=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 65, 20)];
        [self.lbln1 setFont:[UIFont systemFontOfSize:12]];
        [self.lbln1 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbln1 setTextAlignment:NSTextAlignmentRight];
        [self.lbln1 setText:@"昨日总电量:"];
        [self addSubview:self.lbln1];
        
        self.lbl1=[[UILabel alloc]initWithFrame:CGRectMake(75, 0, 85, 20)];
        [self.lbl1 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl1 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl1 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl1 setNumberOfLines:0];
        [self addSubview:self.lbl1];
        
        self.lbln2=[[UILabel alloc]initWithFrame:CGRectMake(5, 20, 65, 20)];
        [self.lbln2 setFont:[UIFont systemFontOfSize:12]];
        [self.lbln2 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbln2 setTextAlignment:NSTextAlignmentRight];
        [self.lbln2 setText:@"昨日电费:"];
        [self addSubview:self.lbln2];
        
        self.lbl2=[[UILabel alloc]initWithFrame:CGRectMake(75, 20, 85, 20)];
        [self.lbl2 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl2 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl2 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl2 setNumberOfLines:0];
        [self addSubview:self.lbl2];
        
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 40, 65, 20)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"平均电价:"];
        [self addSubview:lbl];
        
        self.lbl3=[[UILabel alloc]initWithFrame:CGRectMake(75, 40, 85, 20)];
        [self.lbl3 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl3 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl3 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl3 setNumberOfLines:0];
        [self addSubview:self.lbl3];
        
    }
    return self;
}

@end
