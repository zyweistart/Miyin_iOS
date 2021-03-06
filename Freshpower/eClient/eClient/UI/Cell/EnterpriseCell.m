//
//  EnterpriseCell.m
//  eClient
//
//  Created by Start on 3/31/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "EnterpriseCell.h"
#define TITLE1COLOR [UIColor colorWithRed:(140/255.0) green:(140/255.0) blue:(140/255.0) alpha:1]
#define TITLE2COLOR [UIColor colorWithRed:(180/255.0) green:(180/255.0) blue:(180/255.0) alpha:1]

@implementation EnterpriseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 60)];
        [self addSubview:frame];
        self.lblName=[[UILabel alloc]initWithFrame:CGRectMake1(10,5, 300, 25)];
        [self.lblName setTextColor:TITLE1COLOR];
        [self.lblName setFont:[UIFont systemFontOfSize:17]];
        [self.lblName setTextAlignment:NSTextAlignmentLeft];
        [frame addSubview:self.lblName];
        self.lblCount=[[UILabel alloc]initWithFrame:CGRectMake1(10,35, 150, 20)];
        [self.lblCount setTextColor:TITLE2COLOR];
        [self.lblCount setFont:[UIFont systemFontOfSize:14]];
        [self.lblCount setTextAlignment:NSTextAlignmentLeft];
        [frame addSubview:self.lblCount];
        self.lblPhone=[[UILabel alloc]initWithFrame:CGRectMake1(160,35, 120, 20)];
        [self.lblPhone setTextColor:TITLE2COLOR];
        [self.lblPhone setFont:[UIFont systemFontOfSize:14]];
        [self.lblPhone setTextAlignment:NSTextAlignmentRight];
        [frame addSubview:self.lblPhone];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}

- (void)setData:(NSDictionary*)data
{
    [self.lblName setText:[data objectForKey:@"NAME"]];
    [self.lblCount setText:[NSString stringWithFormat:@"变压器数量:%@",[data objectForKey:@"EQ_COUNT"]]];
    [self.lblPhone setText:[data objectForKey:@"TEL"]];
}

@end
