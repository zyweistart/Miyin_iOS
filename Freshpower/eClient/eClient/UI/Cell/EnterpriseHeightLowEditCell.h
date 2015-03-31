//
//  EnterpriseHeightLowEditCell.h
//  eClient
//
//  Created by Start on 3/31/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnterpriseHeightLowEditCell : UITableViewCell

@property (strong,nonatomic) UILabel *lblName;
@property (strong,nonatomic) UILabel *lblPhone;
@property (strong,nonatomic) UILabel *lblCount;
@property UITableView *tableView;
@property NSMutableArray *dataItemArray;

- (void)setData:(NSDictionary*)data;

@end
