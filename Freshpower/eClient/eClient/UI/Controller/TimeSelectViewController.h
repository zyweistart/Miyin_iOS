//
//  TimeSelectViewController.h
//  eClient
//
//  Created by Start on 3/25/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "BaseTableViewController.h"

@interface TimeSelectViewController : BaseTableViewController
{
    NSMutableArray *selectedMarks;
}

@property id<ResultDelegate> delegate;

@property NSInteger resultCode;

@end