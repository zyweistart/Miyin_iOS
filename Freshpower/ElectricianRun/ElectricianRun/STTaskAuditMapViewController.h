//
//  STTaskAuditMapViewController.h
//  ElectricianRun
//
//  Created by Start on 1/25/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchDelegate.h"

@interface STTaskAuditMapViewController : UIViewController<UIActionSheetDelegate,SearchDelegate>

@property (strong,nonatomic) NSMutableDictionary *searchData;

@end
