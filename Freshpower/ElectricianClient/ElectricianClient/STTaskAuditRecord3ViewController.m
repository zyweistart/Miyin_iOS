//
//  STTaskAuditRecord3ViewController.m
//  ElectricianRun
//
//  Created by Start on 2/20/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STTaskAuditRecord3ViewController.h"

#define REQUESTCODEBUILDDATA 573824

@interface STTaskAuditRecord3ViewController ()

@end

@implementation STTaskAuditRecord3ViewController {
    
    NSDictionary *_dic;
    NSDictionary *_data;
    NSString *_taskId;
    NSString *_gnid;
    NSInteger _type;
    UIScrollView *scroll;
    NSArray *dataItemArray;
}


- (id)initWithData:(NSDictionary *)data dic:(NSDictionary *)dic type:(NSInteger)t
{
    self=[super init];
    if(self){
        self.title=[dic objectForKey:@"NAME"];
        [self.view setBackgroundColor:[UIColor whiteColor]];
        _data=data;
        _dic=dic;
        _taskId=[dic objectForKey:@"TASK_ID"];
        _type=t;
        if(_type==1){
            _gnid=@"RW16";
        }else if(_type==2){
            _gnid=@"RW15";
        }else if(_type==3){
            _gnid=@"RW17";
        }else if(_type==4){
            _gnid=@"RW17";
        }
    }
    return self;
}

- (void)reloadDataSource
{
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[Account getUserName] forKey:@"imei"];
    [p setObject:[Account getPassword] forKey:@"authentication"];
    [p setObject:_gnid forKey:@"GNID"];
    [p setObject:_taskId forKey:@"QTTASK"];
    [p setObject:[_dic objectForKey:@"EQUIPMENT_ID"] forKey:@"QTKEY"];
    [p setObject:@"" forKey:@"QTKEY1"];
    
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:REQUESTCODEBUILDDATA];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest start:URLAppMonitoringAlarm params:p];
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode
{
    NSDictionary *json=[response resultJSON];
    if(json!=nil) {
        NSDictionary *pageinfo=[json objectForKey:@"Rows"];
        if(REQUESTCODEBUILDDATA==repCode){
            int result=[[pageinfo objectForKey:@"result"] intValue];
            if(result>0){
                dataItemArray=[json objectForKey:@"table1"];
                [self buildUI:dataItemArray];
            } else {
                [Common alert:[pageinfo objectForKey:@"remark"]];
            }
        }
    }
}

- (void)buildUI:(NSArray *)array
{
    self.automaticallyAdjustsScrollViewInsets=NO;
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 70, 320, 400)];
    [scroll setBackgroundColor:[UIColor whiteColor]];
    scroll.contentSize = CGSizeMake(320,[array count]*60);
    [scroll setScrollEnabled:YES];
    [self.view addSubview:scroll];
    
    for(int i=0;i<[array count];i++){
        NSDictionary *d=[array objectAtIndex:i];
        int height=(i+1)*5+i*30;
        UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(5, height, 150, 30)];
        [lbl1 setFont:[UIFont systemFontOfSize:10]];
        [lbl1 setTextColor:[UIColor blackColor]];
        [lbl1 setTextAlignment:NSTextAlignmentRight];
        [lbl1 setText:[Common NSNullConvertEmptyString:[d objectForKey:@"SCOUTCHECK_CONTENT"]]];
        [scroll addSubview:lbl1];
        
        lbl1=[[UILabel alloc]initWithFrame:CGRectMake(160, height, 130, 30)];
        [lbl1 setFont:[UIFont systemFontOfSize:10]];
        [lbl1 setTextColor:[UIColor blackColor]];
        [lbl1 setTextAlignment:NSTextAlignmentRight];
        [lbl1 setText:[Common NSNullConvertEmptyString:[d objectForKey:@"SCOUTCHECK"]]];
        [scroll addSubview:lbl1];
    }
}

@end