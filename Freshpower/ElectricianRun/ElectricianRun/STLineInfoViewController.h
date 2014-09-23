//
//  STLineInfoViewController.h
//  ElectricianRun
//
//  Created by Start on 2/21/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STLineInfoViewController : UIViewController<HttpRequestDelegate>

@property (strong,nonatomic) NSString *serialNo;
@property (strong,nonatomic) NSString *channelNo;
@property (strong,nonatomic) HttpRequest *hRequest;

- (id)initWithSerialNo:(NSString*)sno channelNo:(NSString*)cno;

@end