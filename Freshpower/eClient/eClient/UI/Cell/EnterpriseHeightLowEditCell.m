//
//  EnterpriseHeightLowEditCell.m
//  eClient
//
//  Created by Start on 3/31/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "EnterpriseHeightLowEditCell.h"

#define TITLE1COLOR [UIColor colorWithRed:(140/255.0) green:(140/255.0) blue:(140/255.0) alpha:1]
#define TITLE2COLOR [UIColor colorWithRed:(180/255.0) green:(180/255.0) blue:(180/255.0) alpha:1]
#define TITLE3COLOR [UIColor colorWithRed:(120/255.0) green:(120/255.0) blue:(120/255.0) alpha:1]

#define rect1 CGRectMake1(10,5, 200, 25)
#define rect2 CGRectMake1(10,35, 100, 20)

#define rect3 CGRectMake1(30,5, 200, 25)
#define rect4 CGRectMake1(30,35, 100, 20)

#define rect5 CGRectMake1(30,15, 100, 25)

@implementation EnterpriseHeightLowEditCell{
    NSDictionary *currentData;
    UIButton *add;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 60)];
        [self addSubview:frame];
        self.lblName=[[UILabel alloc]initWithFrame:rect1];
        [self.lblName setTextColor:TITLE1COLOR];
        [self.lblName setFont:[UIFont systemFontOfSize:17]];
        [self.lblName setTextAlignment:NSTextAlignmentLeft];
        [frame addSubview:self.lblName];
        self.lblCount=[[UILabel alloc]initWithFrame:rect2];
        [self.lblCount setTextColor:TITLE2COLOR];
        [self.lblCount setFont:[UIFont systemFontOfSize:14]];
        [self.lblCount setTextAlignment:NSTextAlignmentLeft];
        [frame addSubview:self.lblCount];
        self.lblPhone=[[UILabel alloc]initWithFrame:CGRectMake1(160,35, 120, 20)];
        [self.lblPhone setTextColor:TITLE2COLOR];
        [self.lblPhone setFont:[UIFont systemFontOfSize:14]];
        [self.lblPhone setTextAlignment:NSTextAlignmentRight];
        [frame addSubview:self.lblPhone];
        add=[[UIButton alloc]initWithFrame:CGRectMake1(230, 5, 80, 30)];
        [add setTitle:@"+添加变压器" forState:UIControlStateNormal];
        [add setTitleColor:TITLE3COLOR forState:UIControlStateNormal];
        [[add titleLabel]setFont:[UIFont systemFontOfSize:14]];
        [add addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
        [frame addSubview:add];
        [self setAccessoryType:UITableViewCellAccessoryNone];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setData:(NSDictionary*)data
{
    currentData=data;
    NSString *EQ_TYPE=[data objectForKey:@"EQ_TYPE"];
    if([@"1" isEqualToString:EQ_TYPE]){
        [self.lblName setFrame:rect1];
        [self.lblCount setFrame:rect2];
        [self.lblName setText:[data objectForKey:@"EQ_NAME"]];
        [self.lblCount setText:[NSString stringWithFormat:@"倍率%@",[data objectForKey:@"EQ_MULTIPLY"]]];
        [self.lblPhone setText:@""];
        [add setHidden:NO];
    }else if([@"3" isEqualToString:EQ_TYPE]){
        [self.lblName setFrame:rect3];
        [self.lblCount setFrame:rect4];
        [self.lblName setText:[data objectForKey:@"EQ_NAME"]];
        [self.lblCount setText:[NSString stringWithFormat:@"电压等级%@",[data objectForKey:@"EQ_U_LEVEL"]]];
        [self.lblPhone setText:[NSString stringWithFormat:@"倍率%@",[data objectForKey:@"EQ_MULTIPLY"]]];
        [add setHidden:YES];
    }else if([@"4" isEqualToString:EQ_TYPE]){
        [self.lblName setFrame:rect1];
        [self.lblCount setFrame:rect2];
        [self.lblName setText:[data objectForKey:@"EQ_NAME"]];
        [self.lblCount setText:[NSString stringWithFormat:@"电压等级%@",[data objectForKey:@"EQ_U_LEVEL"]]];
        [self.lblPhone setText:@""];
        [add setHidden:YES];
    }else if([@"5" isEqualToString:EQ_TYPE]){
        [self.lblName setFrame:rect5];
        [self.lblName setText:[data objectForKey:@"EQ_NAME"]];
        [self.lblCount setText:@""];
        [self.lblPhone setText:@""];
        [add setHidden:YES];
    }
}

- (void)add:(id)sender
{
    NSString *cname=@"这是测试aaaa";
    NSMutableDictionary *data=[[NSMutableDictionary alloc]init];
    //添加变压器
    [data setObject:cname forKey:@"EQ_NAME"];
    [data setObject:@"55.00" forKey:@"EQ_U_LEVEL"];
    [data setObject:@"55.00" forKey:@"EQ_MULTIPLY"];
    [data setObject:@"3" forKey:@"EQ_TYPE"];
    [data setObject:@"0" forKey:@"EQ_SORTNO"];
    for(id d in self.dataItemArray){
        NSString *name=[d objectForKey:@"EQ_NAME"];
        if([cname isEqualToString:name]){
            [Common alert:[NSString stringWithFormat:@"%@已经存在，不能重复添加",cname]];
            return;
        }
    }
    NSString *name=[currentData objectForKey:@"EQ_NAME"];
    NSMutableArray *tmpArray=[[NSMutableArray alloc]init];
    for(id d in self.dataItemArray){
        [tmpArray addObject:d];
        NSString *tmpName=[d objectForKey:@"EQ_NAME"];
        if([name isEqualToString:tmpName]){
            [tmpArray addObject:data];
        }
    }
    [self.dataItemArray removeAllObjects];
    [self.dataItemArray addObjectsFromArray:tmpArray];
    [self.tableView reloadData];
}

@end