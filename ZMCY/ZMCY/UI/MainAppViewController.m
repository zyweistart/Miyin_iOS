//
//  MainAppViewController.m
//  ZMCY
//
//  Created by Start on 15/7/16.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "MainAppViewController.h"

@interface MainAppViewController ()

@end

@implementation MainAppViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"懂你"];
        self.isFirstRefresh=YES;
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        return CGHeight(205);
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        static NSString *cellIdentifier = @"SAMPLECell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

@end
