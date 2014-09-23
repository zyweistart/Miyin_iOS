//
//  DatePickerView.m
//  ElectricianRun
//
//  Created by Start on 2/22/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "DatePickerView.h"

#define kWinSize [UIScreen mainScreen].bounds.size

@implementation DatePickerView

- (id)init {
    return [self initWithPickerMode:UIDatePickerModeDate];
}

- (id)initWithPickerMode:(UIDatePickerMode)mode {
    self = [super init];
    if (self) {
        CGRect datePickerFrame = CGRectMake((kWinSize.width - kWinSize.width) / 2, 42, 320.0, 216.0);
        UIToolbar *toolbar = [[UIToolbar alloc]
                              initWithFrame: CGRectMake(0, 0, kWinSize.width, 44.0)];
        
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                         initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
                                         target: self
                                         action: @selector(_cancel)];
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                      target: self
                                      action: nil];
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem: UIBarButtonSystemItemDone
                                    target: self
                                    action: @selector(_done)];
        
        [toolbar setItems: [NSArray arrayWithObjects:cancelButton,flexSpace,doneBtn, nil]
                 animated: YES];
        [self addSubview: toolbar];
        
        self.frame = CGRectMake(0.0, 312.0, kWinSize.width, 256.0);
        _datePicker = [[UIDatePicker alloc] initWithFrame: datePickerFrame];
        [_datePicker setDatePickerMode:mode];
        [self addSubview: _datePicker];
    }
    return self;
}

#pragma mark - Actions
- (void)_done {
    [_delegate pickerDidPressDoneWithDate:[_datePicker date]];
}


- (void)_cancel {
    [_delegate pickerDidPressCancel];
}


@end
