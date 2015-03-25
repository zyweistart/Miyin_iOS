//
//  TimeSelectViewController.m
//  eClient
//
//  Created by Start on 3/25/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "TimeSelectViewController.h"
#import "CRTableViewCell.h"

@interface TimeSelectViewController ()

@end

@implementation TimeSelectViewController

#pragma mark - Lifecycle
- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"时间选择";
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                        style:UIBarButtonSystemItemDone target:self action:@selector(done:)];
        self.navigationItem.rightBarButtonItem = rightButton;
        
        self.dataItemArray = [[NSMutableArray alloc] initWithObjects:
                              @"00:00",
                              @"02:00",
                              @"04:00",
                              @"06:00",
                              @"08:00",
                              @"10:00",
                              @"12:00",
                              @"14:00",
                              @"16:00",
                              @"18:00",
                              @"20:00",
                              @"22:00",
                              nil];
        selectedMarks = [NSMutableArray new];
        [self buildTableViewWithView:self.view];
        
    }
    return self;
}

#pragma mark - UITableView Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataItemArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
    // init the CRTableViewCell
    CRTableViewCell *cell = (CRTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[CRTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CRTableViewCellIdentifier];
    }
    NSString *text = [self.dataItemArray objectAtIndex:[indexPath row]];
    cell.isSelected = [selectedMarks containsObject:text] ? YES : NO;
    cell.textLabel.text = text;
    
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [self.dataItemArray objectAtIndex:[indexPath row]];
    
    if ([selectedMarks containsObject:text])// Is selected?
        [selectedMarks removeObject:text];
    else
        [selectedMarks addObject:text];
    
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Methods
- (void)done:(id)sender
{
    NSLog(@"%@", selectedMarks);
}

@end

