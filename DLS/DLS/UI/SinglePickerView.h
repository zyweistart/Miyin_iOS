//
//  SinglePickerView.h
//  DLS
//
//  Created by Start on 3/18/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonData.h"
#define MKEY @"KEY"
#define MVALUE @"MVALUE"

@protocol PickerViewDelegate

@optional
- (void)pickerViewDone:(int)code;
//- (void)pickerViewCancel:(int)code;

@end

@interface SinglePickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property UIPickerView *picker;
@property UIToolbar *toolBar;
@property NSArray* pickerArray;
@property NSInteger code;

@property NSObject<PickerViewDelegate> *delegate;

- (id)initWithFrame:(CGRect)rect WithArray:(NSArray*)array;

- (void)showView;
- (void)hiddenView;

@end
