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
        UIButton *bDone = [UIButton buttonWithType:UIButtonTypeCustom];
        [bDone setTitle:@"完成" forState:UIControlStateNormal];
        [bDone.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bDone addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
        bDone.frame = CGRectMake(0, 0, 70, 30);
        bDone.layer.cornerRadius = 5;
        bDone.layer.masksToBounds = YES;
        UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                target:nil action:nil];
        negativeSpacerRight.width = -20;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacerRight, [[UIBarButtonItem alloc] initWithCustomView:bDone], nil];
        
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
    if ([selectedMarks containsObject:text]){
        [selectedMarks removeObject:text];
    }else{
        [selectedMarks addObject:text];
    }
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Methods
- (void)done:(id)sender
{
    if([selectedMarks count]==0){
        [Common alert:@"请选择时间段"];
        return;
    }
    NSMutableString *ms=[[NSMutableString alloc]init];
    for(id str in selectedMarks){
        [ms appendFormat:@"%@-",str];
    }
    NSRange deleteRange = {[ms length]-1,1};
    [ms deleteCharactersInRange:deleteRange];
    NSMutableDictionary *data=[[NSMutableDictionary alloc]init];
    [data setValue:ms forKey:@"TIMES"];
    [self.delegate onControllerResult:self.resultCode data:data];
    [self.navigationController popViewControllerAnimated:YES];
}

@end