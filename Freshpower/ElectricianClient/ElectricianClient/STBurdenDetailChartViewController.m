//
//  STBurdenDetailChartViewController.m
//  ElectricianClient
//
//  Created by Start on 3/26/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STBurdenDetailChartViewController.h"
#import "DataPickerView.h"

@interface STBurdenDetailChartViewController () <DataPickerViewDelegate,UIWebViewDelegate>

@end

@implementation STBurdenDetailChartViewController{
    NSDictionary *_data;
    DataPickerView *searchTypedpv;
    NSArray *searchType;
    UITextField *txtSearch;
    int searchTypeValue;
    UILabel *lbl1;
    UILabel *lbl2;
    UILabel *lbl3;
    UILabel *lbl4;
}

- (id)initWithData:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        _data=data;
        self.title=[_data objectForKey:@"METER_NAME"];
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"搜索"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(search:)];
        
        self.webView1 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 250)];
        [self.webView1 setUserInteractionEnabled:YES];
        [self.webView1 setScalesPageToFit:YES];
        [self.webView1 setBackgroundColor:[UIColor clearColor]];
        [self.webView1 setOpaque:NO];//使网页透明
        [self.webView1 setDelegate:self];
        [self.view addSubview:self.webView1];
        
        self.webView2 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 250)];
        [self.webView2 setUserInteractionEnabled:YES];
        [self.webView2 setScalesPageToFit:YES];
        [self.webView2 setBackgroundColor:[UIColor clearColor]];
        [self.webView2 setOpaque:NO];//使网页透明
        [self.webView2 setDelegate:self];
        [self.webView2 setHidden:YES];
        [self.view addSubview:self.webView2];
        
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ichartjs.bundle/ChartIndexBurdenLine.html"];
        [self.webView1 loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path]]];
        
        path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ichartjs.bundle/ChartIndexBurdenLine2.html"];
        [self.webView2 loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path]]];
        
        [self performSelector:@selector(loadData) withObject:nil afterDelay:1];
        
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 280, 150, 20)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:@"当前负荷:"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [self.view addSubview:lbl];
        
        lbl1=[[UILabel alloc]initWithFrame:CGRectMake(170, 280, 150, 20)];
        lbl1.font=[UIFont systemFontOfSize:12.0];
        [lbl1 setTextColor:[UIColor blackColor]];
        [lbl1 setBackgroundColor:[UIColor clearColor]];
        [lbl1 setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:lbl1];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 300, 150, 20)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:@"最高负荷:"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [self.view addSubview:lbl];
        
        lbl2=[[UILabel alloc]initWithFrame:CGRectMake(170, 300, 150, 20)];
        lbl2.font=[UIFont systemFontOfSize:12.0];
        [lbl2 setTextColor:[UIColor blackColor]];
        [lbl2 setBackgroundColor:[UIColor clearColor]];
        [lbl2 setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:lbl2];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 320, 150, 20)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:@"最高负荷出现时间:"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [self.view addSubview:lbl];
        
        lbl3=[[UILabel alloc]initWithFrame:CGRectMake(170, 320, 150, 20)];
        lbl3.font=[UIFont systemFontOfSize:12.0];
        [lbl3 setTextColor:[UIColor blackColor]];
        [lbl3 setBackgroundColor:[UIColor clearColor]];
        [lbl3 setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:lbl3];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 340, 150, 20)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:@"负荷率:"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [self.view addSubview:lbl];
        
        lbl4=[[UILabel alloc]initWithFrame:CGRectMake(170, 340, 150, 20)];
        lbl4.font=[UIFont systemFontOfSize:12.0];
        [lbl4 setTextColor:[UIColor blackColor]];
        [lbl4 setBackgroundColor:[UIColor clearColor]];
        [lbl4 setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:lbl4];
        
        
    }
    return self;
}

- (void)search:(id)sender
{
    searchTypeValue=0;
    searchType=[[NSArray alloc]initWithObjects:
                @"按时查询",@"按日查询", nil];
    searchTypedpv=[[DataPickerView alloc]initWithData:searchType];
    [searchTypedpv setDelegate:self];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"负荷曲线历史查询"
                          message:@""
                          delegate:self
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:@"确定",nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    txtSearch=[alert textFieldAtIndex:0];
    [txtSearch setInputView:searchTypedpv];
    [txtSearch setText:[searchType objectAtIndex:searchTypeValue]];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1){
        [self loadData];
    }
}

