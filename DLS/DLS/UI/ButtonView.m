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
    return [self initWithFrame:rect Name:name Type:1];
}

- (id)initWithFrame:(CGRect)rect Name:(NSString*)name Type:(int)type{
    
    self=[super initWithFrame:rect];
    if(self){
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [self setTitle:name forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        if(type==1){
            [self setBackgroundImage:[Common createImageWithColor:BUTTONNORMALCOLOR] forState:UIControlStateNormal];
            [self setBackgroundImage:[Common createImageWithColor:BUTTONPRESENDCOLOR] forState:UIControlStateHighlighted];
        }else{
            [self setBackgroundImage:[Common createImageWithColor:BUTTON2ORMALCOLOR] forState:UIControlStateNormal];
            [self setBackgroundImage:[Common createImageWithColor:BUTTON2PRESENDCOLOR] forState:UIControlStateHighlighted];
        }
        
    }
    return self;
}


@end
