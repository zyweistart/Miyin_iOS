//
//  AlarmRing.h
//  Grall Now
//
//  Created by Yang Shubo on 13-8-29.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlarmRing : NSObject
@property(nonatomic,strong) NSString* RingName;
@property(nonatomic,strong) NSString* RingFilePath;
@property(nonatomic,strong) NSString* RingPrefix;
@property(nonatomic)BOOL IsSelected;
@property(nonatomic) UInt32 RingId;
@end
