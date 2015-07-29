//
//  CButton.m
//  Ume
//
//  Created by Start on 5/20/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "CButton.h"

@implementation CButton

- (id)initWithFrame:(CGRect)rect Name:(NSString*)name{
    return [self initWithFrame:rect Name:name Type:1];
}

- (id)initWithFrame:(CGRect)rect Name:(NSString*)name Type:(int)type{
    
    self=[super initWithFrame:rect];
    if(self){
        self.layer.cornerRadius = CGWidth(7);
        self.layer.masksToBounds = YES;
        [self setTitle:name forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self setType:type];
    }
    return self;
}

- (void)setType:(int)type
{
    self.layer.borderWidth=0;
    self.layer.borderColor=[UIColor clearColor].CGColor;
    if(type==1){
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[Common createImageWithColor:DEFAULTITLECOLORRGB(242, 125, 0)] forState:UIControlStateNormal];
        [self setBackgroundImage:[Common createImageWithColor:DEFAULTITLECOLORRGB(238, 166, 89)] forState:UIControlStateHighlighted];
    }else{
        [self setBackgroundImage:[Common createImageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
        [self setBackgroundImage:[Common createImageWithColor:[UIColor clearColor]] forState:UIControlStateHighlighted];
    }
}

@end
