//
//  SVTextField.h
//  eClient
//
//  Created by Start on 3/21/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TITLECOLOR [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1]

@interface SVTextField : UIView<UITextFieldDelegate>

@property UILabel *lbl;
@property UITextField *tf;

- (id)initWithFrame:(CGRect)rect Title:(NSString*)title;

@end
