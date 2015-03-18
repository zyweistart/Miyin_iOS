//
//  SettingViewController.h
//  DLS
//
//  Created by Start on 3/10/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "BaseTableViewController.h"
#import "SinglePickerView.h"

@interface SettingViewController : BaseTableViewController<PickerViewDelegate>

@property SinglePickerView *pv;

@end
