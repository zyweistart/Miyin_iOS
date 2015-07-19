//
//  BannerCell.m
//  ZMCY
//
//  Created by Start on 15/7/19.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "BannerCell.h"
#import "NewsDetailViewController.h"

@implementation BannerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Data:(NSArray *)data {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSMutableArray *array=[[NSMutableArray alloc]init];
        for(NSDictionary *d in data){
            NSMutableDictionary *md=[NSMutableDictionary dictionaryWithDictionary:d];
            [md setObject:[NSString stringWithFormat:@"%@%@",HTTP_URL,[d objectForKey:@"images"]] forKey:@"images"];
            [array addObject:md];
        }
        [self setUserInteractionEnabled:YES];
        self.bannerView = [[HMBannerView alloc] initWithFrame:CGRectMake1(0, 0, 320, 100) scrollDirection:ScrollDirectionLandscape images:array];
        [self.bannerView setRollingDelayTime:2.0];
        [self.bannerView setDelegate:self];
        [self.bannerView setSquare:0];
        [self.bannerView setPageControlStyle:PageStyle_Left];
//        [self.bannerView showClose:YES];
        [self.bannerView startDownloadImage];
        [self addSubview:self.bannerView];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

#pragma mark HMBannerViewDelegate

- (void)imageCachedDidFinish:(HMBannerView *)bannerView
{
    if (bannerView == self.bannerView){
        if (self.bannerView.superview == nil){
            [self addSubview:self.bannerView];
        }
        [self.bannerView startRolling];
    } else {
        [self addSubview:bannerView];
        [bannerView startRolling];
    }
}

- (void)bannerView:(HMBannerView *)bannerView didSelectImageView:(NSInteger)index withData:(NSDictionary *)bannerData
{
    [self.currentController.navigationController pushViewController:[[NewsDetailViewController alloc]initWithData:bannerData] animated:YES];
}

@end
