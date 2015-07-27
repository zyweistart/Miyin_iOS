//
//  CButton.h
//  Ume
//
//  Created by Start on 5/20/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BUTTONNORMALCOLOR [UIColor colorWithRed:(57/255.0) green:(87/255.0) blue:(207/255.0) alpha:1]
#define BUTTONPRESENDCOLOR [UIColor colorWithRed:(107/255.0) green:(124/255.0) blue:(194/255.0) alpha:1]

#define BUTTON2NORMALCOLOR [UIColor colorWithRed:(255/255.0) green:(216/255.0) blue:(0/255.0) alpha:1]
#define BUTTON2PRESENDCOLOR [UIColor colorWithRed:(228/255.0) green:(212/255.0) blue:(124/255.0) alpha:1]
#define BUTTON3NORMALCOLOR [UIColor colorWithRed:(57/255.0) green:(87/255.0) blue:(207/255.0) alpha:1]
#define BUTTON3PRESENDCOLOR [UIColor colorWithRed:(107/255.0) green:(124/255.0) blue:(194/255.0) alpha:1]

@interface CButton : UIButton

- (id)initWithFrame:(CGRect)rect Name:(NSString*)name;
- (id)initWithFrame:(CGRect)rect Name:(NSString*)name Type:(int)type;

- (void)setType:(int)type;

@end
