//
//  STInspection2Cell.m
//  ElectricianClient
//
//  Created by Start on 4/1/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STInspection2Cell.h"

@implementation STInspection2Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.lbl1=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 170, 40)];
        [self.lbl1 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl1 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl1 setTextAlignment:NSTextAlignmentRight];
        [self.lbl1 setNumberOfLines:0];
        [self addSubview:self.lbl1];
        
        self.lbl2=[[UILabel alloc]initWithFrame:CGRectMake(190, 0, 120, 40)];
        [self.lbl2 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl2 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl2 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl2 setNumberOfLines:0];
        [self addSubview:self.lbl2];
    }
    return self;
}

@end
