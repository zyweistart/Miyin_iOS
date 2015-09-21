//
//  AlermRingCell.h
//  Grall Now
//
//  Created by Yang Shubo on 13-8-29.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlermRingCell : UITableViewCell
{
    IBOutlet UILabel *lbName;
    IBOutlet UIImageView *imgCheck;
    //UIImage* imgchecked;
    //UIImage* imgunchecked;
}
@property(nonatomic)NSInteger* SongId;
-(void)Bind:(NSString*)name ID:(NSInteger*)Id ;
-(void)SetCheck:(BOOL)checked;
@end
