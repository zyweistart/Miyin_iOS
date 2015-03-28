//
//  SVTextView.h
//  eClient
//
//  Created by Start on 3/29/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TITLECOLOR [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1]

@interface SVTextView : UITextView<UITextViewDelegate>

@property UILabel *lbl;
@property UITextView *tf;

- (id)initWithFrame:(CGRect)rect Title:(NSString*)title;

@end
