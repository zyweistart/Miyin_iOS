//
//  SinglePickerView.m
//  DLS
//
//  Created by Start on 3/18/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "SinglePickerView.h"

@implementation SinglePickerView

- (id)initWithFrame:(CGRect)rect WithArray:(NSArray*)array{
    self=[super initWithFrame:rect];
    if(self){
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.pickerArray=array;
        
        self.toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake1(0, 0, 320, 44)];
        self.toolBar.barStyle = UIBarStyleDefault;
        [self.toolBar sizeToFit];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
        NSArray *barItems=[NSArray arrayWithObjects:flexibleSpace,btnDone,nil];
        [self.toolBar setItems:barItems animated:YES];
        [self addSubview:self.toolBar];
        
        self.picker=[[UIPickerView alloc]initWithFrame:CGRectMake1(0, 44, 320, 216)];
        [self.picker setShowsSelectionIndicator:YES];
        [self.picker setDelegate:self];
        [self.picker setDataSource:self];
        [self addSubview:self.picker];
        [self hiddenView];
    }
    return self;
}

- (void)showView
{
    [self setHidden:NO];
}

- (void)hiddenView
{
    [self setHidden:YES];
}

- (void)done:(id)sender
{
    [self.delegate pickerViewDone:self.code];
    [self hiddenView];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerArray count];
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerArray objectAtIndex:row];
}

@end