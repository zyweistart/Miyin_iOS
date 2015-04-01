//
//  EnterpriseManagerViewController.h
//  eClient
//
//  Created by Start on 3/31/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "BaseTableViewController.h"

@interface EnterpriseManagerViewController : BaseTableViewController<UIAlertViewDelegate,UIActionSheetDelegate,UITextFieldDelegate>

@property NSMutableArray *companyArray;
@property NSMutableArray *heightArray;
@property NSMutableArray *lowArray;

- (id)initWithCompanyArray:(NSMutableArray*)array;

- (void)addLine:(NSDictionary*)data;

@end