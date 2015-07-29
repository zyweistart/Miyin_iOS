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

@implementation HomeViewController{
    NSInteger pvv1;
}

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"BBQ Connected"];
        [self buildTableViewWithView:self.view];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView setBackgroundColor:DEFAULTITLECOLORRGB(65, 51, 42)];
        
        [[[Data Instance]settValue]setObject:@"10h56m" forKey:@"p3"];
        
        self.bgFrame=[[UIView alloc]initWithFrame:self.view.bounds];
        [self.bgFrame setBackgroundColor:DEFAULTITLECOLORA(150, 0.5)];
        [self.bgFrame setHidden:YES];
        [self.view addSubview:self.bgFrame];
        
        self.mSetTempView=[[SetTempView alloc]initWithFrame:CGRectMake1(10, 100, 300, 200)];
        [self.mSetTempView.cancelButton addTarget:self action:@selector(SetTempCloseCancel) forControlEvents:UIControlEventTouchUpInside];
        [self.mSetTempView.okButton addTarget:self action:@selector(SetTempCloseOK) forControlEvents:UIControlEventTouchUpInside];
        [self.mSetTempView setHidden:YES];
        [self.bgFrame addSubview:self.mSetTempView];
        
        
        
        NSArray *roles=[NSArray arrayWithObjects:
         [NSDictionary dictionaryWithObjectsAndKeys:@"个人",MKEY,@"0",MVALUE, nil],
         [NSDictionary dictionaryWithObjectsAndKeys:@"机手",MKEY,@"1",MVALUE, nil],
         [NSDictionary dictionaryWithObjectsAndKeys:@"项目经理",MKEY,@"2",MVALUE, nil],
         [NSDictionary dictionaryWithObjectsAndKeys:@"其他公司",MKEY,@"3",MVALUE, nil],
         [NSDictionary dictionaryWithObjectsAndKeys:@"运输公司",MKEY,@"4",MVALUE, nil],
         [NSDictionary dictionaryWithObjectsAndKeys:@"配件公司",MKEY,@"5",MVALUE, nil],
         [NSDictionary dictionaryWithObjectsAndKeys:@"维修公司",MKEY,@"6",MVALUE, nil],
         [NSDictionary dictionaryWithObjectsAndKeys:@"吊装公司",MKEY,@"7",MVALUE, nil],
         [NSDictionary dictionaryWithObjectsAndKeys:@"工程公司",MKEY,@"8",MVALUE, nil],nil];
        
        self.pv1=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-CGHeight(260), CGWidth(320), CGHeight(260)) WithArray:roles];
        [self.pv1 setCode:1];
        [self.pv1 setDelegate:self];
        [self.view addSubview:self.pv1];
        
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
    NSInteger row=[indexPath row];
    NSDictionary *data = [self.dataItemArray objectAtIndex:row];
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
        
        NSString *value=[[[Data Instance] sett] objectForKey:title];
        if(value){
            currentHighValue=[value intValue];
        }else{
            //设置默认值
            [[[Data Instance] sett]setObject:[NSString stringWithFormat:@"%d",DEFAULCENTIGRADEVALUE] forKey:title];
        }
        
        [cell.lblHighestCentigrade setTitle:[Data getTemperatureValue:currentHighValue] forState:UIControlStateNormal];
        [cell.lblHighestCentigrade setTag:row];
        [cell.lblHighestCentigrade addTarget:self action:@selector(setValue:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat hWidth=220;
        CGFloat width=hWidth/currentHighValue*currentValue;
        if(width>hWidth){
            width=hWidth;
        }
        [cell.lblCurrentSamllCentigrade setFrame:CGRectMake1(40+width, 5, 60, 20)];
        [cell.viewCentigrade setFrame:CGRectMake1(2, 2, width, 16)];
        
        NSString *timer=[[[Data Instance]settValue]objectForKey:title];
        [cell.lblSetTime setText:timer];
        [cell.bTimer setTag:row];
        [cell.bTimer addTarget:self action:@selector(setTimer:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  cell;
}

- (void)setValue:(UIButton*)sender
{
    NSDictionary *data = [self.dataItemArray objectAtIndex:sender.tag];
    for(id key in [data allKeys]){
        NSString *title=[NSString stringWithFormat:@"%@",key];
        NSString *value=[[[Data Instance] sett] objectForKey:title];
        [self.mSetTempView setTag:sender.tag];
        [self SetTempShowWithTitle:title Value:[value intValue]];
    }
}

- (void)setTimer:(UIButton*)sender
{
    [self.pv1 setHidden:NO];
}

- (void)SetTempShowWithTitle:(NSString*)title Value:(int)value;
{
    [self.mSetTempView setValue:value];
    [self.mSetTempView.lblTitle setText:title];
    [self.mSetTempView setHidden:NO];
    [self.bgFrame setHidden:NO];
}

- (void)SetTempCloseCancel
{
    [self.mSetTempView setHidden:YES];
    [self.bgFrame setHidden:YES];
}

- (void)SetTempCloseOK
{
    NSDictionary *data = [self.dataItemArray objectAtIndex:self.mSetTempView.tag];
    for(id key in [data allKeys]){
        NSString *title=[NSString stringWithFormat:@"%@",key];
        int value=self.mSetTempView.mSlider.value;
        [[[Data Instance]sett]setObject:[NSString stringWithFormat:@"%d",value] forKey:title];
        [self.tableView reloadData];        
        NSString *json=[NSString stringWithFormat:@"{\"sett\":{\"%@\":%d.1}}",title,value];
        [self.appDelegate sendData:json];
    }
    [self.mSetTempView setHidden:YES];
    [self.bgFrame setHidden:YES];
}

- (void)pickerViewDone:(NSInteger)code
{
    if(code==1) {
        pvv1=[self.pv1.picker selectedRowInComponent:0];
        NSDictionary *d=[self.pv1.pickerArray objectAtIndex:pvv1];
        NSString *content=[d objectForKey:MVALUE];
        NSLog(@"%@",content);
    }
}

@end