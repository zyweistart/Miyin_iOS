//
//  STWarnComapnySimulationDataViewController.m
//  ElectricianClient
//
//  Created by Start on 3/27/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STWarnComapnySimulationDataViewController.h"
#import "STAlarm2Cell.h"

@interface STWarnComapnySimulationDataViewController ()

@end

@implementation STWarnComapnySimulationDataViewController{
    int _type;
}

- (id)initWithType:(int)type
{
    self = [super init];
    if (self) {
        _type=type;
        if(type==1){
            self.title=@"实时报警";
        }else if(type==2){
            self.title=@"历史报警";
        }
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(back:)];
        [self reloadTableViewDataSource];
    }
    return self;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    STAlarm2Cell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if(!cell) {
        cell = [[STAlarm2Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
    }
    
    NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
    
    [[cell lbl1] setText:[Common NSNullConvertEmptyString:[data objectForKey:@"NAME"]]];
    [[cell lbl2] setText:[Common NSNullConvertEmptyString:[data objectForKey:@"DATE"]]];
    [[cell lbl3] setText:[Common NSNullConvertEmptyString:[data objectForKey:@"SITE"]]];
    [[cell lbl4] setText:[Common NSNullConvertEmptyString:[data objectForKey:@"REPLY"]]];
    [[cell lbl5] setText:[Common NSNullConvertEmptyString:[data objectForKey:@"CONTENT"]]];
    [[cell lbl6] setText:[Common NSNullConvertEmptyString:[data objectForKey:@"LEVEL"]]];
    return cell;
}

- (void)reloadTableViewDataSource{
    NSArray *names=nil;
    NSArray *sites=nil;
    NSArray *levels=nil;
    NSArray *replys=nil;
    NSArray *contents=nil;
    NSArray *dates=nil;
    if(_type==1){
        names=[[NSArray alloc]initWithObjects:
               @"模拟站",@"模拟站",@"模拟站",@"模拟站",@"模拟站", nil];
        sites=[[NSArray alloc]initWithObjects:
               @"B1受总",@" B1-1",@"B1-2",@"B1-3",@"B2受总", nil];
        levels=[[NSArray alloc]initWithObjects:
                @"紧急报警",@"紧急报警",@"紧急报警",@"紧急报警",@"紧急报警", nil];
        replys=[[NSArray alloc]initWithObjects:
                @"已处理",@"已处理",@"已处理",@"已处理",@"已处理", nil];
        contents=[[NSArray alloc]initWithObjects:
                  @"A相：欠压 B相：欠压 C相：欠压",@"A相：欠压 B相：欠压 C相：欠压",@"电流值【403A】，超出额定电流【315A】的1.2倍",@"A相：欠压 B相：欠压 C相：欠压",@"A相：欠压 B相：欠压 C相：欠压", nil];
        dates=[[NSArray alloc]initWithObjects:
               @"2013-11-28 11:18",@"2013-11-28 11:10",@"2013-11-28 11:10",@"2013-11-28 11:03",@"2013-11-28 10:46", nil];
    }else{
        names=[[NSArray alloc]initWithObjects:
               @"模拟站",@"模拟站",@"模拟站",@"模拟站",@"模拟站",@"模拟站",@"模拟站",@"模拟站",@"模拟站",@"模拟站", nil];
        sites=[[NSArray alloc]initWithObjects:
               @"B1受2总",@"B1-1",@"B1-2",@"B1-3",@"B2受总",@"B2-1",@"B2-2",@"B2-3",@"B3受总",@"B3-1", nil];
        levels=[[NSArray alloc]initWithObjects:
                @"紧急报警",@"紧急报警",@"紧急报警",@"紧急报警",@"紧急报警",@"紧急报警",@"紧急报警",@"紧急报警",@"紧急报警",@"紧急报警", nil];
        replys=[[NSArray alloc]initWithObjects:
                @"已处理",@"已处理",@"已处理",@"已处理",@"已处理",@"已处理",@"已处理",@"已处理",@"已处理",@"已处理", nil];
        contents=[[NSArray alloc]initWithObjects:
                  @"A相：欠压 B相：欠压 C相：欠压",@"A相：欠压 B相：欠压 C相：欠压",@"电流值【403A】，超出额定电流【315A】的1.2倍",@"A相：欠压 B相：欠压 C相：欠压",@"A相：欠压 B相：欠压 C相：欠压",@"电流值【350A】，超出额定电流【315A】的0.9倍",@"A相：欠压 B相：欠压 C相：欠压",@"A相：欠压 B相：欠压 C相：欠压",@"A相：欠压 B相：欠压 C相：欠压",@"A相：欠压 B相：欠压 C相：欠压", nil];
        dates=[[NSArray alloc]initWithObjects:
               @" 11:18",@" 11:10",@" 11:10",@" 11:03",@" 10:46",@" 10:45",@" 10:42",@" 10:41",@" 11:10",@" 11:03", nil];
    }
    
    if(self.dataItemArray==nil){
        self.dataItemArray=[[NSMutableArray alloc]init];
    }
    
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate=[NSDate date];
    NSTimeInterval secondsPerDay = 86400*7;
    NSDate *endDate = [startDate dateByAddingTimeInterval:-secondsPerDay];
    NSString *endDateStr = [dateFormatter stringFromDate:endDate];
    
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *time=[dateFormatter stringFromDate:startDate];
    for(int i=0;i<[names count];i++){
        NSMutableDictionary *data=[[NSMutableDictionary alloc]init];
        [data setObject:[names objectAtIndex:i] forKey:@"NAME"];
        [data setObject:[sites objectAtIndex:i] forKey:@"SITE"];
        [data setObject:[levels objectAtIndex:i] forKey:@"LEVEL"];
        [data setObject:[replys objectAtIndex:i] forKey:@"REPLY"];
        [data setObject:[contents objectAtIndex:i] forKey:@"CONTENT"];
        if(_type==2){
            [data setObject:[NSString stringWithFormat:@"%@%@",endDateStr,[dates objectAtIndex:i]] forKey:@"DATE"];
        }else{
            [data setObject:time forKey:@"DATE"];
        }
        [self.dataItemArray addObject:data];
    }
    
    [self.tableView reloadData];
}

@end

