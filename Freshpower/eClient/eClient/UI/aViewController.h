//
//  aViewController.h
//  test
//
//  Created by apple on 14-6-9.
//  Copyright (c) 2014年 zhuhuaxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

@interface aViewController : BaseTableViewController
{
    //所有数据的数组
    NSMutableArray*_array;
    //表的数据源数组
    NSMutableArray*_CurrentArray;

}
@end
