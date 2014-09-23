//
//  STInspectionTemperatureViewController.m
//  ElectricianClient
//
//  Created by Start on 3/27/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STInspectionTemperatureViewController.h"
#import "STInspection2Cell.h"

@interface STInspectionTemperatureViewController ()

@end

@implementation STInspectionTemperatureViewController{
    NSMutableArray *dataItemArray1;
    NSMutableArray *dataItemArray2;
    NSMutableArray *dataItemArray3;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title=@"设备温度、外观检查记录";
        dataItemArray1=[[NSMutableArray alloc]init];
        NSMutableDictionary *data=[[NSMutableDictionary alloc]init];
        [data setObject:@"变压器温度:" forKey:@"KEY"];
        [data setObject:@"54" forKey:@"VALUE"];
        [dataItemArray1 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"总柜温度:" forKey:@"KEY"];
        [data setObject:@"44" forKey:@"VALUE"];
        [dataItemArray1 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"电容柜温度:" forKey:@"KEY"];
        [data setObject:@"42" forKey:@"VALUE"];
        [dataItemArray1 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"出线柜温度:" forKey:@"KEY"];
        [data setObject:@"47" forKey:@"VALUE"];
        [dataItemArray1 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"变压器检查项目：声音、接头、油位油色、吸湿剂、风机:" forKey:@"KEY"];
        [data setObject:@"正常" forKey:@"VALUE"];
        [dataItemArray1 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"高低压柜检查项目：指示灯、表计、声音、母排、接头:" forKey:@"KEY"];
        [data setObject:@"正常" forKey:@"VALUE"];
        [dataItemArray1 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"电容器检查项目：鼓胀、漏液、指示灯、接头、发热:" forKey:@"KEY"];
        [data setObject:@"正常" forKey:@"VALUE"];
        [dataItemArray1 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"其他检查项目：电缆发热闪络、照明、直流设备、安全工器具:" forKey:@"KEY"];
        [data setObject:@"正常" forKey:@"VALUE"];
        [dataItemArray1 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"异常描述:" forKey:@"KEY"];
        [data setObject:@"" forKey:@"VALUE"];
        [dataItemArray1 addObject:data];
        
        dataItemArray2=[[NSMutableArray alloc]init];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"变压器温度:" forKey:@"KEY"];
        [data setObject:@"56" forKey:@"VALUE"];
        [dataItemArray2 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"总柜温度:" forKey:@"KEY"];
        [data setObject:@"43" forKey:@"VALUE"];
        [dataItemArray2 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"电容柜温度:" forKey:@"KEY"];
        [data setObject:@"46" forKey:@"VALUE"];
        [dataItemArray2 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"出线柜温度:" forKey:@"KEY"];
        [data setObject:@"48" forKey:@"VALUE"];
        [dataItemArray2 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"变压器检查项目：声音、接头、油位油色、吸湿剂、风机:" forKey:@"KEY"];
        [data setObject:@"正常" forKey:@"VALUE"];
        [dataItemArray2 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"高低压柜检查项目：指示灯、表计、声音、母排、接头:" forKey:@"KEY"];
        [data setObject:@"正常" forKey:@"VALUE"];
        [dataItemArray2 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"电容器检查项目：鼓胀、漏液、指示灯、接头、发热:" forKey:@"KEY"];
        [data setObject:@"正常" forKey:@"VALUE"];
        [dataItemArray2 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"其他检查项目：电缆发热闪络、照明、直流设备、安全工器具:" forKey:@"KEY"];
        [data setObject:@"正常" forKey:@"VALUE"];
        [dataItemArray2 addObject:data];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"异常描述:" forKey:@"KEY"];
        [data setObject:@"" forKey:@"VALUE"];
        [dataItemArray2 addObject:data];
        
        dataItemArray3=[[NSMutableArray alloc]init];
        data=[[NSMutableDictionary alloc]init];
        [data setObject:@"本月总评及建议:" forKey:@"KEY"];
        [data setObject:@"" forKey:@"VALUE"];
        [dataItemArray3 addObject:data];
        
        [self.tableView reloadData];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return [dataItemArray1 count];
    }else if(section==1){
        return [dataItemArray2 count];
    }else{
        return [dataItemArray3 count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==0){
        return @"1#变";
    }else if(section==1){
        return @"2#变";
    }else{
        return @"";
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
    }else if([indexPath section]==1){
        data=[dataItemArray2 objectAtIndex:[indexPath row]];
    }else{
        data=[dataItemArray3 objectAtIndex:[indexPath row]];
    }
    
    [[cell lbl1] setText:[data objectForKey:@"KEY"]];
    [[cell lbl2] setText:[data objectForKey:@"VALUE"]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}


@end
