//
//  STTaskAuditMapViewController.m
//  ElectricianRun
//  任务稽核-工作人员位置
//  Created by Start on 1/25/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STTaskAuditMapViewController.h"
#import "STViewUserListViewController.h"
#import <MapKit/MapKit.h>
#import "CustomAnnotation.h"
#import "STGPSSearchViewController.h"

#define ZOOMLEVEL 0.02

//按轨迹
#define REQUESTCODELOCUS 3
//按位置
#define REQUESTCODELOCATION 4

#define REQUESTCODEMONTHDAY 47382197

@interface STTaskAuditMapViewController () <MKMapViewDelegate,HttpRequestDelegate>

@end

@implementation STTaskAuditMapViewController {
    
    HttpRequest *hRequest;
    MKMapView *_mapView;
    CLLocationManager *_locationManager;
    NSMutableArray *overlays;
    NSMutableArray *timeQuantum;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"工作人员位置";
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.navigationItem.rightBarButtonItems=[[NSArray alloc]initWithObjects:
                                                 [[UIBarButtonItem alloc]
                                                  initWithTitle:@"用户"
                                                  style:UIBarButtonItemStyleBordered
                                                  target:self
                                                  action:@selector(viewuser:)],
                                                 [[UIBarButtonItem alloc]
                                                  initWithTitle:@"搜索"
                                                  style:UIBarButtonItemStyleBordered
                                                  target:self
                                                  action:@selector(search:)], nil];
        overlays=[[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    _mapView=[[MKMapView alloc]initWithFrame:[self.view bounds]];
    [_mapView setDelegate:self];
    [_mapView setMapType:MKMapTypeStandard];
//    [_mapView setShowsUserLocation:YES];
    [_mapView setScrollEnabled:YES];
    [_mapView setZoomEnabled:YES];
    [self.view addSubview:_mapView];
  
    //显示默认的位置
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(30.287786360161632,
                                                               120.15082687139511);
	MKCoordinateRegion region = MKCoordinateRegionMake(coords,MKCoordinateSpanMake(ZOOMLEVEL, ZOOMLEVEL));
	[_mapView setRegion:[_mapView regionThatFits:region] animated:YES];
    
    [super viewDidLoad];
}

- (void)search:(id)sender
{
    STGPSSearchViewController *gpsSearchViewController=[[STGPSSearchViewController alloc]init];
    [gpsSearchViewController setDelegate:self];
    [gpsSearchViewController buildUIQuantum:timeQuantum];
    [self.navigationController pushViewController:gpsSearchViewController animated:YES];
}

- (void)viewuser:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc]
                            initWithTitle:@""
                            delegate:self
                            cancelButtonTitle:@"取消"
                            destructiveButtonTitle:nil
                            otherButtonTitles:@"按日",@"按月",nil];
    sheet.tag=1;
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolylineView *lineview=[[MKPolylineView alloc] initWithOverlay:overlay];
        lineview.strokeColor=[[UIColor blueColor] colorWithAlphaComponent:0.5];
        lineview.lineWidth=3.0;
        return lineview;
    }
    return nil;
}

