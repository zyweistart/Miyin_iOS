//
//  SVButton.m
//  eClient
//
//  Created by Start on 3/21/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "SVButton.h"

#define BUTTON1NORMALCOLOR [UIColor colorWithRed:(57/255.0) green:(87/255.0) blue:(207/255.0) alpha:1]
#define BUTTON1PRESENDCOLOR [UIColor colorWithRed:(107/255.0) green:(124/255.0) blue:(194/255.0) alpha:1]

#define BUTTON2NORMALCOLOR [UIColor colorWithRed:(254/255.0) green:(148/255.0) blue:(0/255.0) alpha:1]
#define BUTTON2PRESENDCOLOR [UIColor colorWithRed:(233/255.0) green:(195/255.0) blue:(142/255.0) alpha:1]

#define BUTTON3NORMALCOLOR [UIColor colorWithRed:(25/255.0) green:(10/255.0) blue:(164/255.0) alpha:1]
#define BUTTON3PRESENDCOLOR [UIColor colorWithRed:(93/255.0) green:(86/255.0) blue:(165/255.0) alpha:1]

#define ENABLEDCOLOR [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1]

@implementation SVButton

- (id)initWithFrame:(CGRect)rect Title:(NSString*)title Type:(NSInteger)type{
    self=[super initWithFrame:rect];
    if(self){
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [self setTitle:title forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self setBackgroundImage:[Common createImageWithColor:ENABLEDCOLOR] forState:UIControlStateDisabled];
        if(type==1){
            [self setBackgroundImage:[Common createImageWithColor:BUTTON1NORMALCOLOR] forState:UIControlStateNormal];
            [self setBackgroundImage:[Common createImageWithColor:BUTTON1PRESENDCOLOR] forState:UIControlStateHighlighted];
        }else if(type==2){
            [self setBackgroundImage:[Common createImageWithColor:BUTTON2NORMALCOLOR] forState:UIControlStateNormal];
            [self setBackgroundImage:[Common createImageWithColor:BUTTON2PRESENDCOLOR] forState:UIControlStateHighlighted];
        }else{
            [self setBackgroundImage:[Common createImageWithColor:BUTTON3NORMALCOLOR] forState:UIControlStateNormal];
            [self setBackgroundImage:[Common createImageWithColor:BUTTON3PRESENDCOLOR] forState:UIControlStateHighlighted];
        }
    }
    return self;
}

@end
