//
//  DatePickerView.h
//  ElectricianRun
//
//  Created by Start on 2/22/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewDelegate

@optional

- (void)pickerDidPressDoneWithDate:(NSDate*)date;

- (void)pickerDidPressCancel;

@end


@interface DatePickerView : UIView

- (id)initWithPickerMode:(UIDatePickerMode)mode;

@property (nonatomic, strong) id<DatePickerViewDelegate> delegate;

@property (nonatomic, strong) UIDatePicker *datePicker;

@end
