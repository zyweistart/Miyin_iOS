//
//  ProjectACell.m
//  DLS
//
//  Created by Start on 3/8/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "ProjectACell.h"
#define TITLECOLOR [UIColor colorWithRed:(60/255.0) green:(60/255.0) blue:(60/255.0) alpha:1]
#define CHILDCOLOR [UIColor colorWithRed:(142/255.0) green:(142/255.0) blue:(142/255.0) alpha:1]

@implementation ProjectACell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        UIView *mainView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 55)];
        [self addSubview:mainView];
        self.title=[[UILabel alloc]initWithFrame:CGRectMake1(10, 5, 195, 25)];
        [self.title setFont:[UIFont systemFontOfSize:17]];
        [self.title setTextColor:TITLECOLOR];
        [self.title setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:self.title];
        self.address=[[UILabel alloc]initWithFrame:CGRectMake1(10, 30, 195, 20)];
        [self.address setFont:[UIFont systemFontOfSize:13]];
        [self.address setTextColor:CHILDCOLOR];
        [self.address setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:self.address];
        self.date=[[UILabel alloc]initWithFrame:CGRectMake1(205, 15, 85, 20)];
        [self.date setFont:[UIFont systemFontOfSize:13]];
        [self.date setTextColor:CHILDCOLOR];
        [self.date setTextAlignment:NSTextAlignmentCenter];
        [mainView addSubview:self.date];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}

- (void)setData:(NSDictionary *)data
{
    self.title.text=[Common getString:[data objectForKey:@"job_title"]];
    self.address.text=[Common getString:[data objectForKey:@"address"]];
    self.date.text=[Common convertTime:[data objectForKey:@"CreateDate"]];
}

@end
