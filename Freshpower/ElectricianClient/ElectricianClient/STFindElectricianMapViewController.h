//
//  STFindElectricianMapViewController.h
//  ElectricianClient
//
//  Created by Start on 3/24/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STFindElectricianMapViewController : BaseUIViewController<HttpRequestDelegate>

@property (strong,nonatomic) HttpRequest *hRequest;

@end
