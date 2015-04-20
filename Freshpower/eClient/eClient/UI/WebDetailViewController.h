//
//  WebDetailViewController.h
//  eClient
//
//  Created by Start on 4/16/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "BaseViewController.h"

@interface WebDetailViewController : BaseViewController<UIWebViewDelegate>


- (id)initWithType:(int)type Url:(NSString*)url;

@property UIWebView *webView1;

@end
