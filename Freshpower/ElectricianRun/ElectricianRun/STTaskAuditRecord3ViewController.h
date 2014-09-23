//
//  STTaskAuditRecord3ViewController.h
//  ElectricianRun
//
//  Created by Start on 2/20/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STTaskAuditRecord3ViewController : UIViewController<HttpRequestDelegate>

- (id)initWithData:(NSDictionary *)data dic:(NSDictionary *)dic type:(NSInteger)t;

@property (strong,nonatomic) HttpRequest *hRequest;

- (void)reloadDataSource;

@end
