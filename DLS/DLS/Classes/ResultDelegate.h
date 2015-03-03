//
//  ACResultDelegate.h
//  ACyulu
//
//  Created by Start on 12/12/12.
//  Copyright (c) 2012 ancun. All rights reserved.
//

@protocol ResultDelegate <NSObject>

@required
- (void)onControllerResult:(NSInteger)resultCode requestCode:(NSInteger)requestCode data:(NSMutableDictionary*)result;

@end
