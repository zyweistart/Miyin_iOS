//
//  STStudyViewController.h
//  ElectricianRun
//
//  Created by Start on 1/24/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STStudyViewController : UITableViewController <HttpRequestDelegate>

@property (strong,nonatomic) HttpRequest *hRequest;
@end
