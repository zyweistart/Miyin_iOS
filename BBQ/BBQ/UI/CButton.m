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
        [self setBackgroundImage:[Common createImageWithColor:BUTTONNORMALCOLOR] forState:UIControlStateNormal];
        [self setBackgroundImage:[Common createImageWithColor:BUTTONPRESENDCOLOR] forState:UIControlStateHighlighted];
    }else if(type==2){
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[Common createImageWithColor:BUTTON2NORMALCOLOR] forState:UIControlStateNormal];
        [self setBackgroundImage:[Common createImageWithColor:BUTTON2PRESENDCOLOR] forState:UIControlStateHighlighted];
    }else if(type==3){
        [self setBackgroundImage:[Common createImageWithColor:BUTTON3NORMALCOLOR] forState:UIControlStateNormal];
        [self setBackgroundImage:[Common createImageWithColor:BUTTON3PRESENDCOLOR] forState:UIControlStateHighlighted];
    }else if(type==4){
        [self setBackgroundImage:[Common createImageWithColor:DEFAULTITLECOLOR(216)] forState:UIControlStateNormal];
        [self setBackgroundImage:[Common createImageWithColor:DEFAULTITLECOLOR(240)] forState:UIControlStateHighlighted];
    }else if(type==5){
        [self setBackgroundImage:[Common createImageWithColor:DEFAULTITLECOLORA(240,0.2)] forState:UIControlStateNormal];
        [self setBackgroundImage:[Common createImageWithColor:DEFAULTITLECOLOR(255)] forState:UIControlStateHighlighted];
    }else if(type==6){
        [self setTitleColor:DEFAULTITLECOLOR(150) forState:UIControlStateNormal];
        [self setBackgroundImage:[Common createImageWithColor:DEFAULTITLECOLORA(240,0.8)] forState:UIControlStateNormal];
        [self setBackgroundImage:[Common createImageWithColor:DEFAULTITLECOLOR(255)] forState:UIControlStateHighlighted];
    }else if(type==7){
        [self setBackgroundImage:[Common createImageWithColor:DEFAULTITLECOLORRGB(254, 112, 26)] forState:UIControlStateNormal];
        [self setBackgroundImage:[Common createImageWithColor:DEFAULTITLECOLORRGB(238, 190, 161)] forState:UIControlStateHighlighted];
    }else if(type==8){
        self.layer.borderWidth=1;
        self.layer.borderColor=DEFAULTITLECOLOR(150).CGColor;
        [self setTitleColor:DEFAULTITLECOLOR(150) forState:UIControlStateNormal];
        [self setBackgroundImage:[Common createImageWithColor:DEFAULTITLECOLOR(255)] forState:UIControlStateNormal];
        [self setBackgroundImage:[Common createImageWithColor:DEFAULTITLECOLORA(240,0.8)] forState:UIControlStateHighlighted];
    }else if(type==9){
        self.layer.cornerRadius=0;
        self.layer.shadowOffset = CGSizeMake(4,4);
        [self.layer setShadowOpacity:0.8];
        self.layer.shadowRadius = 4;
        [self.layer setShadowColor:[UIColor blackColor].CGColor];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[Common createImageWithColor:DEFAULTITLECOLORA(255,0.2)] forState:UIControlStateNormal];
        [self setBackgroundImage:[Common createImageWithColor:DEFAULTITLECOLORA(240,0.8)] forState:UIControlStateHighlighted];
    }else{
        [self setBackgroundImage:[Common createImageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
        [self setBackgroundImage:[Common createImageWithColor:[UIColor clearColor]] forState:UIControlStateHighlighted];
    }
}

@end
