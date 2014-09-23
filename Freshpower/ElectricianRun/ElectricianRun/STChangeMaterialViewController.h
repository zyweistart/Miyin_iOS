//
//  STChangeMaterialViewController.h
//  ElectricianRun
//
//  Created by Start on 2/21/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STChangeMaterialViewController : UIViewController<HttpRequestDelegate>

@property (strong,nonatomic) NSString *serialNo;
@property (strong,nonatomic) HttpRequest *hRequest;

- (id)initWithSerialNo:(NSString*)no;

@end
