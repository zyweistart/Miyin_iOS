//
//  PublishRentalViewController.h
//  DLS
//
//  Created by Start on 3/12/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "BaseTableViewController.h"
#import "SinglePickerView.h"

@interface PublishRentalViewController : BaseTableViewController<PickerViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property SinglePickerView *pv1,*pv2,*pv3;

- (id)initWithData:(NSDictionary*)data;

@end
