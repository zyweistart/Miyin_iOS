//
//  STInspectionElectricViewController.m
//  ElectricianClient
//
//  Created by Start on 3/27/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STInspectionElectricViewController.h"
#import "STInspection2Cell.h"

@interface STInspectionElectricViewController ()

@end

@implementation STInspectionElectricViewController{
    NSMutableArray *dataItemArray1;
    NSMutableArray *dataItemArray2;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title=@"总柜电流值及功率因数记录";
        
        dataItemArray1=[[NSMutableArray alloc]init];
        NSMutableDictionary *data=[[NSMutableDictionary alloc]init];
        [data setObject:@"A相(A):" forKey:@"KEY"];
        [data setObject:@"694.04" forKey:@"VALUE"];
        [dataItemArray1 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"B相(B):" forKey:@"KEY"];
        [data setObject:@"702.00" forKey:@"VALUE"];
        [dataItemArray1 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"C相(C):" forKey:@"KEY"];
        [data setObject:@"691.25" forKey:@"VALUE"];
        [dataItemArray1 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"额定电流(A):" forKey:@"KEY"];
        [data setObject:@"1443" forKey:@"VALUE"];
        [dataItemArray1 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"UAB(V):" forKey:@"KEY"];
        [data setObject:@"363.74" forKey:@"VALUE"];
        [dataItemArray1 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"UBC(V):" forKey:@"KEY"];
        [data setObject:@"373.96" forKey:@"VALUE"];
        [dataItemArray1 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"UAC(V):" forKey:@"KEY"];
        [data setObject:@"363.84" forKey:@"VALUE"];
        [dataItemArray1 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"功率因数cosφ:" forKey:@"KEY"];
        [data setObject:@"0.89" forKey:@"VALUE"];
        [dataItemArray1 addObject:data];
        
        dataItemArray2=[[NSMutableArray alloc]init];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"A相(A):" forKey:@"KEY"];
        [data setObject:@"693.79" forKey:@"VALUE"];
        [dataItemArray2 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"B相(B):" forKey:@"KEY"];
        [data setObject:@"700.97" forKey:@"VALUE"];
        [dataItemArray2 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"C相(C):" forKey:@"KEY"];
        [data setObject:@"679.34" forKey:@"VALUE"];
        [dataItemArray2 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"额定电流(A):" forKey:@"KEY"];
        [data setObject:@"1443" forKey:@"VALUE"];
        [dataItemArray2 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"UAB(V):" forKey:@"KEY"];
        [data setObject:@"365.29" forKey:@"VALUE"];
        [dataItemArray2 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"UBC(V):" forKey:@"KEY"];
        [data setObject:@"377.02" forKey:@"VALUE"];
        [dataItemArray2 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"UAC(V):" forKey:@"KEY"];
        [data setObject:@"375.80" forKey:@"VALUE"];
        [dataItemArray2 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"功率因数cosφ:" forKey:@"KEY"];
        [data setObject:@"0.89" forKey:@"VALUE"];
        [dataItemArray2 addObject:data];
        
        [self.tableView reloadData];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==0){
        return @"1#受总";
    }else{
        return @"2#受总";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    STInspection2Cell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if(!cell) {
        cell = [[STInspection2Cell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellReuseIdentifier];
    }
    
    NSDictionary *data=nil;
    if([indexPath section]==0){
        data=[dataItemArray1 objectAtIndex:[indexPath row]];
    }else{
        data=[dataItemArray2 objectAtIndex:[indexPath row]];
    }
    
    [[cell lbl1] setText:[data objectForKey:@"KEY"]];
    [[cell lbl2] setText:[data objectForKey:@"VALUE"]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

@end
