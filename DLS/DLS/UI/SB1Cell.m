//
//  SB1Cell.m
//  DLS
//
//  Created by Start on 3/20/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "SB1Cell.h"

#define TITLECOLOR [UIColor colorWithRed:(127/255.0) green:(127/255.0) blue:(127/255.0) alpha:1]

@implementation SB1Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0,0,320,40)];
        [frame setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:frame];
        
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 100, 40)];
        [lbl setText:@"设备类型"];
        [lbl setTextColor:TITLECOLOR];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [frame addSubview:lbl];
        
        self.lblType=[[UILabel alloc]initWithFrame:CGRectMake1(120, 0, 70, 40)];
        [self.lblType setTextColor:TITLECOLOR];
        [self.lblType setFont:[UIFont systemFontOfSize:14]];
        [self.lblType setTextAlignment:NSTextAlignmentRight];
        [frame addSubview:self.lblType];
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(200, 11, 9, 18)];
        [image setImage:[UIImage imageNamed:@"arrowright"]];
        [frame addSubview:image];
        self.lblNumber=[[UILabel alloc]initWithFrame:CGRectMake1(220, 0, 70, 40)];
        [self.lblNumber setTextColor:TITLECOLOR];
        [self.lblNumber setFont:[UIFont systemFontOfSize:14]];
        [self.lblNumber setTextAlignment:NSTextAlignmentRight];
        [frame addSubview:self.lblNumber];
        image=[[UIImageView alloc]initWithFrame:CGRectMake1(300, 11, 9, 18)];
        [image setImage:[UIImage imageNamed:@"arrowright"]];
        [frame addSubview:image];
    }
    return self;
}

@end
