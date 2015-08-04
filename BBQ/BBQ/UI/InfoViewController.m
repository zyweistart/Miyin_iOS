//
//  InfoViewController.m
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "InfoViewController.h"
#import "InfoCell.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:LOCALIZATION(@"Info")];
        
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景3"]]];
        
        [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(![[Data Instance]isDemo]){
        if (self.appDelegate.bleManager.activePeripheral){
            if(self.appDelegate.bleManager.activePeripheral.state==CBPeripheralStateConnected){
                [self ConnectedState:YES];
            }else{
                [self ConnectedState:NO];
            }
        }
    }
}

- (void)loadData:(NSArray*)array
{
    if([array count]==0){
        [self.tableView setHidden:YES];
        [self.mConnectedPanel setHidden:NO];
        [self.lblMessage setText:LOCALIZATION(@"Plase insert probes")];
        return;
    }
    self.dataItemArray=[[NSMutableArray alloc]initWithArray:array];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataItemArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGHeight(90);
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SAMPLECell";
    InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[InfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    [cell setLanguage];
    NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath section]];
    for(id k in [data allKeys]){
        NSString *key=[NSString stringWithFormat:@"%@",k];
        [cell.lblTitle setText:key];
        [cell.lblTimer setText:[self showTimerString:key]];
        NSString *sett=[[[Data Instance]sett]objectForKey:key];
        [cell.lblTargetTemp setText:[Data getTemperatureValue:sett]];
    }
    return cell;
}

- (NSString*)showTimerString:(NSString*)key
{
    NSString *timer=[[[Data Instance]settValue]objectForKey:key];
    int tv=[timer intValue];
    if(tv>0){
        int hour=tv/60;
        NSString *hstr=[NSString stringWithFormat:@"0%d",hour];
        if(hour>9){
            hstr=[NSString stringWithFormat:@"%d",hour];
        }
        int min=tv%60;
        NSString *mstr=[NSString stringWithFormat:@"0%d",min];
        if(min>9){
            mstr=[NSString stringWithFormat:@"%d",min];
        }
        return [NSString stringWithFormat:@"%@:%@",hstr,mstr];
    }else{
        return @"";
    }
}

- (void)ConnectedState:(BOOL)state
{
    [self.tableView setHidden:!state];
    [self.mConnectedPanel setHidden:state];
    [self.lblMessage setText:LOCALIZATION(@"Connection is broken")];
}

- (void)changeLanguageText
{
    [self cTitle:LOCALIZATION(@"Info")];
    [self setTitle:LOCALIZATION(@"Info")];
    [self.tableView reloadData];
}

@end