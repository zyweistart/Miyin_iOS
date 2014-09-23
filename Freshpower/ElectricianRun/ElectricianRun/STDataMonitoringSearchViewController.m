//
//  STDataMonitoringSearchViewController.m
//  ElectricianRun
//
//  Created by Start on 2/21/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STDataMonitoringSearchViewController.h"
#import "STDataMonitoringSearchListViewController.h"

@interface STDataMonitoringSearchViewController ()

@end

@implementation STDataMonitoringSearchViewController {
    UITextField *txtValueName;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title=@"查询";
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"查询"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(search:)];
        UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 64, 320, 300)];
        //    [control addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:control];
        
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(30, 100, 60, 30)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:@"客户名称"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [control addSubview:lbl];
        
        txtValueName=[[UITextField alloc]initWithFrame:CGRectMake(100, 100, 150, 30)];
        [txtValueName setFont:[UIFont systemFontOfSize: 12.0]];
        [txtValueName setClearButtonMode:UITextFieldViewModeWhileEditing];
        [txtValueName setBorderStyle:UITextBorderStyleRoundedRect];
        [txtValueName setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [txtValueName setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [txtValueName setText:@""];
        [control addSubview:txtValueName];
        
        
    }
    return self;
}

- (void)search:(id)sender {
    NSString *name=[txtValueName text];
    NSMutableDictionary *data=[[NSMutableDictionary alloc]init];
    [data setObject:name forKey:@"name"];
    
    STDataMonitoringSearchListViewController *dataMonitoringSearchListViewController=[[STDataMonitoringSearchListViewController alloc]initWithData:data];
    [self.navigationController pushViewController:dataMonitoringSearchListViewController animated:YES];
    [dataMonitoringSearchListViewController autoRefresh];
    
}

@end
