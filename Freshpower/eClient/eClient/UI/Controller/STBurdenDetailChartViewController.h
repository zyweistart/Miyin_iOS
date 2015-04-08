//
//  STBurdenDetailChartViewController.h
//  ElectricianClient
//
//  Created by Start on 3/26/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "BaseViewController.h"

@interface STBurdenDetailChartViewController : BaseViewController

- (id)initWithData:(NSDictionary*)data;

@property (strong,nonatomic) UIWebView *webView1;
@property (strong,nonatomic) UIWebView *webView2;

@end
