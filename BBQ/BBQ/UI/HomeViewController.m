//
//  HomeViewController.m
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)init
{
    self=[super init];
    if(self){
        
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景3"]]];
        
        UIButton *bButton = [[UIButton alloc]init];
        [bButton setFrame:CGRectMake1(0, 0, 22, 30)];
        [bButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [bButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [bButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bButton];
        self.scrollFrameView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [self.scrollFrameView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.scrollFrameView setBackgroundColor:DEFAULTITLECOLORRGB(65, 51, 42)];
        [self.view addSubview:self.scrollFrameView];
        //针1
        if(self.mMenuItemView1==nil){
            self.mMenuItemView1=[[MenuItemView alloc]initWithFrame:CGRectMake1(0, 0, 320, 190)];
            [self.mMenuItemView1 setBaseController:self];
            [self.mMenuItemView1.lblHighestCentigrade setTag:0];
            [self.mMenuItemView1.lblHighestCentigrade addTarget:self action:@selector(setValue:) forControlEvents:UIControlEventTouchUpInside];
            [self.mMenuItemView1.bTimer setTag:0];
            [self.mMenuItemView1.bTimer addTarget:self action:@selector(setTimer:) forControlEvents:UIControlEventTouchUpInside];
            [self.mMenuItemView1 setTag:0];
            [self.mMenuItemView1 setUserInteractionEnabled:YES];
            [self.mMenuItemView1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(frmeChange:)]];
            [self.mMenuItemView1 setHidden:YES];
            [self.scrollFrameView addSubview:self.mMenuItemView1];
        }
        //针2
        if(self.mMenuItemView2==nil){
            self.mMenuItemView2=[[MenuItemView alloc]initWithFrame:CGRectMake1(0, 190, 320, 190)];
            [self.mMenuItemView2 setBaseController:self];
            [self.mMenuItemView2.lblHighestCentigrade setTag:1];
            [self.mMenuItemView2.lblHighestCentigrade addTarget:self action:@selector(setValue:) forControlEvents:UIControlEventTouchUpInside];
            [self.mMenuItemView2.bTimer setTag:1];
            [self.mMenuItemView2.bTimer addTarget:self action:@selector(setTimer:) forControlEvents:UIControlEventTouchUpInside];
            [self.mMenuItemView2 setTag:1];
            [self.mMenuItemView2 setUserInteractionEnabled:YES];
            [self.mMenuItemView2 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(frmeChange:)]];
            [self.mMenuItemView2 setHidden:YES];
            [self.scrollFrameView addSubview:self.mMenuItemView2];
        }
        //针3
        if(self.mMenuItemView3==nil){
            self.mMenuItemView3=[[MenuItemView alloc]initWithFrame:CGRectMake1(0, 380, 320, 190)];
            [self.mMenuItemView3 setBaseController:self];
            [self.mMenuItemView3.lblHighestCentigrade setTag:2];
            [self.mMenuItemView3.lblHighestCentigrade addTarget:self action:@selector(setValue:) forControlEvents:UIControlEventTouchUpInside];
            [self.mMenuItemView3.bTimer setTag:2];
            [self.mMenuItemView3.bTimer addTarget:self action:@selector(setTimer:) forControlEvents:UIControlEventTouchUpInside];
            [self.mMenuItemView3 setTag:2];
            [self.mMenuItemView3 setUserInteractionEnabled:YES];
            [self.mMenuItemView3 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(frmeChange:)]];
            [self.mMenuItemView3 setHidden:YES];
            [self.scrollFrameView addSubview:self.mMenuItemView3];
        }
        //针4
        if(self.mMenuItemView4==nil){
            self.mMenuItemView4=[[MenuItemView alloc]initWithFrame:CGRectMake1(0, 570, 320, 190)];
            [self.mMenuItemView4 setBaseController:self];
            [self.mMenuItemView4.lblHighestCentigrade setTag:3];
            [self.mMenuItemView4.lblHighestCentigrade addTarget:self action:@selector(setValue:) forControlEvents:UIControlEventTouchUpInside];
            [self.mMenuItemView4.bTimer setTag:3];
            [self.mMenuItemView4.bTimer addTarget:self action:@selector(setTimer:) forControlEvents:UIControlEventTouchUpInside];
            [self.mMenuItemView4 setTag:3];
            [self.mMenuItemView4 setUserInteractionEnabled:YES];
            [self.mMenuItemView4 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(frmeChange:)]];
            [self.mMenuItemView4 setHidden:YES];
            [self.scrollFrameView addSubview:self.mMenuItemView4];
        }
        //透明背景
        self.bgFrame=[[UIView alloc]initWithFrame:self.view.bounds];
        [self.bgFrame setBackgroundColor:DEFAULTITLECOLORA(150, 0.5)];
        [self.bgFrame setHidden:YES];
        [self.view addSubview:self.bgFrame];
        //设置视图
        self.mSetTempView=[[SetTempView alloc]initWithFrame:CGRectMake1(10, 100, 300, 200)];
        [self.mSetTempView.cancelButton addTarget:self action:@selector(SetTempCloseCancel) forControlEvents:UIControlEventTouchUpInside];
        [self.mSetTempView.okButton addTarget:self action:@selector(SetTempCloseOK) forControlEvents:UIControlEventTouchUpInside];
        [self.mSetTempView setHidden:YES];
        [self.bgFrame addSubview:self.mSetTempView];
        //时间设置面板
        self.pv1=[[DatePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-CGHeight(260+BOTTOMTABBARHEIGHT), CGWidth(320), CGHeight(260))];
        [self.pv1 setCode:1];
        [self.pv1 setDelegate:self];
        [self.view addSubview:self.pv1];
        //横屏
        self.mMenuItemLandView=[[MenuItemLandView alloc]initWithFrame:CGRectMake(0, 0,CGHeight(455),CGWidth(320))];
        [self.mMenuItemLandView setBaseController:self];
