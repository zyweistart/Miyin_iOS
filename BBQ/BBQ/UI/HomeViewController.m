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

- (id)init
{
    self=[super init];
    if(self){
        [self cTitle:@"BBQ Connected"];
        UIButton *bButton = [[UIButton alloc]init];
        [bButton setFrame:CGRectMake1(0, 0, 22, 30)];
        [bButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [bButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [bButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bButton];
        [self buildTableViewWithView:self.view];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView setBackgroundColor:DEFAULTITLECOLORRGB(65, 51, 42)];
        
        self.bgFrame=[[UIView alloc]initWithFrame:self.view.bounds];
        [self.bgFrame setBackgroundColor:DEFAULTITLECOLORA(150, 0.5)];
        [self.bgFrame setHidden:YES];
        [self.view addSubview:self.bgFrame];
        
        self.mSetTempView=[[SetTempView alloc]initWithFrame:CGRectMake1(10, 100, 300, 200)];
        [self.mSetTempView.cancelButton addTarget:self action:@selector(SetTempCloseCancel) forControlEvents:UIControlEventTouchUpInside];
        [self.mSetTempView.okButton addTarget:self action:@selector(SetTempCloseOK) forControlEvents:UIControlEventTouchUpInside];
        [self.mSetTempView setHidden:YES];
        [self.bgFrame addSubview:self.mSetTempView];
        
        self.pv1=[[DatePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-CGHeight(260+BOTTOMTABBARHEIGHT), CGWidth(320), CGHeight(260))];
        [self.pv1 setCode:1];
        [self.pv1 setDelegate:self];
        [self.view addSubview:self.pv1];
    }
    return self;
}

- (void)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    for(id k in [data allKeys]){
        NSString *key=[NSString stringWithFormat:@"%@",k];
        NSString *centigrade=[NSString stringWithFormat:@"%@",[data objectForKey:key]];
        
        int currentValue=[centigrade intValue];
        [cell.lblTitle setText:key];
        
        [cell.lblCurrentCentigrade setText:[Data getTemperatureValue:currentValue]];
        [cell.lblCurrentSamllCentigrade setTitle:[Data getTemperatureValue:currentValue] forState:UIControlStateNormal];
        
        //默认值
        int currentHighValue=DEFAULCENTIGRADEVALUE;
        
        NSString *value=[[[Data Instance] sett] objectForKey:key];
        if(value){
            currentHighValue=[value intValue];
        }else{
            //设置默认值
            [[[Data Instance] sett]setObject:[NSString stringWithFormat:@"%d",DEFAULCENTIGRADEVALUE] forKey:key];
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
        
        NSString *timer=[[[Data Instance]settValue]objectForKey:key];
        int tv=[timer intValue];
        if(tv>0){
            int hour=tv/60;
            int min=tv%60;
            NSString *hstr=[NSString stringWithFormat:@"0%d",hour];
            if(hour>9){
                hstr=[NSString stringWithFormat:@"%d",hour];
            }
            NSString *mstr=[NSString stringWithFormat:@"0%d",min];
            if(min>9){
                mstr=[NSString stringWithFormat:@"%d",min];
            }
            [cell.lblSetTime setText:[NSString stringWithFormat:@"%@:%@",hstr,mstr]];
            if(row==0){
                if(self.mTimer1==nil){
                    self.mTimer1=[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(updateTimer1:) userInfo:data repeats:YES];
                }
            }else if(row==1){
                if(self.mTimer2==nil){
                    self.mTimer2=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer2:) userInfo:data repeats:YES];
                }
            }else if(row==2){
                if(self.mTimer3==nil){
                    self.mTimer3=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer3:) userInfo:data repeats:YES];
                }
            }else{
                if(self.mTimer4==nil){
                    self.mTimer4=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer4:) userInfo:data repeats:YES];
                }
            }
        }
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
    [self.pv1 setTag:sender.tag];
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
        [[[Data Instance]sett]setObject:[NSString stringWithFormat:@"%d",value] forKey:key];
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
        NSDictionary *data=[self.dataItemArray objectAtIndex:self.pv1.tag];
        for(id key in [data allKeys]){
            NSInteger rowHour=[self.pv1.picker selectedRowInComponent:0]+1;
            NSInteger rowMin=[self.pv1.picker selectedRowInComponent:1];
            NSInteger totalSecond=rowHour*60+rowMin;
            [[[Data Instance]settValue]setObject:[NSString stringWithFormat:@"%ld",totalSecond] forKey:key];
            [self.tableView reloadData];
        }
    }
}

- (void)updateTimer1:(NSTimer*)sender
{
    [self EndUpdateTimer:self.mTimer1 Row:0];
}

- (void)updateTimer2:(NSTimer*)sender
{
    [self EndUpdateTimer:self.mTimer2 Row:1];
}

- (void)updateTimer3:(NSTimer*)sender
{
    [self EndUpdateTimer:self.mTimer3 Row:2];
}

- (void)updateTimer4:(NSTimer*)sender
{
    [self EndUpdateTimer:self.mTimer4 Row:3];
}

- (void)EndUpdateTimer:(NSTimer*)timer Row:(NSInteger)row
{
    NSDictionary *data=[self.dataItemArray objectAtIndex:row];
    for(id key in [data allKeys]){
        NSString *min=[[[Data Instance]settValue]objectForKey:key];
        int currentValue=[min intValue]-60;
        [[[Data Instance]settValue]setObject:[NSString stringWithFormat:@"%d",currentValue] forKey:key];
        [self.tableView reloadData];
        if(currentValue<=0){
            [timer invalidate];
            timer=nil;
            NSLog(@"%ld,结束了",row);
        }
        break;
    }
}

@end