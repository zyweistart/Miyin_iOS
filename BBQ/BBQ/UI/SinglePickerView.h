//
//  SinglePickerView.h
//  DLS
//
//  Created by Start on 3/18/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MKEY @"KEY"
#define MVALUE @"MVALUE"

@protocol PickerViewDelegate

@optional
- (void)pickerViewDone:(NSInteger)code;
//- (void)pickerViewCancel:(int)code;

@end

@interface SinglePickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property NSInteger code;
@property UIToolbar *toolBar;
@property UIPickerView *picker;
@property NSArray* pickerArray;

@property NSObject<PickerViewDelegate> *delegate;

- (id)initWithFrame:(CGRect)rect WithArray:(NSArray*)array;

- (void)showView;
- (void)hiddenView;

@end