//        [self.mMenuItemLandView.lblHighestCentigrade addTarget:self action:@selector(setValue:) forControlEvents:UIControlEventTouchUpInside];
//        [self.mMenuItemLandView.bTimer addTarget:self action:@selector(setTimer:) forControlEvents:UIControlEventTouchUpInside];
        [self.mMenuItemLandView setUserInteractionEnabled:YES];
        [self.mMenuItemLandView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(frmeHide:)]];
        [self.mMenuItemLandView setHidden:YES];
        [self.view addSubview:self.mMenuItemLandView];
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
    }else{
        [self cTitle:NSLocalizedString(@"BBQ Unconnected",nil)];
    }
}

- (void)back:(id)sender
{
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"Exit",nil), nil];
    [choiceSheet showInView:self.view];
}

- (void)loadData:(NSArray*)array
{
    [self.scrollFrameView setContentSize:CGSizeMake1(320, 190*[array count])];
    self.dataItemArray=[[NSMutableArray alloc]initWithArray:array];
    for(int i=0;i<[array count];i++){
        if(i==0){
            NSDictionary *d1=[array objectAtIndex:0];
            [self.mMenuItemView1 setMenuData:d1];
            [self.mMenuItemView1 setHidden:NO];
        }else if(i==1){
            NSDictionary *d2=[array objectAtIndex:1];
            [self.mMenuItemView2 setMenuData:d2];
            [self.mMenuItemView2 setHidden:NO];
        }else if(i==2){
            NSDictionary *d3=[array objectAtIndex:2];
            [self.mMenuItemView3 setMenuData:d3];
            [self.mMenuItemView3 setHidden:NO];
        }else if(i==3){
            NSDictionary *d4=[array objectAtIndex:3];
            [self.mMenuItemView4 setMenuData:d4];
            [self.mMenuItemView4 setHidden:NO];
        }
    }
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
    NSInteger r=self.mSetTempView.tag;
    NSDictionary *data = [self.dataItemArray objectAtIndex:r];
    for(id key in [data allKeys]){
        NSString *title=[NSString stringWithFormat:@"%@",key];
        int value=self.mSetTempView.mSlider.value;
        [[[Data Instance]sett]setObject:[NSString stringWithFormat:@"%d",value] forKey:key];
        NSString *json=[NSString stringWithFormat:@"{\"sett\":{\"%@\":%d.1}}",title,value];
        [self.appDelegate sendData:json];
    }
    [self.mSetTempView setHidden:YES];
    [self.bgFrame setHidden:YES];
}

- (void)pickerViewDone:(NSInteger)code
{
    if(code==1) {
        NSInteger r=self.pv1.tag;
        NSDictionary *data=[self.dataItemArray objectAtIndex:r];
        for(id key in [data allKeys]){
            NSInteger rowHour=[self.pv1.picker selectedRowInComponent:0];
            NSInteger rowMin=[self.pv1.picker selectedRowInComponent:1];
            NSInteger totalSecond=rowHour*60+rowMin;
            [[[Data Instance]settValue]setObject:[NSString stringWithFormat:@"%ld",totalSecond] forKey:key];
            [self refreshDataView];
            if(r==0){
                [self.mMenuItemView1 setTimerScheduled];
            }else if(r==1){
                [self.mMenuItemView2 setTimerScheduled];
            }else if(r==2){
                [self.mMenuItemView3 setTimerScheduled];
            }else if(r==3){
                [self.mMenuItemView4 setTimerScheduled];
            }
        }
    }
}

- (void)refreshDataView
{
    [self.mMenuItemView1 refreshData];
    [self.mMenuItemView2 refreshData];
    [self.mMenuItemView3 refreshData];
    [self.mMenuItemView4 refreshData];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
        if (self.appDelegate.bleManager.activePeripheral) {
            if(self.appDelegate.bleManager.activePeripheral.state==CBPeripheralStateConnected){
                [[self.appDelegate.bleManager CM] cancelPeripheralConnection:[self.appDelegate.bleManager activePeripheral]];
                [[Data Instance]setAutoConnected:nil];
            }
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)ConnectedState:(BOOL)state
{
    if(state){
        [self cTitle:NSLocalizedString(@"BBQ Connected",nil)];
    }else{
        [self cTitle:NSLocalizedString(@"BBQ Unconnected",nil)];
    }
    [self.scrollFrameView setHidden:!state];
    [self.mConnectedPanel setHidden:state];
}

- (void)frmeChange:(UIGestureRecognizer*)sender
{
    if(inch35){
        return;
    }
//    NSInteger tag=[[sender view]tag];
//    [self.mMenuItemLandView setHidden:NO];
//    CGAffineTransform at =CGAffineTransformMakeRotation(M_PI/2);
//    [self.mMenuItemLandView setTransform:at];
//    [self.mMenuItemLandView setCenter:CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2)];
//    [self.mMenuItemLandView.lblHighestCentigrade setTag:tag];
//    [self.mMenuItemLandView.bTimer setTag:tag];
//    if(tag==0){
//        [self.mMenuItemLandView setMenuData:self.mMenuItemView1.currentData];
//    }else if(tag==1){
//        [self.mMenuItemLandView setMenuData:self.mMenuItemView2.currentData];
//    }else if(tag==2){
//        [self.mMenuItemLandView setMenuData:self.mMenuItemView3.currentData];
//    }else if(tag==3){
//        [self.mMenuItemLandView setMenuData:self.mMenuItemView4.currentData];
//    }
}

- (void)frmeHide:(id)sender
{
    [self.mMenuItemLandView setHidden:YES];
}

@end