//
//  CollectionDetailViewController.h
//  DLS
//
//  Created by Start on 15/6/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "BaseViewController.h"

@interface CollectionDetailViewController : BaseViewController

@property NSDictionary *data;

- (id)initWithDictionary:(NSDictionary*)data;

@end
