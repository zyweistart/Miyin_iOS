//
//  STTaskConsumptionCell.m
//  ElectricianRun
//
//  Created by Start on 3/9/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STTaskConsumptionCell.h"

@implementation STTaskConsumptionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lbl1=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 200, 30)];
        [self.lbl1 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl1 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl1 setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.lbl1];
        
        UITextField *txtValueUserName=[[UITextField alloc]initWithFrame:CGRectMake(5, 40, 150, 30)];
        [txtValueUserName setFont:[UIFont systemFontOfSize: 12.0]];
        [txtValueUserName setClearButtonMode:UITextFieldViewModeWhileEditing];
        [txtValueUserName setBorderStyle:UITextBorderStyleRoundedRect];
        [txtValueUserName setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [txtValueUserName setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self addSubview:txtValueUserName];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
