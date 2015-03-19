//
//  PublishQiuzuViewController.h
//  DLS
//
//  Created by Start on 3/12/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "BaseTableViewController.h"
#import "SinglePickerView.h"

@interface PublishQiuzuViewController : BaseTableViewController<PickerViewDelegate,UITextFieldDelegate,UITextViewDelegate>

@property SinglePickerView *pv1,*pv2;

@end
