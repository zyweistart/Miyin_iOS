//
//  PublishQZViewController.h
//  DLS
//
//  Created by Start on 5/18/15.
//  Copyright (c) 2015 Start. All rights reserved.
//
#import "BaseViewController.h"
#import "SinglePickerView.h"

@interface PublishQZViewController : BaseViewController<PickerViewDelegate,UITextFieldDelegate,UITextViewDelegate>

@property SinglePickerView *pv1,*pv2;

@end