- (void)pickerDidPressDoneWithRow:(NSInteger)row {
    if([txtSearch isFirstResponder]){
        searchTypeValue=row;
        [txtSearch setText:[searchType objectAtIndex:searchTypeValue]];
        [txtSearch resignFirstResponder];
    }
}

- (void)pickerDidPressCancel{
    if([txtSearch isFirstResponder]){
        [txtSearch resignFirstResponder];
    }
}

- (void)loadData{
    
    if(searchTypeValue==0){
        [self.webView1 setHidden:NO];
        [self.webView2 setHidden:YES];
    }else{
        [self.webView1 setHidden:YES];
        [self.webView2 setHidden:NO];
    }
    
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[[Account getResultData]objectForKey:@"CP_ID"] forKey:@"CP_ID"];
    [p setObject:[NSString stringWithFormat:@"%@",[_data objectForKey:@"METER_ID"]] forKey:@"MeterID"];
    [p setObject:[NSString stringWithFormat:@"%@",searchTypeValue==0?@"Hour":@"Day"] forKey:@"SelectType"];
    if(searchTypeValue==1){
        NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *startDate=[NSDate date];
        NSString *startDateStr = [dateFormatter stringFromDate:startDate];
        NSDate *endDate = [startDate dateByAddingTimeInterval:-86400*30];
        NSString *endDateStr1 = [dateFormatter stringFromDate:endDate];
        startDate=[dateFormatter dateFromString:startDateStr];
        NSString *endDateStr2=[dateFormatter stringFromDate:[startDate dateByAddingTimeInterval:-86400*1]];
        [p setObject:endDateStr1 forKey:@"sDate"];
        [p setObject:endDateStr2 forKey:@"eDate"];
    }
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest start:URLAppMeterHisFhReport params:p];
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode{
    NSDictionary *data=[response resultJSON];
    NSMutableArray *v=[[NSMutableArray alloc]init];
    if(data!=nil){
        NSDictionary *rows=[data objectForKey:@"Rows"];
        int result=[[rows objectForKey:@"result"] intValue];
        if(result==1){
            NSDictionary *factorData=[data objectForKey:@"MeterFactor"];
            NSString *currLoad=[Common NSNullConvertEmptyString:[rows objectForKey:@"CurrLoad"]];
            if([@"" isEqualToString:currLoad]){
                [lbl1 setText:@""];
            }else{
                [lbl1 setText:[NSString stringWithFormat:@"%@kW",currLoad]];
            }
            NSString *maxLoad=[Common NSNullConvertEmptyString:[factorData objectForKey:@"MaxLoad"]];
            if([@"" isEqualToString:maxLoad]){
                [lbl2 setText:@""];
            }else{
                [lbl2 setText:[NSString stringWithFormat:@"%@kW",maxLoad]];
            }
            [lbl3 setText:[NSString stringWithFormat:@"%@",[Common NSNullConvertEmptyString:[factorData objectForKey:@"MaxTime"]]]];
            [lbl4 setText:[NSString stringWithFormat:@"%@",[Common NSNullConvertEmptyString:[factorData objectForKey:@"FHL"]]]];
            NSMutableArray *tmpData=[data objectForKey:@"MeterFhList"];
            if(tmpData){
                for(int i=0;i<[tmpData count];i++){
                    NSDictionary *d=[tmpData objectAtIndex:i];
                    float value=[[Common NSNullConvertEmptyString:[d objectForKey:@"负荷"]]floatValue];
                    if([tmpData count]-1==i&&value<=0){
                        break;
                    }
                    [v addObject:[[NSNumber alloc]initWithFloat:value]];
                }
            }
        }else{
            [Common alert:[rows objectForKey:@"remark"]];
        }
    }else{
        [Common alert:@"数据解析异常"];
    }
    NSMutableDictionary *d1=[[NSMutableDictionary alloc]init];
    [d1 setValue:v forKey:@"value"];
    [d1 setValue:@"当前负荷" forKey:@"name"];
    [d1 setValue:@"#1f7e92" forKey:@"color"];
    [d1 setValue:[[NSNumber alloc]initWithFloat:3] forKey:@"line_width"];
    NSMutableArray *jsondata=[[NSMutableArray alloc]init];
    [jsondata addObject:d1];
    
    NSString *jsonString = [[NSString alloc] initWithData:[Common toJSONData:jsondata] encoding:NSUTF8StringEncoding];
    
    if(searchTypeValue==0){
        [self.webView1 stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"refresh(%@);",jsonString]];
    }else{
        [self.webView2 stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"refresh(%@);",jsonString]];
    }
}

@end
