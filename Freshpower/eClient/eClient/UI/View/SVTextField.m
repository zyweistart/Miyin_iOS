//
//  SVTextField.m
//  eClient
//
//  Created by Start on 3/21/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "SVTextField.h"

@implementation SVTextField

- (id)initWithFrame:(CGRect)rect Title:(NSString*)title{
    self=[super initWithFrame:rect];
    if(self){
        CGFloat width=rect.size.width;
        CGFloat height=rect.size.height;
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [TITLECOLOR CGColor];
        self.lbl=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 50, height)];
        [self.lbl setText:title];
        [self.lbl setFont:[UIFont systemFontOfSize:14]];
        [self.lbl setTextAlignment:NSTextAlignmentCenter];
        [self.lbl setTextColor:TITLECOLOR];
        [self addSubview:self.lbl];
        self.tf=[[UITextField alloc]initWithFrame:CGRectMake1(50, 0,width-50, height)];
        [self.tf setTextColor:TITLECOLOR];
        [self.tf setFont:[UIFont systemFontOfSize:14]];
        [self.tf setDelegate:self];
        [self.tf setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self addSubview:self.tf];
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    CGPoint origin = textField.frame.origin;
//    CGPoint point = [textField.superview convertPoint:origin toView:scrollFrame];
//    float navBarHeight = self.navigationController.navigationBar.frame.size.height;
//    CGPoint offset = scrollFrame.contentOffset;
//    offset.y = (point.y - navBarHeight-40);
//    [self.mainFrame setContentOffset:offset animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
//    [self.mainFrame setContentOffset:CGPointMake(0, 0) animated:YES];
    return YES;
}

@end
