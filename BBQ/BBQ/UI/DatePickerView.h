//
//  SinglePickerView.h
//  DLS
//
//  Created by Start on 3/18/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerViewDelegate

@optional
- (void)pickerViewDone:(NSInteger)code;
- (void)pickerViewCancel:(NSInteger)code;

@end

@interface DatePickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property NSInteger code;
@property UIToolbar *toolBar;
@property UIPickerView *picker;

@property NSObject<PickerViewDelegate> *delegate;

- (void)showView;
- (void)hiddenView;
- (void)setLanguage;

@end
