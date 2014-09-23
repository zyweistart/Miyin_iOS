//
//  STCommentViewController.h
//  ElectricianClient
//
//  Created by Start on 4/1/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "BaseUIViewController.h"
#import "TQStarRatingView.h"

@interface STCommentViewController : BaseUIViewController<HttpRequestDelegate,StarRatingViewDelegate>

@property (strong,nonatomic) HttpRequest *hRequest;

@end
