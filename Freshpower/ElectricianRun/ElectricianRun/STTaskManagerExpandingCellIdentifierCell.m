//
//  STTaskManagerExpandingCellIdentifierCell.m
//  ElectricianRun
//
//  Created by Start on 2/20/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STTaskManagerExpandingCellIdentifierCell.h"

@implementation STTaskManagerExpandingCellIdentifierCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lblName=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 200, 20)];
        [_lblName setFont:[UIFont systemFontOfSize:12]];
        [_lblName setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self addSubview:_lblName];
        
        _lblSiteName=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, 150, 20)];
        [_lblSiteName setFont:[UIFont systemFontOfSize:12]];
        [_lblSiteName setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self addSubview:_lblSiteName];
        
        _lblTaskDate=[[UILabel alloc]initWithFrame:CGRectMake(160, 30, 150, 20)];
        [_lblTaskDate setFont:[UIFont systemFontOfSize:12]];
        [_lblTaskDate setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self addSubview:_lblTaskDate];
    }
    return self;
}

@end
