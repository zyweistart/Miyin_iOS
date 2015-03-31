//
//  EnterpriseHeightLowCell.m
//  eClient
//
//  Created by Start on 3/31/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "EnterpriseHeightLowCell.h"
#define TITLE1COLOR [UIColor colorWithRed:(140/255.0) green:(140/255.0) blue:(140/255.0) alpha:1]
#define TITLE2COLOR [UIColor colorWithRed:(180/255.0) green:(180/255.0) blue:(180/255.0) alpha:1]

@implementation EnterpriseHeightLowCell

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
        [self setAccessoryType:UITableViewCellAccessoryNone];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setData:(NSDictionary*)data
{
    NSString *EQ_TYPE=[data objectForKey:@"EQ_TYPE"];
    if([@"1" isEqualToString:EQ_TYPE]){
        [self.lblName setText:[data objectForKey:@"EQ_NAME"]];
        [self.lblCount setText:[NSString stringWithFormat:@"倍率%@",[data objectForKey:@"EQ_MULTIPLY"]]];
        [self.lblPhone setHidden:YES];
    }else if([@"3" isEqualToString:EQ_TYPE]){
        [self.lblName setText:[data objectForKey:@"EQ_NAME"]];
        [self.lblCount setText:[NSString stringWithFormat:@"电压等级%@",[data objectForKey:@"EQ_U_LEVEL"]]];
        [self.lblPhone setText:[NSString stringWithFormat:@"倍率%@",[data objectForKey:@"EQ_MULTIPLY"]]];
    }else if([@"4" isEqualToString:EQ_TYPE]){
        [self.lblName setText:[data objectForKey:@"EQ_NAME"]];
        [self.lblCount setText:[NSString stringWithFormat:@"电压等级%@",[data objectForKey:@"EQ_U_LEVEL"]]];
        [self.lblPhone setHidden:YES];
    }else if([@"5" isEqualToString:EQ_TYPE]){
        [self.lblName setText:[data objectForKey:@"EQ_NAME"]];
        [self.lblCount setHidden:YES];
        [self.lblPhone setHidden:YES];
    }
}

@end