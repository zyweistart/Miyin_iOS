//
//  EDGButtonCell.m
//  eClient
//
//  Created by Start on 3/24/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "EDGButtonCell.h"
#import "SVButton.h"
#import "ElectricianManagerSearchViewController.h"
#import "ElectricianManagerAddViewController.h"

@implementation EDGButtonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        SVButton *bSearch=[[SVButton alloc]initWithFrame:CGRectMake1(180, 5, 60, 30) Title:@"选择" Type:3];
//        bSearch.tag = section;
        [bSearch addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bSearch];
        SVButton *bAdd=[[SVButton alloc]initWithFrame:CGRectMake1(250, 5, 60, 30) Title:@"添加" Type:3];
//        bAdd.tag = section;
        [bAdd addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bAdd];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)add:(id)sender
{
    [[self.controller navigationController]pushViewController:[[ElectricianManagerAddViewController alloc]initWithParams:self.data] animated:YES];
}

- (void)search:(id)sender
{
    [[self.controller navigationController]pushViewController:[[ElectricianManagerSearchViewController alloc]initWithParams:self.data] animated:YES];
}

@end
