//
//  ElecLoadDetailChartViewController.h
//  eClient
//
//  Created by Start on 4/16/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "BaseViewController.h"

@interface ElecLoadDetailChartViewController : BaseViewController<UIWebViewDelegate>

- (id)initWithData:(NSDictionary*)data;

@property (strong,nonatomic) UIWebView *webView1;

@end
