//
//  InspectionSettingViewController.h
//  eClient
//
//  Created by weizhenyao on 15/3/23.
//  Copyright (c) 2015年 freshpower. All rights reserved.
//
#import "ResultDelegate.h"

@interface InspectionSettingViewController : BaseViewController<ResultDelegate>

- (id)initWithData:(NSMutableDictionary*)data;

@property id<ResultDelegate> delegate;

@end
