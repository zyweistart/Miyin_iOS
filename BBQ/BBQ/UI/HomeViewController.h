//
//  HomeViewController.h
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "BaseTableViewController.h"

enum MODEl_STATE
{
    MODEL_NORMAL = 0,
    MODEL_CONNECTING = 1,
    MODEL_SCAN = 2,
    MODEL_CONECTED = 3,
};

@interface HomeViewController : BaseTableViewController{
    int MODEL;
}

@end
