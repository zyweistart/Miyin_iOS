//
//  STDataMonitoringLineDetailSearchViewController.h
//  ElectricianRun
//
//  Created by Start on 2/22/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerView.h"

@interface STDataMonitoringLineDetailSearchViewController : UIViewController<DatePickerViewDelegate,UITextFieldDelegate>

- (id)initWithData:(NSDictionary *)data;

@property (strong,nonatomic) NSDictionary *data;

@end