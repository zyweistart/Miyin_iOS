//
//  STTaskAuditRecord1ViewController.m
//  ElectricianRun
//
//  Created by Start on 2/20/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STTaskAuditRecord1ViewController.h"
#import "STTaskAuditRecord2ViewController.h"
#import "STCommentViewController.h"

@interface STTaskAuditRecord1ViewController ()

@end

@implementation STTaskAuditRecord1ViewController

- (id)initWithData:(NSDictionary *) data
{
    self = [super init];
    if (self) {
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"评论"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(evaluate:)];

        
        self.data=data;
        
        self.dataItemArray=[[NSMutableArray alloc]initWithObjects:@"1",@"3",@"2", nil];
        
    }
    return self;
}

- (void)evaluate:(id)sender
{
    STCommentViewController *commentViewController=[[STCommentViewController alloc]init];
    [self.navigationController pushViewController:commentViewController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSUInteger row=[indexPath row];
    NSString *data=[self.dataItemArray objectAtIndex:row];
    if([@"1" isEqualToString:data]){
        cell.textLabel.text=@"计量电度表数";
    } else if([@"3" isEqualToString:data]){
        cell.textLabel.text=@"设备温度、外观检查记录";
    } else if([@"2" isEqualToString:data]){
        cell.textLabel.text=@"总柜电流值及功率因数记录";
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSUInteger row=[indexPath row];
    NSString *v=[self.dataItemArray objectAtIndex:row];
    STTaskAuditRecord2ViewController *taskAuditRecord2ViewController=[[STTaskAuditRecord2ViewController alloc]initWithData:[self data] type:[v intValue]];
    [self.navigationController pushViewController:taskAuditRecord2ViewController animated:YES];
    
}

@end
