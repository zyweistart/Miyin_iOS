//
//  BurdenView.m
//  ElectricianClient
//
//  Created by Start on 3/26/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "BurdenView.h"

@implementation BurdenView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 65, 20)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"线路名称:"];
        [self addSubview:lbl];
        
        self.lbl1=[[UILabel alloc]initWithFrame:CGRectMake(75, 0, 85, 20)];
        [self.lbl1 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl1 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl1 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl1 setNumberOfLines:0];
        [self addSubview:self.lbl1];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(160, 0, 65, 20)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"当前负荷:"];
        [self addSubview:lbl];
        
        self.lbl2=[[UILabel alloc]initWithFrame:CGRectMake(230, 0, 85, 20)];
        [self.lbl2 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl2 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl2 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl2 setNumberOfLines:0];
        [self addSubview:self.lbl2];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 20, 65, 20)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"开关的状态:"];
        [self addSubview:lbl];
        
        self.lbl3=[[UILabel alloc]initWithFrame:CGRectMake(75, 20, 85, 20)];
        [self.lbl3 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl3 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl3 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl3 setNumberOfLines:0];
        [self addSubview:self.lbl3];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(160, 20, 65, 20)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"总功率因数:"];
        [self addSubview:lbl];
        
        self.lbl4=[[UILabel alloc]initWithFrame:CGRectMake(230, 20, 85, 20)];
        [self.lbl4 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl4 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl4 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl4 setNumberOfLines:0];
        [self addSubview:self.lbl4];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 40, 80, 20)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:@"三相ABC电流:"];
        [self addSubview:lbl];
        
        self.lbl5=[[UILabel alloc]initWithFrame:CGRectMake(90, 40, 215, 20)];
        [self.lbl5 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl5 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl5 setTextAlignment:NSTextAlignmentLeft];
        [self.lbl5 setNumberOfLines:0];
        [self addSubview:self.lbl5];
        
    }
    return self;
}

@end
