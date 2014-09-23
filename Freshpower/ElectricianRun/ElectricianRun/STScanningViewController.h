//
//  STScanningViewController.h
//  ElectricianRun
//
//  Created by Start on 1/24/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol ScanningDelegate

@optional
- (void)success:(NSString*)value responseCode:(NSInteger)responseCode;

@end

@interface STScanningViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) UIView *viewPreview;
@property (strong, nonatomic) UILabel *lblStatus;
@property (strong, nonatomic) UIButton *btnOK;
@property NSInteger responseCode;

@property (strong,nonatomic) id<ScanningDelegate> delegate;

@end
