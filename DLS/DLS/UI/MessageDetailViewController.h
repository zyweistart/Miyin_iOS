//
//  MessageDetailViewController.h
//  DLS
//
//  Created by Start on 3/9/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "BaseViewController.h"

@interface MessageDetailViewController : BaseViewController

@property NSDictionary *data;

- (id)initWithDictionary:(NSDictionary*)data;

@end
