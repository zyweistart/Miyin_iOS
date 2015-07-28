//
//  HomeViewController.m
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "HomeViewController.h"
#import "MenuCell.h"

#define DEFAULCENTIGRADEVALUE 200

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"BBQ Connected"];
        [self buildTableViewWithView:self.view];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView setBackgroundColor:DEFAULTITLECOLORRGB(65, 51, 42)];
        
        [[[Data Instance]settValue]setObject:@"10h56m" forKey:@"p3"];
    }
    return self;
}

- (void)loadData:(NSArray*)array
{
    self.dataItemArray=[[NSMutableArray alloc]initWithArray:array];
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGHeight(190);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"InfoCellIdentifier";
    MenuCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        cell = [[MenuCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] ;
    }
    NSDictionary *data = [self.dataItemArray objectAtIndex:[indexPath row]];
    [cell setData:data];
    for(id key in [data allKeys]){
        NSString *title=[NSString stringWithFormat:@"%@",key];
        NSString *centigrade=[NSString stringWithFormat:@"%@",[data objectForKey:key]];
        
        int currentValue=[centigrade intValue];
        [cell.lblTitle setText:title];
        
        [cell.lblCurrentCentigrade setText:[Data getTemperatureValue:currentValue]];
        [cell.lblCurrentSamllCentigrade setTitle:[Data getTemperatureValue:currentValue] forState:UIControlStateNormal];
        
        //默认值
        int currentHighValue=DEFAULCENTIGRADEVALUE;
        if([[[Data Instance] sett] count]>0){
            for(NSDictionary *d in [[Data Instance] sett]) {
                NSString *value=[d objectForKey:title];
                if(value){
                    currentHighValue=[value intValue];
                    break;
                }
            }
        }
        
        [cell.lblHighestCentigrade setText:[Data getTemperatureValue:currentHighValue]];
        
        CGFloat hWidth=220;
        CGFloat width=hWidth/currentHighValue*currentValue;
        if(width>hWidth){
            width=hWidth;
        }
        [cell.lblCurrentSamllCentigrade setFrame:CGRectMake1(40+width, 5, 60, 20)];
        [cell.viewCentigrade setFrame:CGRectMake1(2, 2, width, 16)];
        
        NSString *timer=[[[Data Instance]settValue]objectForKey:title];
        [cell.lblSetTime setText:timer];
    }
    return  cell;
}


@end