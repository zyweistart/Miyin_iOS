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

@implementation HomeViewController{
    BOOL isAddFlag;
    NSInteger currentZoomTag;
}

- (id)init
{
    self=[super init];
    if(self){
        currentZoomTag=-1;
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
            self.mMenuItemView1=[self createMenuItemViewWithY:0 Tag:0];
        }
        //针2
        if(self.mMenuItemView2==nil){
            self.mMenuItemView2=[self createMenuItemViewWithY:190 Tag:1];
        }
        //针3
        if(self.mMenuItemView3==nil){
            self.mMenuItemView3=[self createMenuItemViewWithY:380 Tag:2];
        }
        //针4
        if(self.mMenuItemView4==nil){
            self.mMenuItemView4=[self createMenuItemViewWithY:570 Tag:3];
        }
        //横屏
        self.mMenuItemLandView=[[MenuItemLandView alloc]initWithFrame:CGRectMake(0, 0,CGWidth(448)*self.appDelegate.autoSizeScaleY,CGWidth(266)*self.appDelegate.autoSizeScaleX)];
        [self.mMenuItemLandView setBaseController:self];
        [self.mMenuItemLandView.lblHighestCentigrade addTarget:self action:@selector(setZoomValue:) forControlEvents:UIControlEventTouchUpInside];
        [self.mMenuItemLandView.bTimer addTarget:self action:@selector(setZoomTimer:) forControlEvents:UIControlEventTouchUpInside];
        [self.mMenuItemLandView setUserInteractionEnabled:YES];
        [self.mMenuItemLandView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(frmeHide:)]];
        [self.mMenuItemLandView setHidden:YES];
        
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
        [self.bgFrame addSubview:self.pv1];
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
        [self cTitle:LOCALIZATION(@"BBQ Unconnected")];
    }
    if(!isAddFlag){
        [[[Data Instance]mTabBarFrameViewController].view insertSubview:self.mMenuItemLandView atIndex:2];
        isAddFlag=YES;
    }
}

- (void)back:(id)sender
{
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:LOCALIZATION(@"Cancel")
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:LOCALIZATION(@"Exit"), nil];
    [choiceSheet showInView:self.view];
}

- (void)loadData:(NSArray*)array
{
    if([array count]==0){
        [self.scrollFrameView setHidden:YES];
        [self.mConnectedPanel setHidden:NO];
        [self.lblMessage setText:LOCALIZATION(@"Plase insert probes")];
        return;
    }
    [self.scrollFrameView setContentSize:CGSizeMake1(320, 190*[array count])];
    self.dataItemArray=[[NSMutableArray alloc]initWithArray:array];
    for(int i=0;i<[array count];i++){
        if(i==0){
            NSDictionary *d1=[array objectAtIndex:0];
            [self.mMenuItemView1 setMenuData:d1];
            [self.mMenuItemView1 setHidden:NO];
            if(currentZoomTag==i){
                [self.mMenuItemLandView setMenuData:d1];
            }
        }else if(i==1){
            NSDictionary *d2=[array objectAtIndex:1];
            [self.mMenuItemView2 setMenuData:d2];
            [self.mMenuItemView2 setHidden:NO];
            if(currentZoomTag==i){
                [self.mMenuItemLandView setMenuData:d2];
            }
        }else if(i==2){
            NSDictionary *d3=[array objectAtIndex:2];
            [self.mMenuItemView3 setMenuData:d3];
            [self.mMenuItemView3 setHidden:NO];
            if(currentZoomTag==i){
                [self.mMenuItemLandView setMenuData:d3];
            }
        }else if(i==3){
            NSDictionary *d4=[array objectAtIndex:3];
            [self.mMenuItemView4 setMenuData:d4];
            [self.mMenuItemView4 setHidden:NO];
            if(currentZoomTag==i){
                [self.mMenuItemLandView setMenuData:d4];
            }
        }
    }
}

- (void)setZoomValue:(UIButton*)sender
{
    [self.mMenuItemLandView setHidden:YES];
    [self setValue:sender];
}

- (void)setValue:(UIButton*)sender
{
    NSDictionary *data = [self.dataItemArray objectAtIndex:sender.tag];
    for(id key in [data allKeys]){
        NSString *title=[NSString stringWithFormat:@"%@",key];
        NSString *value=[[[Data Instance] sett] objectForKey:title];
        [self.mSetTempView setData:data];
        [self.mSetTempView setTag:sender.tag];
        [self SetTempShowWithTitle:title Value:[value intValue]];
    }
}

- (void)setZoomTimer:(UIButton*)sender
{
    [self.mMenuItemLandView setHidden:YES];
    [self setTimer:sender];
}

- (void)setTimer:(UIButton*)sender
{
    [self.bgFrame setHidden:NO];
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
    if(currentZoomTag>=0){
        [self.mMenuItemLandView setHidden:NO];
    }
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
    [self.bgFrame setHidden:YES];
    [self.mSetTempView setHidden:YES];
    [self refreshDataView];
    if(currentZoomTag>=0){
        [self.mMenuItemLandView setHidden:NO];
    }
}

