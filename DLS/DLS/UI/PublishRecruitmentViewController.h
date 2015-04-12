//
//  PublishRecruitmentViewController.h
//  DLS
//
//  Created by Start on 3/12/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "BaseViewController.h"
#import "SinglePickerView.h"

@interface PublishRecruitmentViewController : BaseViewController<PickerViewDelegate,UITextFieldDelegate,UITextViewDelegate>

@property SinglePickerView *pv2,*pv4,*pv5,*pv6;

@end
