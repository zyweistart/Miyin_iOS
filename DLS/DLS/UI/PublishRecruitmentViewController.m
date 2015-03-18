//
//  PublishRecruitmentViewController.m
//  DLS
//  发布招聘
//  Created by Start on 3/12/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "PublishRecruitmentViewController.h"
#import "ButtonView.h"

#define BGCOLOR [UIColor colorWithRed:(246/255.0) green:(246/255.0) blue:(246/255.0) alpha:1]
#define TITLECOLOR [UIColor colorWithRed:(127/255.0) green:(127/255.0) blue:(127/255.0) alpha:1]

@interface PublishRecruitmentViewController ()

@end

@implementation PublishRecruitmentViewController{
    UIScrollView *scrollFrame;
    NSArray *searchData1,*searchData2,*searchData3,*searchData4,*searchData5,*searchData6;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"发布招聘"];
        [self.view setBackgroundColor:BGCOLOR];
        scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        scrollFrame.contentSize=CGSizeMake(320,800);
        [self.view addSubview:scrollFrame];
        
        [self addFrameType:10 Title:@"职位名称" Name:@"请选择"];
        [self addFrameType:60 Title:@"职位类别" Name:@"请选择"];
        [self addFrameType:110 Title:@"招聘人数" Name:@"1人"];
        [self addFrameType:160 Title:@"学历要求" Name:@"不限"];
        [self addFrameType:210 Title:@"工作年限" Name:@"不限"];
        [self addFrameType:260 Title:@"每月薪资" Name:@"面议"];
        
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0,310,320,140)];
        [frame setBackgroundColor:[UIColor whiteColor]];
        [scrollFrame addSubview:frame];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 100, 40)];
        [lbl setText:@"任职要求"];
        [lbl setTextColor:TITLECOLOR];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [frame addSubview:lbl];
        UITextField *tfContent=[[UITextField alloc]initWithFrame:CGRectMake1(10, 40, 300, 100)];
        [tfContent setTextColor:TITLECOLOR];
        [tfContent setFont:[UIFont systemFontOfSize:14]];
        [tfContent setTextAlignment:NSTextAlignmentRight];
        [frame addSubview:tfContent];
        
        [self addFrameTypeTextField:460 Title:@"职位联系人"];
        [self addFrameTypeTextField:510 Title:@"联系电话"];
        [self addFrameTypeTextField:560 Title:@"简历接收邮箱"];
        [self addFrameTypeTextField:610 Title:@"工作地址"];
        //发布
        ButtonView *button=[[ButtonView alloc]initWithFrame:CGRectMake1(10, 660, 300, 40) Name:@"发布"];
        [button addTarget:self action:@selector(publish:) forControlEvents:UIControlEventTouchUpInside];
        [scrollFrame addSubview:button];
        
        searchData1=[NSArray arrayWithObjects:@"1KM",@"2KM",@"3KM",@"4KM",@"5KM", nil];
        searchData2=[NSArray arrayWithObjects:@"1KM",@"2KM",@"3KM",@"4KM",@"5KM", nil];
        searchData3=[NSArray arrayWithObjects:@"1KM",@"2KM",@"3KM",@"4KM",@"5KM", nil];
        searchData4=[NSArray arrayWithObjects:@"1KM",@"2KM",@"3KM",@"4KM",@"5KM", nil];
        searchData5=[NSArray arrayWithObjects:@"1KM",@"2KM",@"3KM",@"4KM",@"5KM", nil];
        searchData6=[NSArray arrayWithObjects:@"1KM",@"2KM",@"3KM",@"4KM",@"5KM", nil];
        
        self.pv1=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-260, 320, 260) WithArray:searchData1];
        [self.pv1 setDelegate:self];
        [self.view addSubview:self.pv1];
        
        self.pv2=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-260, 320, 260) WithArray:searchData2];
        [self.pv2 setDelegate:self];
        [scrollFrame addSubview:self.pv2];
        
        self.pv3=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-260, 320, 260) WithArray:searchData3];
        [self.pv3 setDelegate:self];
        [scrollFrame addSubview:self.pv3];
        
        self.pv4=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-260, 320, 260) WithArray:searchData4];
        [self.pv4 setDelegate:self];
        [scrollFrame addSubview:self.pv4];
        
        self.pv5=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-260, 320, 260) WithArray:searchData5];
        [self.pv5 setDelegate:self];
        [scrollFrame addSubview:self.pv5];
        
        self.pv6=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-260, 320, 260) WithArray:searchData6];
        [self.pv6 setDelegate:self];
        [scrollFrame addSubview:self.pv6];
    }
    return self;
}

- (void)addFrameType:(CGFloat)y Title:(NSString*)title Name:(NSString*)name
{
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0,y,320,40)];
    [frame setBackgroundColor:[UIColor whiteColor]];
    [scrollFrame addSubview:frame];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 100, 40)];
    [lbl setText:title];
    [lbl setTextColor:TITLECOLOR];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [frame addSubview:lbl];
    UILabel *lblContent=[[UILabel alloc]initWithFrame:CGRectMake1(200, 0, 90, 40)];
    [lblContent setText:name];
    [lblContent setTextColor:TITLECOLOR];
    [lblContent setFont:[UIFont systemFontOfSize:14]];
    [lblContent setTextAlignment:NSTextAlignmentRight];
    [lblContent setUserInteractionEnabled:YES];
    [lblContent addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectorType:)]];
    [frame addSubview:lblContent];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(300, 11, 9, 18)];
    [image setImage:[UIImage imageNamed:@"arrowright"]];
    [frame addSubview:image];
}

- (void)addFrameTypeTextField:(CGFloat)y Title:(NSString*)title
{
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0,y,320,40)];
    [frame setBackgroundColor:[UIColor whiteColor]];
    [scrollFrame addSubview:frame];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 100, 40)];
    [lbl setText:title];
    [lbl setTextColor:TITLECOLOR];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [frame addSubview:lbl];
    UITextField *tfContent=[[UITextField alloc]initWithFrame:CGRectMake1(200, 0, 90, 40)];
    [tfContent setTextColor:TITLECOLOR];
    [tfContent setFont:[UIFont systemFontOfSize:14]];
    [tfContent setTextAlignment:NSTextAlignmentRight];
    [frame addSubview:tfContent];
}

- (void)pickerViewDone:(int)code
{
    
}

- (void)selectorType:(id)sender
{
    if(self.pv1.hidden){
        [self.pv1 showView];
    }else{
        [self.pv1 hiddenView];
    }
    NSLog(@"sectortype");
}

- (void)publish:(id)sender
{
    NSLog(@"发布");
}

@end
