//
//  ConnectViewController.h
//  BBQ
//
//  Created by Start on 15/7/28.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MBProgressHUD.h"

@interface ConnectViewController : BaseTableViewController<TIBLECBStandandDelegate>

@property(strong,nonatomic)NSTimer *mTimer;
@property(strong,nonatomic)MBProgressHUD *mMBProgressHUD;

@end