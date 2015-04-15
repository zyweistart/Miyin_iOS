//
//  ElectricityContrastViewController.m
//  eClient
//
//  Created by Start on 4/15/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "ElectricityContrastViewController.h"

@interface ElectricityContrastViewController ()

@end

@implementation ElectricityContrastViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"电量电费"];
        [self buildTableViewWithView:self.view];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadHttp];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataItemArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataItemArray objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGHeight(45);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CMainCell = @"CMainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier: CMainCell];
    }
    [cell.textLabel setText:@"晨哪里有lkjd黑曜石l"];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:[[User Instance]getPassword] forKey:@"authentication"];
    [params setObject:[[[User Instance]getResultData]objectForKey:@"CP_ID"] forKey:@"QTCP"];
    [params setObject:@"010501" forKey:@"GNID"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:URL_appTaskingPower requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
//    if([response successFlag]){
//        NSLog(@"%@",[response responseString]);
//    }
    NSArray *table1=[[response resultJSON]objectForKey:@"table1"];
    NSArray *table2=[[response resultJSON]objectForKey:@"table2"];
    NSLog(@"%@",table1);
    NSLog(@"%@",table2);
}


@end