//
//  STAlarmManagerSearchViewController.m
//  ElectricianRun
//
//  Created by Start on 2/21/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STAlarmManagerSearchViewController.h"
#import "DataPickerView.h"
#import "STAlarmManagerSearchListViewController.h"

@interface STAlarmManagerSearchViewController () <DataPickerViewDelegate>

@end

@implementation STAlarmManagerSearchViewController {
    UITextField *txtValueName;
    UITextField *txtValueLevel;
    UITextField *txtValueCategory;
    DataPickerView *leveldpv;
    DataPickerView *categorydpv;
    NSArray *data1;
    NSArray *data2;
    NSInteger levelIndex;
    NSInteger categoryIndex;
    
}


- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        self.title=@"报警查询";
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"查询"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(search:)];
        levelIndex=[[data objectForKey:@"QTKEY"]intValue];
        categoryIndex=[[data objectForKey:@"QTKEY2"]intValue];
        
        data1=[[NSArray alloc]initWithObjects:@"--选择--",@"一般报警",@"紧急报警",@"重要报警", nil];
        leveldpv=[[DataPickerView alloc]initWithData:data1];
        [leveldpv setDelegate:self];
        data2=[[NSArray alloc]initWithObjects:@"--选择--",@"状态报警",@"超限报警",@"内部故障", nil];
        categorydpv=[[DataPickerView alloc]initWithData:data2];
        [categorydpv setDelegate:self];
        
        UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 100, 320, 300)];
        [control addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:control];
        
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(30, 10, 60, 30)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:@"客户名称"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [control addSubview:lbl];
        
        txtValueName=[[UITextField alloc]initWithFrame:CGRectMake(100, 10, 150, 30)];
        [txtValueName setFont:[UIFont systemFontOfSize: 12.0]];
        [txtValueName setClearButtonMode:UITextFieldViewModeWhileEditing];
        [txtValueName setBorderStyle:UITextBorderStyleRoundedRect];
        [txtValueName setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [txtValueName setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [txtValueName setText:[data objectForKey:@"QTKEY1"]];
        [control addSubview:txtValueName];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(30, 50, 60, 30)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:@"报警级别"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [control addSubview:lbl];
        
        txtValueLevel=[[UITextField alloc]initWithFrame:CGRectMake(100, 50, 150, 30)];
        [txtValueLevel setFont:[UIFont systemFontOfSize: 12.0]];
        [txtValueLevel setClearButtonMode:UITextFieldViewModeWhileEditing];
        [txtValueLevel setBorderStyle:UITextBorderStyleRoundedRect];
        [txtValueLevel setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [txtValueLevel setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [txtValueLevel setKeyboardType:UIKeyboardTypePhonePad];
        [txtValueLevel setInputView:leveldpv];
        [txtValueLevel setText:[data1 objectAtIndex:levelIndex]];
        [control addSubview:txtValueLevel];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(30, 90, 60, 30)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:@"报警分类"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [control addSubview:lbl];
        
        txtValueCategory=[[UITextField alloc]initWithFrame:CGRectMake(100, 90, 150, 30)];
        [txtValueCategory setFont:[UIFont systemFontOfSize: 12.0]];
        [txtValueCategory setClearButtonMode:UITextFieldViewModeWhileEditing];
        [txtValueCategory setBorderStyle:UITextBorderStyleRoundedRect];
        [txtValueCategory setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [txtValueCategory setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [txtValueCategory setKeyboardType:UIKeyboardTypePhonePad];
        [txtValueCategory setInputView:categorydpv];
        [txtValueCategory setText:[data2 objectAtIndex:categoryIndex]];
        [control addSubview:txtValueCategory];
        
    }
    return self;
}

- (void)backgroundDoneEditing:(id)sender {
    [txtValueName resignFirstResponder];
    [txtValueLevel resignFirstResponder];
    [txtValueCategory resignFirstResponder];
}

- (void)search:(id)sender {
    NSString *name=[txtValueName text];
//    NSString *level=[txtValueLevel text];
//    NSString *category=[txtValueCategory text];
    
    NSMutableDictionary *data=[[NSMutableDictionary alloc]init];
    [data setObject:name forKey:@"QTKEY1"];
    [data setObject:[NSString stringWithFormat:@"%d",levelIndex] forKey:@"QTKEY"];
    [data setObject:[NSString stringWithFormat:@"%d",categoryIndex] forKey:@"QTKEY2"];
//    [self.delegate startSearch:data];
//    [self.navigationController popViewControllerAnimated:YES];
    
    STAlarmManagerSearchListViewController *alarmManagerSearchListViewController=[[STAlarmManagerSearchListViewController alloc]initWithData:data];
    [self.navigationController pushViewController:alarmManagerSearchListViewController animated:YES];
    
}

- (void)pickerDidPressDoneWithRow:(NSInteger)row {
    if([txtValueLevel isFirstResponder]){
//        if(row!=0){
            [txtValueLevel setText:[data1 objectAtIndex:row]];
//        }
        levelIndex=row;
        [txtValueLevel resignFirstResponder];
    }
    if([txtValueCategory isFirstResponder]){
//        if(row!=0){
            [txtValueCategory setText:[data2 objectAtIndex:row]];
//        }
        categoryIndex=row;
        [txtValueCategory resignFirstResponder];
    }
}

- (void)pickerDidPressCancel{
    if([txtValueLevel isFirstResponder]){
        [txtValueLevel resignFirstResponder];
    }
    if([txtValueCategory isFirstResponder]){
        [txtValueCategory resignFirstResponder];
    }
}

@end
