//
//  DataPickerView.m
//  ElectricianRun
//
//  Created by Start on 2/22/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "DataPickerView.h"

#define kWinSize [UIScreen mainScreen].bounds.size

@implementation DataPickerView

- (id)init{
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
        
        self.dataPicker = [[UIPickerView alloc] initWithFrame: datePickerFrame];
        [self.dataPicker setDelegate:self];
        [self addSubview: self.dataPicker];
    }
    return self;
}

- (id)initWithData:(NSArray *)data {
    self = [self init];
    if (self) {
        
        _data=data;
        
    }
    return self;
}

- (void)setData:(NSArray*)d{
    _data=d;
    [self.dataPicker reloadAllComponents];
}

#pragma mark - Actions
- (void)_done {
    NSInteger row=[self.dataPicker selectedRowInComponent:0];
    [_delegate pickerDidPressDoneWithRow:row];
}


- (void)_cancel {
    [_delegate pickerDidPressCancel];
}

#pragma mark - Delegate
//-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//    [self updateView:row];
//}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (!view) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];
        label.text = [Common NSNullConvertEmptyString:[_data objectAtIndex:row]];
        label.textColor = [UIColor blueColor];
        label.font=[UIFont systemFontOfSize:14];
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        [view addSubview:label];
    }
    return view ;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_data count];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0f;
}


@end
