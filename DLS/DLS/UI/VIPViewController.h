//
//  VIPViewController.h
//  DLS
//  VIP
//  Created by Start on 3/2/15.
//  Copyright (c) 2015 Start. All rights reserved.
//
#import "BaseEGOTableViewPullRefreshViewController.h"
#import "SearchView.h"
#import "CategoryView.h"
#import "SinglePickerView.h"

@interface VIPViewController : BaseEGOTableViewPullRefreshViewController<CategoryViewDelegate,PickerViewDelegate>

@property SinglePickerView *pv1,*pv2,*pv3,*pv4;

@end
