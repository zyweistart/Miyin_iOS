//
//  InspectionSettingViewController.m
//  eClient
//  巡检任务设置
//  Created by weizhenyao on 15/3/23.
//  Copyright (c) 2015年 freshpower. All rights reserved.
//

#import "InspectionSettingViewController.h"
#import "TimeSelectViewController.h"
#import "SVButton.h"
#import "SVCheckbox.h"
#import "SVTextField.h"

#define TITLE1COLOR [UIColor colorWithRed:(140/255.0) green:(140/255.0) blue:(140/255.0) alpha:1]
#define TITLECOLOR [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1]
#define LINECOLOR [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1]

@interface InspectionSettingViewController ()

@end

@implementation InspectionSettingViewController{
    UILabel *lblTimeSelect;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"巡检设置"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScrollView *scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    [scrollFrame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:scrollFrame];
    CGFloat height=0;
    [scrollFrame addSubview:[self addHeadFrame:@"提醒设置" X:0]];
    height=height+30;
    [scrollFrame addSubview:[self addTimeItem:height Title:@"变电站运行记录表"]];
    height=height+155;
    int headCount=4;
    for(int i=0;i<headCount;i++){
        [scrollFrame addSubview:[self addTextFieldItem:height+i*70 Title:@"变电站电气设备日常巡检"]];
    }
    height=height+headCount*70;
    [scrollFrame addSubview:[self addHeadFrame:@"下发设置" X:height]];
    [self addSendSetting:scrollFrame X:height+30];
    height=height+30+115;
    [scrollFrame addSubview:[self addHeadFrame:@"巡检人员设置" X:height]];
    UIButton *settinginfo=[[UIButton alloc]initWithFrame:CGRectMake1(0, height+30, 320, 40)];
    [settinginfo setTitle:@"设置" forState:UIControlStateNormal];
    [settinginfo setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [settinginfo addTarget:self action:@selector(personalSelect:) forControlEvents:UIControlEventTouchUpInside];
    [scrollFrame addSubview:settinginfo];
    height=height+30+40+10;
    SVButton *submit=[[SVButton alloc]initWithFrame:CGRectMake1(10, height, 300, 40) Title:@"提交" Type:2];
    [submit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [scrollFrame addSubview:submit];
    [scrollFrame setContentSize:CGSizeMake1(320, height+40+10)];
}


- (UIView*)addHeadFrame:(NSString*)title X:(CGFloat)x
{
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, x, 320, 30)];
    [frame setBackgroundColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1]];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 5, 320, 20)];
    [lbl setText:title];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [frame addSubview:lbl];
    return frame;
}

- (UIView*)addTimeItem:(CGFloat)x Title:(NSString*)title
{
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, x, 320, 100)];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 5, 300, 20)];
    [lbl setText:title];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setNumberOfLines:0];
    [lbl setTextColor:TITLE1COLOR];
    [frame addSubview:lbl];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 30, 30, 30)];
    [image setImage:[UIImage imageNamed:@"勾"]];
    [frame addSubview:image];
    lbl=[[UILabel alloc]initWithFrame:CGRectMake1(45, 30, 70, 30)];
    [lbl setText:@"按小时提醒"];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextColor:TITLE1COLOR];
    [frame addSubview:lbl];
    lbl=[[UILabel alloc]initWithFrame:CGRectMake1(230, 30, 70, 30)];
    [lbl setText:@"时间段选择"];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextColor:TITLE1COLOR];
    [lbl setUserInteractionEnabled:YES];
    [lbl addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(timeSelect:)]];
    [frame addSubview:lbl];
    lblTimeSelect=[[UILabel alloc]initWithFrame:CGRectMake1(50, 60, 260, 40)];
