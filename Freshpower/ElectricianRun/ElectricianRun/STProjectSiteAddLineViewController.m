//
//  STProjectSiteAddLineViewController.m
//  ElectricianRun
//
//  Created by Start on 2/25/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STProjectSiteAddLineViewController.h"

#define RESPONSECODEDONE 500

@interface STProjectSiteAddLineViewController ()

@end

@implementation STProjectSiteAddLineViewController {
    NSDictionary *_data;
}

- (id)initWithData:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.title=@"添加线路";
        [self.view setBackgroundColor:[UIColor whiteColor]];
        _data=data;
        
        UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 80, 320, 210)];
        [self.view addSubview:control];
        NSString *serial=[_data objectForKey:@"SERIAL_NO"];
        
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 90, 20)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:@"序列号"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [control addSubview:lbl];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(105, 10, 120, 20)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:[serial substringToIndex:12]];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [control addSubview:lbl];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, 90, 20)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:@"配套互感器"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [control addSubview:lbl];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(105, 40, 120, 20)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:[NSString stringWithFormat:@"%@",[_data objectForKey:@"TRANS_TYPE1"]]];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [control addSubview:lbl];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 70, 90, 20)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:@"通道"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [control addSubview:lbl];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(105, 70, 120, 20)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:[serial substringFromIndex:12]];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [control addSubview:lbl];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, 90, 20)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:@"线路名称"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [control addSubview:lbl];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(105, 100, 120, 20)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:[_data objectForKey:@"LINE_NAME"]];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [control addSubview:lbl];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 130, 90, 20)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:@"额定电流"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [control addSubview:lbl];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(105, 130, 120, 20)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:[NSString stringWithFormat:@"%@",[_data objectForKey:@"LINE_CURRENT"]]];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [control addSubview:lbl];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 160, 90, 20)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:@"变比"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [control addSubview:lbl];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(105, 160, 120, 20)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:[NSString stringWithFormat:@"%@",[_data objectForKey:@"RATIO"]]];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [control addSubview:lbl];
        
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"完成"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(done:)];
        
        
    }
    return self;
}

- (void)done:(id)sender {
    
    NSString *serial=[_data objectForKey:@"SERIAL_NO"];
    
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[Account getUserName] forKey:@"imei"];
    [p setObject:[Account getPassword] forKey:@"authentication"];
    [p setObject:@"1" forKey:@"OpWap"];
    [p setObject:[serial substringToIndex:12] forKey:@"SerialNo"];
    [p setObject:[serial substringFromIndex:12] forKey:@"Channel"];
    [p setObject:[_data objectForKey:@"MSITE_ID"] forKey:@"MsiteId"];
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:RESPONSECODEDONE];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest start:URLAppProductInfoBySerial params:p];
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode
{
    if(repCode==RESPONSECODEDONE){
        NSMutableArray *dataArray=[[NSMutableArray alloc]initWithArray:[[response resultJSON] objectForKey:@"Rows"]];
        
        for(NSDictionary *dic in dataArray) {
            int result=[[dic objectForKey:@"result"]intValue];
            if(result>0) {
                [Common alert:@"添加线路成功！"];
                [self.navigationController popViewControllerAnimated:YES];
            } else if(result== -10) {
                [Common alert:@"序列号不能为空！"];
            } else if(result == -9) {
                [Common alert:@"查询未找到该序列号，请联系管理员！"];
            } else if(result == -8) {
                [Common alert:@"该序列号不可使用状态，请联系管理员！"];
            } else if(result == -5) {
                [Common alert:@"选择正确的线路进入添加！"];
            } else if(result  == -4) {
                [Common alert:@"该线路已经存在，无需添加！"];
            } else if(result == -2) {
                [Common alert:@"该序列号不可操作！"];
            } else if(result == 0) {
                [Common alert:@"不合法操作（该用户不存在）！"];
            }
            break;
        }
        
    }
}

@end
