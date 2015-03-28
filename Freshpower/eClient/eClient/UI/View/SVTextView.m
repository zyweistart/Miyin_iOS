//
//  SVTextView.m
//  eClient
//
//  Created by Start on 3/29/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "SVTextView.h"

@implementation SVTextView

- (id)initWithFrame:(CGRect)rect Title:(NSString*)title{
    self=[super initWithFrame:rect];
    if(self){
        CGFloat width=rect.size.width;
        CGFloat height=rect.size.height;
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [TITLECOLOR CGColor];
        if(title){
            self.lbl=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 50, 40)];
            [self.lbl setText:title];
            [self.lbl setFont:[UIFont systemFontOfSize:14]];
            [self.lbl setTextAlignment:NSTextAlignmentCenter];
            [self.lbl setTextColor:TITLECOLOR];
            [self addSubview:self.lbl];
            self.tf=[[UITextView alloc]initWithFrame:CGRectMake1(50, 0,width-50, height)];
        }else{
            self.tf=[[UITextView alloc]initWithFrame:CGRectMake1(0, 0,width, height)];
        }
        [self.tf setTextColor:TITLECOLOR];
        [self.tf setFont:[UIFont systemFontOfSize:14]];
        [self.tf setDelegate:self];
        [self addSubview:self.tf];
    }
    return self;
}

- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*) text
{
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }else{
        return YES;
    }
}



@end