//    [lbl setText:@"00:00-02:00-04:00-06:00-08:00-10:00-12:00-14:00-16:00-18:00-20:00-22:00"];
    [lblTimeSelect setFont:[UIFont systemFontOfSize:14]];
    [lblTimeSelect setTextColor:TITLE1COLOR];
    [lblTimeSelect setNumberOfLines:0];
    [frame addSubview:lblTimeSelect];
    lbl=[[UILabel alloc]initWithFrame:CGRectMake1(50, 100, 260, 50)];
    [lbl setText:@"时间段8:00~22:00，每间隔2小时提醒一次，且需要提前10分钟提醒 ，如：7：50发出提醒。"];
    [lbl setFont:[UIFont systemFontOfSize:13]];
    [lbl setTextColor:TITLE1COLOR];
    [lbl setNumberOfLines:0];
    [frame addSubview:lbl];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(0, 154, 320, 1)];
    [line setBackgroundColor:LINECOLOR];
    [frame addSubview:line];
    return frame;
}

- (UIView*)addTextFieldItem:(CGFloat)x Title:(NSString*)title
{
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, x, 320, 70)];
    UILabel *lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(10, 5, 300, 20)];
    [lblTitle setText:title];
    [lblTitle setFont:[UIFont systemFontOfSize:14]];
    [lblTitle setNumberOfLines:0];
    [lblTitle setTextColor:TITLE1COLOR];
    [frame addSubview:lblTitle];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 30, 30, 30)];
    [image setImage:[UIImage imageNamed:@"勾"]];
    [frame addSubview:image];
    lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(45, 30, 60, 30)];
    [lblTitle setText:@"按天提醒"];
    [lblTitle setFont:[UIFont systemFontOfSize:14]];
    [lblTitle setTextColor:TITLECOLOR];
    [frame addSubview:lblTitle];
    SVTextField *timeDate=[[SVTextField alloc]initWithFrame:CGRectMake1(110, 30, 100, 30) Title:nil];
    [frame addSubview:timeDate];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(0, 69, 320, 1)];
    [line setBackgroundColor:LINECOLOR];
    [frame addSubview:line];
    return frame;
}

- (void)addSendSetting:(UIView*)frame X:(CGFloat)x
{
    UIView *f=[[UIView alloc]initWithFrame:CGRectMake1(0, x, 320, 115)];
    [frame addSubview:f];
    SVCheckbox *cb1=[[SVCheckbox alloc]initWithFrame:CGRectMake1(0, 5, 100, 30)];
    [cb1 setSelected:YES];
    [[cb1 titleLabel]setFont:[UIFont systemFontOfSize:14]];
    [cb1 setTitle:@"自动下发" forState:UIControlStateNormal];
    [cb1 setTitleColor:TITLECOLOR forState:UIControlStateNormal];
    [cb1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [f addSubview:cb1];
    SVCheckbox *cb2=[[SVCheckbox alloc]initWithFrame:CGRectMake1(110, 5, 100, 30)];
    [[cb2 titleLabel]setFont:[UIFont systemFontOfSize:14]];
    [cb2 setTitle:@"手动下发" forState:UIControlStateNormal];
    [cb2 setTitleColor:TITLECOLOR forState:UIControlStateNormal];
    [cb2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [f addSubview:cb2];
    UILabel *lblDescription=[[UILabel alloc]initWithFrame:CGRectMake1(10, 40, 300, 70)];
    [lblDescription setText:@"您可以选择适合您的下发方式：1、自动下发：巡检比较频繁且有规律时选择。如每天需要下发巡检任务。2、手动下发：巡检不频繁且无规律时选择。如每周巡检一次或每月巡检几次。"];
    [lblDescription setFont:[UIFont systemFontOfSize:13]];
    [lblDescription setNumberOfLines:0];
    [lblDescription setTextColor:TITLECOLOR];
    [f addSubview:lblDescription];
}

- (void)timeSelect:(id)sender
{
    [self.navigationController pushViewController:[[TimeSelectViewController alloc]init] animated:YES];
}

- (void)personalSelect:(id)sender
{
    [self.navigationController pushViewController:[[TimeSelectViewController alloc]init] animated:YES];
}

- (void)submit:(id)sender
{
    NSLog(@"提交");
}

@end
