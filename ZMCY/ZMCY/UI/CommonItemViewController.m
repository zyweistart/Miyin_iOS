//
//  CommonItemViewController.m
//  ZMCY
//
//  Created by Start on 15/7/20.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "CommonItemViewController.h"
#import "BannerCell.h"
#import "AdvertCell.h"
#import "NewsItemCell.h"

@interface CommonItemViewController ()

@end

@implementation CommonItemViewController

- (id)init{
    self=[super init];
    if(self){
        self.isFirstRefresh=YES;
        self.hDownload=[[HttpDownload alloc]initWithDelegate:self];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        NSInteger row=[indexPath row];
        NSDictionary *data=[self.dataItemArray objectAtIndex:row];
        NSString *key=[data objectForKey:@"key"];
        if([@"banner" isEqualToString:key]){
            return CGHeight(100);
        }else if([@"advert" isEqualToString:key]){
            return CGHeight(100);
        }else{
            return CGHeight(80);
        }
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        NSInteger row=[indexPath row];
        NSDictionary *data=[self.dataItemArray objectAtIndex:row];
        NSString *key=[data objectForKey:@"key"];
        if([@"banner" isEqualToString:key]){
            //一般每个页面只会调用一次
            NSArray *d=[data objectForKey:@"Data"];
            BannerCell *cell = [[BannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BannerCell" Data:d];
            [cell setCurrentController:self];
            return cell;
        }else if([@"advert" isEqualToString:key]){
            //广告位
            static NSString *cellIdentifier = @"AdvertCell";
            AdvertCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(!cell) {
                cell = [[AdvertCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            return cell;
        }else{
            //新闻项
            static NSString *cellIdentifier = @"NewsItemCell";
            NewsItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(!cell) {
                cell = [[NewsItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            NSString *url=[data objectForKey:@"images"];
            NSString *imageUrl=[NSString stringWithFormat:@"%@%@",HTTP_URL,url];
            [self.hDownload AsynchronousDownloadWithUrl:imageUrl RequestCode:500 Object:cell.image];
            [cell.lblTitle setText:[data objectForKey:@"title"]];
            [cell.lblContent setText:[data objectForKey:@"content"]];
            return cell;
        }
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

@end
