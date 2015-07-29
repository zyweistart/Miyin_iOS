//
//  ConnectViewController.h
//  BBQ
//
//  Created by Start on 15/7/28.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MBProgressHUD.h"

enum MODEl_STATE
{
    MODEL_NORMAL = 0,//normal
    MODEL_CONNECTING = 1,//连接中
    MODEL_SCAN = 2,//扫描
    MODEL_CONECTED = 3,//连接
};

@interface ConnectViewController : BaseTableViewController {
    int MODEL;
}

@property(strong,nonatomic)MBProgressHUD *mMBProgressHUD;

@end