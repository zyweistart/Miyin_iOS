//
//  AlermRingCell.m
//  Grall Now
//
//  Created by Yang Shubo on 13-8-29.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import "AlermRingCell.h"

@implementation AlermRingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //imgchecked = [UIImage imageNamed:@"chicken.png"];
        //imgunchecked=
        imgCheck.image = [UIImage imageNamed:@"check.png"];
        
        // Initialization code
    }
    return self;
}

 
 
-(void)Bind:(NSString *)name ID:(NSInteger *)Id
{
    lbName.text = name;
    self.SongId = Id;
}

-(void)SetCheck:(BOOL)checked
{
    //if(checked)
    //{
    //    imgCheck.image = imgchecked;
    //}
    //else{
    //    imgCheck.image = imgunchecked;
    //}
    NSLog(@"%@[%@]",checked==1?@"YES":@"NO",lbName.text);
    
    [imgCheck setHidden:!checked];
}


@end