- (void)startSearch:(NSMutableDictionary *)data responseCode:(int)repCode
{
    //清除地图上的标记
    [_mapView removeAnnotations:[_mapView annotations]];
    //清除地点上的线路
    [_mapView removeOverlays:overlays];
    [overlays removeAllObjects];
    
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[Account getUserName] forKey:@"imei"];
    [p setObject:[Account getPassword] forKey:@"authentication"];
    if(repCode==120){
        //位置
        [p setObject:[data objectForKey:@"phoneNum"] forKey:@"phoneNum"];
        hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:REQUESTCODELOCATION];
    }else if(repCode==150){
        //轨迹
        [p setObject:[data objectForKey:@"phoneNum"] forKey:@"phoneNum"];
        [p setObject:[data objectForKey:@"startDate"] forKey:@"startDate"];
        [p setObject:[data objectForKey:@"endDate"] forKey:@"endDate"];
        hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:REQUESTCODELOCUS];
    }else if(repCode==180){
        [p setObject:[data objectForKey:@"userId"] forKey:@"userId"];
        [p setObject:[data objectForKey:@"UUID"] forKey:@"UUID"];
        [p setObject:[data objectForKey:@"rtype"] forKey:@"rtype"];
        NSString *rvalue=[data objectForKey:@"rvalue"];
        if(rvalue){
            //有记录的轨迹查询
            [p setObject:rvalue forKey:@"rvalue"];
        }else{
            [p setObject:[data objectForKey:@"startDate"] forKey:@"startDate"];
            [p setObject:[data objectForKey:@"endDate"] forKey:@"endDate"];
        }
        hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:REQUESTCODELOCUS];
    }else if(repCode==200){
        self.searchData=data;
        //通过按月日搜索返回的结果
        [p setObject:[data objectForKey:@"phoneNum"] forKey:@"phoneNum"];
        [p setObject:[data objectForKey:@"UUID"] forKey:@"UUid"];
        [p setObject:[data objectForKey:@"userId"] forKey:@"userId"];
        [p setObject:[data objectForKey:@"startDate"] forKey:@"startDate"];
        [p setObject:[data objectForKey:@"endDate"] forKey:@"endDate"];
        [p setObject:[data objectForKey:@"rtype"] forKey:@"rtype"];
        hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:REQUESTCODEMONTHDAY];
    }
    [hRequest setIsShowMessage:YES];
    [hRequest start:URLgetLocationInfo params:p];
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode{
    NSDictionary *json=[response resultJSON];
    if([@"1" isEqualToString:[json objectForKey:@"result"]]){
        //按日按月或按轨迹
        NSMutableArray *data=[json objectForKey:@"gpsDataInfoList"];
        NSString *name=[json objectForKey:@"userName"];
        int length=[data count];
        if(repCode==REQUESTCODEMONTHDAY){
            timeQuantum=[json objectForKey:@"timeQuantum"];
        }
        //声明一个数组  用来存放画线的点
        MKMapPoint coords[length];
        for(int i=0;i<length;i++){
            NSDictionary *d=[data objectAtIndex:i];
            double latitude=[[d objectForKey:@"latitude"]doubleValue];
            double longitude=[[d objectForKey:@"longitude"]doubleValue];
            coords[i]=MKMapPointForCoordinate(CLLocationCoordinate2DMake(latitude, longitude));
        }
        MKPolyline *line = [MKPolyline polylineWithPoints:coords count:length];
        [overlays addObject:line];
        [_mapView addOverlay:line];
        //开始的位置点
        if(length>0){
            NSDictionary *d=[data objectAtIndex:0];
            double latitude=[[d objectForKey:@"latitude"]doubleValue];
            double longitude=[[d objectForKey:@"longitude"]doubleValue];
            
            CLLocationCoordinate2D cll = CLLocationCoordinate2DMake(latitude,longitude);
            MKCoordinateRegion region = MKCoordinateRegionMake(cll, MKCoordinateSpanMake(ZOOMLEVEL, ZOOMLEVEL));
            [_mapView setRegion:[_mapView regionThatFits:region] animated:YES];
            
            CustomAnnotation *annotation = [[CustomAnnotation alloc] initWithCoordinate:cll];
            annotation.title = name;
            annotation.subtitle = [NSString stringWithFormat:@"开始:%@",[d objectForKey:@"gpsTime"]];
            
            [_mapView addAnnotation:annotation];
        }
        //结束的位置点
        if(length>1){
            NSDictionary *d=[data objectAtIndex:length-1];
            double latitude=[[d objectForKey:@"latitude"]doubleValue];
            double longitude=[[d objectForKey:@"longitude"]doubleValue];
            
            CLLocationCoordinate2D cll = CLLocationCoordinate2DMake(latitude,longitude);
            MKCoordinateRegion region = MKCoordinateRegionMake(cll, MKCoordinateSpanMake(ZOOMLEVEL, ZOOMLEVEL));
            [_mapView setRegion:[_mapView regionThatFits:region] animated:YES];
            
            CustomAnnotation *annotation = [[CustomAnnotation alloc] initWithCoordinate:cll];
            annotation.title = name;
            annotation.subtitle = [NSString stringWithFormat:@"结束:%@",[d objectForKey:@"gpsTime"]];
            
            [_mapView addAnnotation:annotation];
        }
    }else{
        [Common alert:@"查询失败"];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag==1){
        if(buttonIndex==0){
            //按日
            STViewUserListViewController *viewUserListViewController=[[STViewUserListViewController alloc]initWithTimeType:1];
            [viewUserListViewController setDelegate:self];
            [self.navigationController pushViewController:viewUserListViewController animated:YES];
            [viewUserListViewController autoRefresh];
        }else if(buttonIndex==1){
            //按月
            STViewUserListViewController *viewUserListViewController=[[STViewUserListViewController alloc]initWithTimeType:2];
            [viewUserListViewController setDelegate:self];
            [self.navigationController pushViewController:viewUserListViewController animated:YES];
            [viewUserListViewController autoRefresh];
        }
    }
}

@end