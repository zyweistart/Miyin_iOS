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

- (void)requestFinishedByRequestCode:(NSInteger)reqCode Path:(NSString*)path Object:(id)sender;

@end

@interface HttpDownload : NSObject

@property (strong,nonatomic) NSObject<HttpDownloadDelegate> *delegate;

- (id)initWithDelegate:(NSObject<HttpDownloadDelegate>*)delegate;

- (void)AsynchronousDownloadWithUrl:(NSString *)url RequestCode:(NSInteger)reqCode Object:(id)sender;

@end