//
//  SVCheckbox.m
//  eClient
//
//  Created by Start on 3/24/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "SVCheckbox.h"

@implementation SVCheckbox

- (id)initWithFrame:(CGRect)rect{
    self=[super initWithFrame:rect];
    if(self){
        [self setFrame:rect];
        [self setImage:[UIImage imageNamed:@"未勾"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"勾"] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)checkboxClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

@end
