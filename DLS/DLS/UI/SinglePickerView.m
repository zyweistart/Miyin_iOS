//
//  SinglePickerView.m
//  DLS
//
//  Created by Start on 3/18/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "SinglePickerView.h"
#define BGCOLOR [UIColor colorWithRed:(55/255.0) green:(55/255.0) blue:(55/255.0) alpha:0.5]

@implementation SinglePickerView

- (id)initWithFrame:(CGRect)rect WithArray:(NSArray*)array{
    self=[super initWithFrame:rect];
    if(self){
        [self setBackgroundColor:BGCOLOR];
        
        self.pickerArray=array;
        
        self.toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake1(0, 0, 320, 44)];
        self.toolBar.barStyle = UIBarStyleDefault;
        [self.toolBar sizeToFit];
        UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel:)];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
        NSArray *barItems=[NSArray arrayWithObjects:btnCancel,flexibleSpace,btnDone,nil];
        [self.toolBar setItems:barItems animated:YES];
        [self addSubview:self.toolBar];
        
        self.picker=[[UIPickerView alloc]initWithFrame:CGRectMake1(0, 44, 320, 216)];
        [self.picker setBackgroundColor:[UIColor whiteColor]];
        [self.picker setShowsSelectionIndicator:YES];
        [self.picker setDelegate:self];
        [self.picker setDataSource:self];
        [self addSubview:self.picker];
        [self hiddenView];
        
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        [self setUserInteractionEnabled:YES];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancel:)]];
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

- (void)cancel:(id)sender
{
//    [self.delegate pickerViewCancel:self.code];
    [self hiddenView];
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
    NSDictionary *d= [self.pickerArray objectAtIndex:row];
//    return [self.pickerArray objectAtIndex:row];
    return [d objectForKey:MKEY];
}

@end