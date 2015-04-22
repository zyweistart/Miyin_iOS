//
//  BurdenContrastViewController.m
//  eClient
//
//  Created by Start on 4/15/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "BurdenContrastViewController.h"
#import "ElecLoadDetailViewController.h"
#import "WebDetailViewController.h"
#import "SVButton.h"
#define TITLECOLOR [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1]

@interface BurdenContrastViewController ()

@end

@implementation BurdenContrastViewController{
    UIButton *bSwitchType;
    int type;
    UIView *noDataView,*lineView;
    UIWebView *webView1;
}

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"企业负荷"];
        UIImageView *headView=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
        [headView setImage:[UIImage imageNamed:@"burdenbanner"]];
        [headView setUserInteractionEnabled:YES];
        [headView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToUrl:)]];
        UIView *mainFrame=[[UIView alloc]initWithFrame:self.view.bounds];
        [mainFrame setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:mainFrame];
        [mainFrame addSubview:headView];
        //查询
        bSwitchType=[[UIButton alloc]initWithFrame:CGRectMake1(5, 45, 80, 30)];
        [bSwitchType setTitle:@"按日查询" forState:UIControlStateNormal];
        [bSwitchType.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [bSwitchType setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bSwitchType addTarget:self action:@selector(switchType:) forControlEvents:UIControlEventTouchUpInside];
        [mainFrame addSubview:bSwitchType];
        
        SVButton *btn=[[SVButton alloc]initWithFrame:CGRectMake1(215, 45, 100, 30) Title:@"详细负荷" Type:3];
        [btn addTarget:self action:@selector(goDetailBurden:) forControlEvents:UIControlEventTouchUpInside];
        [mainFrame addSubview:btn];
        
        noDataView=[[UIView alloc]initWithFrame:CGRectMake1(0, 80, 320, 300)];
        [mainFrame addSubview:noDataView];
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(135, 90, 50, 50)];
        [image setImage:[UIImage imageNamed:@"warning"]];
        [noDataView addSubview:image];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(80, 150, 150, 30)];
        [lbl setText:@"变电站运行监测服务"];
        [lbl setTextColor:TITLECOLOR];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [noDataView addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(80, 180, 150, 30)];
        [lbl setText:@"请及时录入"];
        [lbl setTextColor:TITLECOLOR];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [noDataView addSubview:lbl];
        UIButton *bGo=[[UIButton alloc]initWithFrame:CGRectMake1(90, 210, 150, 30)];
        [bGo setTitle:@"了解详情>>" forState:UIControlStateNormal];
        [bGo addTarget:self action:@selector(goToUrl:) forControlEvents:UIControlEventTouchUpInside];
        [bGo.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [bGo setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [noDataView addSubview:bGo];
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake1(0, 80, 320, 300)];
        [mainFrame addSubview:lineView];
        webView1 = [[UIWebView alloc] initWithFrame:lineView.bounds];
        [webView1 setUserInteractionEnabled:YES];
        [webView1 setScalesPageToFit:YES];
        [webView1 setBackgroundColor:[UIColor clearColor]];
        [webView1 setOpaque:NO];//使网页透明
        [webView1 setDelegate:self];
        [lineView addSubview:webView1];
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ichartjs.bundle/ChartIndexBurdenLine.html"];
        [webView1 loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path]]];
        
        [lineView setHidden:YES];
        type=1;
    }
    return self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self loadHttp];
}

- (void)goDetailBurden:(id)sender
{
    [self.navigationController pushViewController:[[ElecLoadDetailViewController alloc]init] animated:YES];
}

- (void)switchType:(UIButton*)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"查询"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"按日查询",@"按周查询", @"按月查询",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
        //按日
        [bSwitchType setTitle:@"按日查询" forState:UIControlStateNormal];
        type=1;
        [self loadHttp];
    }else if(buttonIndex==1){
        //按周
        [bSwitchType setTitle:@"按周查询" forState:UIControlStateNormal];
        type=2;
        [self loadHttp];
    }else if(buttonIndex==2){
        //按月
        [bSwitchType setTitle:@"按月查询" forState:UIControlStateNormal];
        type=3;
        [self loadHttp];
    }
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:[[User Instance]getPassword] forKey:@"authentication"];
    [params setObject:[[[User Instance]getResultData]objectForKey:@"CP_ID"] forKey:@"QTCP"];
    [params setObject:@"010401" forKey:@"GNID"];
    [params setObject:[NSString stringWithFormat:@"%d",type] forKey:@"QTKEY"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:URL_appTaskingPower requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        NSArray *table1=[[response resultJSON]objectForKey:@"table1"];
        if(table1){
            NSMutableArray *v=[[NSMutableArray alloc]init];
            for(int i=0;i<[table1 count];i++){
                NSDictionary *d=[table1 objectAtIndex:i];
                float value=[[Common NSNullConvertEmptyString:[d objectForKey:@"AVG_LOAD"]]floatValue];
                if([table1 count]-1==i&&value<=0){
                    break;
                }
                [v addObject:[[NSNumber alloc]initWithFloat:value]];
            }
            NSMutableDictionary *d1=[[NSMutableDictionary alloc]init];
            [d1 setValue:v forKey:@"value"];
            [d1 setValue:@"当前负荷" forKey:@"name"];
            [d1 setValue:@"#1f7e92" forKey:@"color"];
            [d1 setValue:[[NSNumber alloc]initWithFloat:3] forKey:@"line_width"];
            NSMutableArray *jsondata=[[NSMutableArray alloc]init];
            [jsondata addObject:d1];
            NSString *jsonString = [[NSString alloc] initWithData:[Common toJSONData:jsondata] encoding:NSUTF8StringEncoding];
            [webView1 stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"refresh(%@);",jsonString]];
        }
        [lineView setHidden:NO];
        [noDataView setHidden:YES];
    }else{
        [lineView setHidden:YES];
        [noDataView setHidden:NO];
    }
}

- (void)goToUrl:(id)sender
{
    [self.navigationController pushViewController:[[WebDetailViewController alloc]initWithType:1 Url:self.currentUrl] animated:YES];
}

@end
