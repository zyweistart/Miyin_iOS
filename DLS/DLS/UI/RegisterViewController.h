//
//  RegisterViewController.h
//  DLS
//
//  Created by Start on 3/5/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "BaseViewController.h"
#import "SinglePickerView.h"

@interface RegisterViewController : BaseViewController<UITextFieldDelegate,PickerViewDelegate>

@property SinglePickerView *pv1;

@end
