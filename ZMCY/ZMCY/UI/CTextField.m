//
//  CTextField.m
//  Ume
//
//  Created by Start on 5/20/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "CTextField.h"
#define  NAVIGATION_BAR_HEIGHT 40

@implementation CTextField

- (id)initWithFrame:(CGRect)rect Placeholder:(NSString*)ph
{
    self=[super initWithFrame:rect];
    if(self){
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth=1;
        self.layer.borderColor=DEFAULTITLECOLOR(190).CGColor;
        [self setPlaceholder:ph];
        [self setDelegate:self];
        [self setTextColor:DEFAULTITLECOLOR(190)];
        [self setFont:[UIFont systemFontOfSize:14]];
        [self setTextAlignment:NSTextAlignmentLeft];
        [self setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self setPadding:YES top:0 right:5 bottom:0 left:5];
    }
    return self;
}

- (void)setPadding:(BOOL)enable top:(float)top right:(float)right bottom:(float)bottom left:(float)left {
    isEnablePadding = enable;
    paddingTop = top;
    paddingRight = right;
    paddingBottom = bottom;
    paddingLeft = left;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    if (isEnablePadding) {
        return CGRectMake(bounds.origin.x + paddingLeft,
                          bounds.origin.y + paddingTop,
                          bounds.size.width - paddingRight, bounds.size.height - paddingBottom);
    } else {
        return CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
    }
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.scrollFrame.contentSize = CGSizeMake1(self.width,self.height+216);
    CGPoint pt = [textField convertPoint:CGPointMake(0, 0) toView:self.scrollFrame];
    if(self.scrollFrame.contentOffset.y-pt.y+NAVIGATION_BAR_HEIGHT<=0){
        [self.scrollFrame setContentOffset:CGPointMake(0, pt.y-NAVIGATION_BAR_HEIGHT) animated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    //开始动画
    [UIView beginAnimations:nil context:nil];
    //设定动画持续时间
    [UIView setAnimationDuration:0.3];
    self.scrollFrame.contentSize = CGSizeMake1(self.width,self.height);
    //动画结束
    [UIView commitAnimations];
    return YES;
}

@end