//
//  CLabel.m
//  Ume
//
//  Created by Start on 5/20/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "CLabel.h"

@implementation CLabel

- (id)initWithFrame:(CGRect)rect Text:(NSString*)text
{
    self=[super initWithFrame:rect];
    if(self){
        [self setText:text];
        [self setTextColor:DEFAULTITLECOLOR(160)];
        [self setFont:[UIFont systemFontOfSize:14]];
        [self setTextAlignment:NSTextAlignmentLeft];
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

@end
