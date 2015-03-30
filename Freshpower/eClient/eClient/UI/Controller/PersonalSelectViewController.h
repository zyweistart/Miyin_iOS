//
//  PersonalSelectViewController.h
//  eClient
//
//  Created by Start on 3/30/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "BaseEGOTableViewPullRefreshViewController.h"

@interface PersonalSelectViewController : BaseEGOTableViewPullRefreshViewController

- (id)initWithData:(NSDictionary*)data;

@property id<ResultDelegate> delegate;
@property NSDictionary *data;

@property NSInteger resultCode;

@end