- (void)pickerViewDone:(NSInteger)code
{
    [self.bgFrame setHidden:YES];
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
            [self.mMenuItemLandView setTimerScheduled];
        }
        if(currentZoomTag>=0){
            [self.mMenuItemLandView setHidden:NO];
        }
    }
}

- (void)pickerViewCancel:(NSInteger)code
{
    [self.bgFrame setHidden:YES];
    if(code==1) {
        NSInteger r=self.pv1.tag;
        NSDictionary *data=[self.dataItemArray objectAtIndex:r];
        for(id key in [data allKeys]){
            [[[Data Instance]settValue]setObject:@"0" forKey:key];
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
            [self.mMenuItemLandView setTimerScheduled];
        }
        if(currentZoomTag>=0){
            [self.mMenuItemLandView setHidden:NO];
        }
    }
}

- (void)refreshDataView
{
    [self.mSetTempView reLoadData];
    [self.mMenuItemView1 refreshData];
    [self.mMenuItemView2 refreshData];
    [self.mMenuItemView3 refreshData];
    [self.mMenuItemView4 refreshData];
    [self.mMenuItemLandView refreshData];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
        if (self.appDelegate.bleManager.activePeripheral) {
            if(self.appDelegate.bleManager.activePeripheral.state==CBPeripheralStateConnected){
                [[self.appDelegate.bleManager CM] cancelPeripheralConnection:[self.appDelegate.bleManager activePeripheral]];
                self.appDelegate.bleManager.activePeripheral = nil;
                [[Data Instance]setAutoConnected:nil];
            }
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)ConnectedState:(BOOL)state
{
    if(state){
        [self cTitle:LOCALIZATION(@"BBQ Connected")];
    }else{
        [self cTitle:LOCALIZATION(@"BBQ Unconnected")];
    }
    [self.scrollFrameView setHidden:!state];
    [self.mConnectedPanel setHidden:state];
    [self.lblMessage setText:LOCALIZATION(@"Connection is broken")];
}

- (void)frmeChange:(UIGestureRecognizer*)sender
{
    NSInteger tag=[[sender view]tag];
    currentZoomTag=tag;
    [self.mMenuItemLandView setHidden:NO];
    CGAffineTransform at =CGAffineTransformMakeRotation(M_PI/2);
    [self.mMenuItemLandView setTransform:at];
    CGFloat width=[[Data Instance]mTabBarFrameViewController].view.bounds.size.width;
    CGFloat height=[[Data Instance]mTabBarFrameViewController].view.bounds.size.height;
    [self.mMenuItemLandView setCenter:CGPointMake(width/2,height/2)];
    [self.mMenuItemLandView.bTimer setTag:tag];
    [self.mMenuItemLandView.lblHighestCentigrade setTag:tag];
    if(tag==0){
        [self.mMenuItemLandView setMenuData:self.mMenuItemView1.currentData];
    }else if(tag==1){
        [self.mMenuItemLandView setMenuData:self.mMenuItemView2.currentData];
    }else if(tag==2){
        [self.mMenuItemLandView setMenuData:self.mMenuItemView3.currentData];
    }else if(tag==3){
        [self.mMenuItemLandView setMenuData:self.mMenuItemView4.currentData];
    }
}

- (void)frmeHide:(id)sender
{
    currentZoomTag=-1;
    [self.mMenuItemLandView setHidden:YES];
}

- (MenuItemView*)createMenuItemViewWithY:(CGFloat)y Tag:(NSInteger)tag
{
    MenuItemView *mMenuItemView=[[MenuItemView alloc]initWithFrame:CGRectMake1(0, y, 320, 190)];
    [mMenuItemView setBaseController:self];
    [mMenuItemView.lblHighestCentigrade setTag:tag];
    [mMenuItemView.lblHighestCentigrade addTarget:self action:@selector(setValue:) forControlEvents:UIControlEventTouchUpInside];
    [mMenuItemView.bTimer setTag:tag];
    [mMenuItemView.bTimer addTarget:self action:@selector(setTimer:) forControlEvents:UIControlEventTouchUpInside];
    [mMenuItemView setTag:tag];
    [mMenuItemView setUserInteractionEnabled:YES];
    [mMenuItemView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(frmeChange:)]];
    [mMenuItemView setHidden:YES];
    [self.scrollFrameView addSubview:mMenuItemView];
    return mMenuItemView;
}

- (void)changeLanguageText
{
    [self setTitle:LOCALIZATION(@"Home")];
    [self.mMenuItemView1 setLanguage];
    [self.mMenuItemView2 setLanguage];
    [self.mMenuItemView3 setLanguage];
    [self.mMenuItemView4 setLanguage];
    [self.mMenuItemLandView setLanguage];
    [self.mSetTempView setLanguage];
}

@end