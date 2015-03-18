//
//  ButtonView.m
//  DLS
//
//  Created by Start on 3/18/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "ButtonView.h"

@implementation ButtonView

- (id)initWithFrame:(CGRect)rect Name:(NSString*)name{
    self=[super initWithFrame:rect];
    if(self){
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [self setTitle:name forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self setBackgroundImage:[Common createImageWithColor:BUTTONNORMALCOLOR] forState:UIControlStateNormal];
        [self setBackgroundImage:[Common createImageWithColor:BUTTONPRESENDCOLOR] forState:UIControlStateHighlighted];
        
    }
    return self;
}
@end
