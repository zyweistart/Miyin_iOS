//
//  STElectricityDetailViewController.h
//  ElectricianClient
//
//  Created by Start on 3/26/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "BaseUIViewController.h"

@interface STElectricityDetailViewController : BaseUIViewController <HttpRequestDelegate>

- (id)initWithData:(NSDictionary*)data selectType:(int)selectType;

- (void)loadData;

@property (strong,nonatomic) HttpRequest *hRequest;

@end
