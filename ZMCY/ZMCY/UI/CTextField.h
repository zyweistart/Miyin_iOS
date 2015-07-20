//
//  CTextField.h
//  Ume
//
//  Created by Start on 5/20/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTextField : UITextField<UITextFieldDelegate>{
    BOOL isEnablePadding;
    float paddingLeft;
    float paddingRight;
    float paddingTop;
    float paddingBottom;
}

@property CGFloat width;
@property CGFloat height;
@property (strong,nonatomic)UIScrollView *scrollFrame;

- (id)initWithFrame:(CGRect)rect Placeholder:(NSString*)ph;

- (void)setPadding:(BOOL)enable top:(float)top right:(float)right bottom:(float)bottom left:(float)left;

@end
