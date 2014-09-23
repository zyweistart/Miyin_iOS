//
//  STFindElectricianMapViewController.m
//  ElectricianClient
//
//  Created by Start on 3/24/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STFindElectricianMapViewController.h"
#import <MapKit/MapKit.h>
#import "CustomAnnotation.h"

#define ZOOMLEVEL 0.4

@interface STFindElectricianMapViewController () <MKMapViewDelegate>

@end

@implementation STFindElectricianMapViewController {
    
    MKMapView *_mapView;
    NSMutableArray *datas;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title=@"找电工";
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                target:self
                                                action:@selector(loadData)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _mapView=[[MKMapView alloc]initWithFrame:[self.view bounds]];
    [_mapView setDelegate:self];
    [_mapView setMapType:MKMapTypeStandard];
//    [_mapView setShowsUserLocation:YES];
    [_mapView setScrollEnabled:YES];
    [_mapView setZoomEnabled:YES];
    [self.view addSubview:_mapView];
    
    //显示默认的位置
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(29.997461006205593,120.6018155523682);
	MKCoordinateRegion region = MKCoordinateRegionMake(coords,MKCoordinateSpanMake(ZOOMLEVEL, ZOOMLEVEL));
	[_mapView setRegion:[_mapView regionThatFits:region] animated:YES];
    
    [self loadData];
}

- (void)loadData
{
    //清除地图上的标记
    [_mapView removeAnnotations:[_mapView annotations]];
    datas=[[NSMutableArray alloc]init];
    if([Account isLogin]){
        NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
        [p setObject:[Account getUserName] forKey:@"imei"];
        [p setObject:[Account getPassword] forKey:@"authentication"];
        [p setObject:[[Account getResultData]objectForKey:@"CP_ID"] forKey:@"CP_ID"];
        self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
        [self.hRequest setIsShowMessage:YES];
        [self.hRequest start:URLAppFoundE params:p];
    }else{
        double latitude[9]={29.997461006205593,29.990250398850474,29.936414481847535,29.942513384159106,29.987425482052284,29.985715624943672,30.168762870400922,29.948760652467562,29.968950031785944};
        double longitude[9]={120.6018155523682,120.54001745666507,120.57194647277835,120.57537970031741,120.657433838501,120.58688101257327,120.65537390197757,120.44440206970218,120.5882543035889};
        for(int i=0;i<9;i++){
            CustomAnnotation *annotation1 = [[CustomAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitude[i],longitude[i])];
            annotation1.title = @"新能量e电工";
            annotation1.subtitle = @"点击联系此电工";
            [annotation1 setIndex:-1];
            [_mapView addAnnotation:annotation1];
        }
    }
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode{
    NSDictionary *data=[response resultJSON];
    if(data!=nil){
        NSDictionary *rows=[data objectForKey:@"Rows"];
        int result=[[rows objectForKey:@"result"] intValue];
        if(result==1){
            NSMutableArray *tmpData=[data objectForKey:@"FoundE"];
            if(tmpData){
                [datas addObjectsFromArray:tmpData];
                for(int i=0;i<[tmpData count];i++){
                    NSDictionary *d=[tmpData objectAtIndex:i];
                    CustomAnnotation *annotation1 = [[CustomAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake([[Common NSNullConvertEmptyString:[d objectForKey:@"LATITUDE"]] doubleValue],[[Common NSNullConvertEmptyString:[d objectForKey:@"LONGITUDE"]] doubleValue])];
                    annotation1.title = [Common NSNullConvertEmptyString:[d objectForKey:@"USER_NAME"]];
                    annotation1.subtitle = [NSString stringWithFormat:@"手机号码:%@",[Common NSNullConvertEmptyString:[d objectForKey:@"MB"]]];
                    [annotation1 setIndex:i];
                    [_mapView addAnnotation:annotation1];
                }
            }else{
                [Common alert:@"查询无数据"];
            }
        }else{
            [Common alert:[rows objectForKey:@"remark"]];
        }
    }else{
        [Common alert:@"数据解析异常"];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id )annotation {
    MKAnnotationView* annotationView = nil;
    CustomAnnotation *myAnnotation = (CustomAnnotation*) annotation;
    static NSString* identifier = @"Pin";
    MKPinAnnotationView* annView = (MKPinAnnotationView*)[_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if(nil == annView) {
        annView = [[MKPinAnnotationView alloc] initWithAnnotation:myAnnotation reuseIdentifier:identifier];
    }
    [annView setImage:[UIImage imageNamed:@"map_mark"]];
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20,20)];
    [btn setImage:[UIImage imageNamed:@"call"] forState:UIControlStateNormal];
    annView.rightCalloutAccessoryView=btn;
    [[annView rightCalloutAccessoryView] setTag:[myAnnotation index]];
    [[annView rightCalloutAccessoryView] addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickDial:)]];
    annotationView = annView;
    [annotationView setEnabled:YES];
    [annotationView setCanShowCallout:YES];
    return annotationView;
}

- (void)onClickDial:(UITapGestureRecognizer *)sender
{
    int tag=[sender.view tag];
    if(tag==-1){
        //拨打新能量客服电话
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"tel://%@",CUSTOMERSERVICETEL]]];
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"tel://%@",[[datas objectAtIndex:tag] objectForKey:@"MB"]]]];
    }
}

@end