//
//  STElectricityDetailViewController.h
//  ElectricianClient
//
//  Created by Start on 3/26/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "BaseViewController.h"

@interface STElectricityDetailViewController : BaseViewController

- (id)initWithData:(NSDictionary*)data selectType:(int)selectType;

- (void)loadData;

@end
