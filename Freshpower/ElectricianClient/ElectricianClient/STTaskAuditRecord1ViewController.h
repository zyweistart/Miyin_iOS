//
//  STTaskAuditRecord1ViewController.h
//  ElectricianRun
//
//  Created by Start on 2/20/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

@interface STTaskAuditRecord1ViewController : BaseTableViewController

@property (strong,nonatomic) NSDictionary *data;

- (id)initWithData:(NSDictionary *)data;

@end
