//
//  STIndexViewController.h
//  ElectricianClient
//
//  Created by Start on 3/25/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "BaseUIViewController.h"

@interface STIndexViewController : BaseUIViewController <UIWebViewDelegate,HttpRequestDelegate>

@property (strong,nonatomic) HttpRequest *electricityRequest;
@property (strong,nonatomic) HttpRequest *burdenRequest;
@property (strong,nonatomic) HttpRequest *runOverViewRequest;

@property (strong,nonatomic) NSMutableArray *dataItemArray;

@end