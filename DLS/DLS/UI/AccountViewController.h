//
//  AccountViewController.h
//  DLS
//
//  Created by Start on 3/5/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "BaseTableViewController.h"
#import "SinglePickerView.h"

@interface AccountViewController : BaseTableViewController<UIAlertViewDelegate,PickerViewDelegate>

@property SinglePickerView *pv1;

@end
