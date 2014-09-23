//
//  STElectricalDegreeViewController.m
//  ElectricianClient
//
//  Created by Start on 3/27/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STElectricalDegreeViewController.h"
#import "STInspection1Cell.h"

@interface STElectricalDegreeViewController ()

@end

@implementation STElectricalDegreeViewController{
    NSMutableArray *dataItemArray1;
    NSMutableArray *dataItemArray2;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title=@"计量电度表数";
        
        dataItemArray1=[[NSMutableArray alloc]init];
        NSMutableDictionary *data=[[NSMutableDictionary alloc]init];
        [data setObject:@"236.0" forKey:@"a1"];
        [data setObject:@"14.16" forKey:@"a2"];
        [data setObject:@"141.6" forKey:@"a3"];
        [data setObject:@"80.24" forKey:@"a4"];
        [data setObject:@"92.91" forKey:@"b1"];
        [data setObject:@"5.57" forKey:@"b2"];
        [data setObject:@"55.75" forKey:@"b3"];
        [data setObject:@"31.59" forKey:@"b4"];
        [data setObject:@"143.09" forKey:@"c1"];
        [data setObject:@"8.59" forKey:@"c2"];
        [data setObject:@"85.85" forKey:@"c3"];
        [data setObject:@"48.65" forKey:@"c4"];
        [dataItemArray1 addObject:data];
        
        dataItemArray2=[[NSMutableArray alloc]init];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"248.0" forKey:@"a1"];
        [data setObject:@"14.88" forKey:@"a2"];
        [data setObject:@"148.8" forKey:@"a3"];
        [data setObject:@"84.32" forKey:@"a4"];
        [data setObject:@"96.11" forKey:@"b1"];
        [data setObject:@"5.57" forKey:@"b2"];
        [data setObject:@"57.67" forKey:@"b3"];
        [data setObject:@"32.68" forKey:@"b4"];
        [data setObject:@"151.89" forKey:@"c1"];
        [data setObject:@"9.11" forKey:@"c2"];
        [data setObject:@"91.13" forKey:@"c3"];
        [data setObject:@"51.64" forKey:@"c4"];
        [dataItemArray2 addObject:data];
        
        [self.tableView reloadData];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return [dataItemArray1 count];
    }else{
        return [dataItemArray2 count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==0){
        return @"进线1";
    }else{
        return @"进线2";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    STInspection1Cell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if(!cell) {
        cell = [[STInspection1Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
    }
    
    NSDictionary *data=nil;
    if([indexPath section]==0){
        data=[dataItemArray1 objectAtIndex:[indexPath row]];
    }else{
        data=[dataItemArray2 objectAtIndex:[indexPath row]];
    }
    
    [[cell lbl1]setText:[data objectForKey:@"a1"]];
    [[cell lbl2]setText:[data objectForKey:@"a2"]];
    [[cell lbl3]setText:[data objectForKey:@"a3"]];
    [[cell lbl4]setText:[data objectForKey:@"a4"]];
    [[cell lbl5]setText:[data objectForKey:@"b1"]];
    [[cell lbl6]setText:[data objectForKey:@"b2"]];
    [[cell lbl7]setText:[data objectForKey:@"b3"]];
    [[cell lbl8]setText:[data objectForKey:@"b4"]];
    [[cell lbl9]setText:[data objectForKey:@"c1"]];
    [[cell lbl10]setText:[data objectForKey:@"c2"]];
    [[cell lbl11]setText:[data objectForKey:@"c3"]];
    [[cell lbl12]setText:[data objectForKey:@"c4"]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

@end
