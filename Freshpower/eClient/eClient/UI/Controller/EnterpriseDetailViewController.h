//
//  EnterpriseDetailViewController.h
//  eClient
//
//  Created by Start on 3/31/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "BaseTableViewController.h"

@interface EnterpriseDetailViewController : BaseTableViewController

@property NSDictionary *data;

- (id)initWithData:(NSDictionary*)data;

@end
