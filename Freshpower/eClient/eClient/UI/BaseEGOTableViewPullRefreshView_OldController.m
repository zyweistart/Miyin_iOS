//
//  BaseEGOTableViewPullRefreshView_OldController.m
//  eClient
//
//  Created by Start on 4/8/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "BaseEGOTableViewPullRefreshView_OldController.h"

@interface BaseEGOTableViewPullRefreshView_OldController ()

@end

@implementation BaseEGOTableViewPullRefreshView_OldController

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if(self.dataItemArray==nil){
        self.dataItemArray=[[NSMutableArray alloc]init];
    }
    NSDictionary *data=[response resultJSON];
    if(data!=nil){
        NSDictionary *rows=[data objectForKey:@"Rows"];
        int result=[[rows objectForKey:@"result"] intValue];
        if(result==1){
            int totalCount=[[rows objectForKey:@"TotalCount"]intValue];
            if(totalCount==0){
                [[self dataItemArray]removeAllObjects];
                [self.tableView reloadData];
            }else{
                for(NSString *key in data){
                    if(![@"Rows" isEqualToString:key]){
                        NSArray *tmpData=[data objectForKey:key];
                        if([self currentPage]==1){
                            self.dataItemArray=[[NSMutableArray alloc]initWithArray:tmpData];
                        } else {
                            [self.dataItemArray addObjectsFromArray:tmpData];
                        }
                        if([tmpData count]>0){
                            // 刷新表格
                            [self.tableView reloadData];
                        }
                        break;
                    }
                }
            }
        } else {
            //            [Common alert:[rows objectForKey:@"remark"]];
            if([self currentPage]==1){
                [[self dataItemArray]removeAllObjects];
                [self.tableView reloadData];
            }
        }
    }else{
        [Common alert:@"数据解析异常"];
    }
    [self loadDone];
}

@end
