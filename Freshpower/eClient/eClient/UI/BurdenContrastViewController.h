//
//  BurdenContrastViewController.h
//  eClient
//
//  Created by Start on 4/15/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "BaseViewController.h"

@interface BurdenContrastViewController : BaseViewController<UIActionSheetDelegate,UIWebViewDelegate>

@property (strong,nonatomic) NSString *currentUrl;

@end
