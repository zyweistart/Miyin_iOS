//
//  DeviceSeleterCell.h
//  Graff Now
//
//  Created by Yang Shubo on 13-8-26.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Device.h"

@interface DeviceSeleterCell : UITableViewCell
{
    IBOutlet UILabel *lbText;
    IBOutlet UIImageView *imgBg;
    IBOutlet UILabel *lbNumber;
}

@property(nonatomic,strong)CBPeripheral* BindPeripheral;

-(void)SetContent:(NSString*)num Name:(NSString*)name;
@end