//
//  STAggregatorEntInfoViewController.m
//  ElectricianRun
//  汇集器企业信息
//  Created by Start on 2/21/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STAggregatorEntInfoViewController.h"

@interface STAggregatorEntInfoViewController ()

@end

@implementation STAggregatorEntInfoViewController {
    UILabel *lblV1;
    UILabel *lblV2;
    UILabel *lblV3;
    UILabel *lblV4;
    UILabel *lblV5;
}

- (id)initWithSID:(NSString*)sid {
    self = [super init];
    if (self) {
        self.title=@"企业基本信息";
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.SID=sid;
        
        [self reloadDataSource];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 80, 320, 305)];
    
    UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
    [lbl1 setTextAlignment:NSTextAlignmentRight];
    [lbl1 setFont:[UIFont systemFontOfSize:12.0]];
    [lbl1 setText:@"地址:"];
    [lbl1 setTextColor:[UIColor blackColor]];
    [control addSubview:lbl1];
    
    lblV1=[[UILabel alloc]initWithFrame:CGRectMake(115, 5, 195, 20)];
    [lblV1 setTextAlignment:NSTextAlignmentLeft];
    [lblV1 setFont:[UIFont systemFontOfSize:12.0]];
    [lblV1 setTextColor:[UIColor blackColor]];
    [control addSubview:lblV1];
    
    UILabel *lbl2=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, 100, 20)];
    [lbl2 setTextAlignment:NSTextAlignmentRight];
    [lbl2 setFont:[UIFont systemFontOfSize:12.0]];
    [lbl2 setText:@"配电房共:"];
    [lbl2 setTextColor:[UIColor blackColor]];
    [control addSubview:lbl2];
    
    lblV2=[[UILabel alloc]initWithFrame:CGRectMake(115, 30, 195, 20)];
    [lblV2 setTextAlignment:NSTextAlignmentLeft];
    [lblV2 setFont:[UIFont systemFontOfSize:12.0]];
    [lblV2 setTextColor:[UIColor blackColor]];
    [control addSubview:lblV2];
    
    UILabel *lbl3=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 100, 20)];
    [lbl3 setTextAlignment:NSTextAlignmentRight];
    [lbl3 setFont:[UIFont systemFontOfSize:12.0]];
    [lbl3 setText:@"变压器共:"];
    [lbl3 setTextColor:[UIColor blackColor]];
    [control addSubview:lbl3];
    
    lblV3=[[UILabel alloc]initWithFrame:CGRectMake(115, 55, 195, 20)];
    [lblV3 setTextAlignment:NSTextAlignmentLeft];
    [lblV3 setFont:[UIFont systemFontOfSize:12.0]];
    [lblV3 setTextColor:[UIColor blackColor]];
    [control addSubview:lblV3];
    
    UILabel *lbl4=[[UILabel alloc]initWithFrame:CGRectMake(10, 80, 100, 20)];
    [lbl4 setTextAlignment:NSTextAlignmentRight];
    [lbl4 setFont:[UIFont systemFontOfSize:12.0]];
    [lbl4 setText:@"当前汇集器所在:"];
    [lbl4 setTextColor:[UIColor blackColor]];
    [control addSubview:lbl4];
    
    lblV4=[[UILabel alloc]initWithFrame:CGRectMake(115, 80, 195, 20)];
    [lblV4 setTextAlignment:NSTextAlignmentLeft];
    [lblV4 setFont:[UIFont systemFontOfSize:12.0]];
    [lblV4 setTextColor:[UIColor blackColor]];
    [control addSubview:lblV4];
    
    lblV5=[[UILabel alloc]initWithFrame:CGRectMake(10, 105, 300, 200)];
    [lblV5 setTextAlignment:NSTextAlignmentLeft];
    [lblV5 setFont:[UIFont systemFontOfSize:12.0]];
    [lblV5 setTextColor:[UIColor blackColor]];
    [lblV5 setNumberOfLines:0];
    [control addSubview:lblV5];
    
    [self.view addSubview:control];
}

- (void)reloadDataSource{
    
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[Account getUserName] forKey:@"imei"];
    [p setObject:[Account getPassword] forKey:@"authentication"];
    [p setObject:self.SID forKey:@"SiteId"];
    
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest start:URLAppScanNumber params:p];
    
}


- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode {
    NSMutableArray *dataArray=[[NSMutableArray alloc]initWithArray:[[response resultJSON] objectForKey:@"Rows"]];
    for(NSDictionary *dic in dataArray) {
        [lblV1 setText:[Common NSNullConvertEmptyString:[dic objectForKey:@"ADDRESS"]]];
        [lblV2 setText:[Common NSNullConvertEmptyString:[dic objectForKey:@"SUB_COUNT"]]];
        [lblV3 setText:[Common NSNullConvertEmptyString:[dic objectForKey:@"TRANS_COUNT"]]];
        [lblV4 setText:[Common NSNullConvertEmptyString:[dic objectForKey:@"TRANS_NAME"]]];
        NSString *transform=[Common NSNullConvertEmptyString:[dic objectForKey:@"TRANSFORM_NO"]];
        transform=[transform stringByReplacingOccurrencesOfString:@"；" withString:@";\n"];
        [lblV5 setText:transform];
        break;
    }
    
}

@end
