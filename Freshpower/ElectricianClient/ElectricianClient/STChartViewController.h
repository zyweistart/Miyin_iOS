//
//  STChartViewController.h
//  ElectricianRun
//
//  Created by Start on 3/18/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STChartViewController : UIViewController <UIWebViewDelegate>

@property (strong,nonatomic) UIWebView *webView;

- (id)initWithIndex:(int)index Type:(int)type;

@end
