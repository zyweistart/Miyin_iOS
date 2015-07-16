//
//  HttpDownload.h
//  Ume
//
//  Created by Start on 15/7/1.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HttpDownloadDelegate

@optional
- (void)requestFinishedByRequestCode:(NSInteger)reqCode Path:(NSString*)path;

@end

@interface HttpDownload : NSObject

@property (strong,nonatomic) NSObject<HttpDownloadDelegate> *delegate;

- (void)AsynchronousDownloadImageWithUrl:(NSString *)u ShowImageView:(UIImageView*)showImage;
- (void)AsynchronousDownloadWithUrl:(NSString *)urlStr RequestCode:(NSInteger)reqCode;

@end