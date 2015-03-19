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
    NSInteger pvv1,pvv2,pvv3,pvv4,pvv5,pvv6;
    NSArray *searchData1,*searchData2,*searchData3,*searchData4,*searchData5,*searchData6;
    UILabel *lblJobName,*lblJobType,*lblJobNumber,*lblJobWage,*lblJobWorkYear,*lblJobMoney;
    UITextView *tvRemark;
    UITextField *tfContact,*tfPhone,*tfEmail,*tfAddress;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"发布招聘"];
        [self.view setBackgroundColor:BGCOLOR];
        scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [scrollFrame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        scrollFrame.contentSize=CGSizeMake(320,1500);
        [self.view addSubview:scrollFrame];
        
        lblJobName=[self addFrameType:10 Title:@"职位名称" Name:@"请选择" Tag:1];
        lblJobType=[self addFrameType:60 Title:@"职位类别" Name:@"请选择" Tag:2];
        lblJobNumber=[self addFrameType:110 Title:@"招聘人数" Name:@"1人" Tag:3];
        lblJobWage=[self addFrameType:160 Title:@"学历要求" Name:@"不限" Tag:4];
        lblJobWorkYear=[self addFrameType:210 Title:@"工作年限" Name:@"不限" Tag:5];
        lblJobMoney=[self addFrameType:260 Title:@"每月薪资" Name:@"面议" Tag:6];
        
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0,310,320,140)];
        [frame setBackgroundColor:[UIColor whiteColor]];
        [scrollFrame addSubview:frame];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 100, 30)];
        [lbl setText:@"任职要求"];
        [lbl setTextColor:TITLECOLOR];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [frame addSubview:lbl];
        tvRemark=[[UITextView alloc]initWithFrame:CGRectMake1(10, 30, 300, 105)];
        [tvRemark setTextColor:TITLECOLOR];
        [tvRemark setDelegate:self];
        [tvRemark setFont:[UIFont systemFontOfSize:14]];
        [frame addSubview:tvRemark];
        
        tfContact=[self addFrameTypeTextField:460 Title:@"职位联系人"];
        tfPhone=[self addFrameTypeTextField:510 Title:@"联系电话"];
        tfEmail=[self addFrameTypeTextField:560 Title:@"简历接收邮箱"];
        tfAddress=[self addFrameTypeTextField:610 Title:@"工作地址"];
        //发布
        ButtonView *button=[[ButtonView alloc]initWithFrame:CGRectMake1(10, 660, 300, 40) Name:@"发布"];
        [button addTarget:self action:@selector(publish:) forControlEvents:UIControlEventTouchUpInside];
        [scrollFrame addSubview:button];
        
        searchData1=[NSArray arrayWithObjects:@"1KM",@"2KM",@"3KM",@"4KM",@"5KM", nil];
        searchData2=[NSArray arrayWithObjects:@"2KM",@"2KM",@"3KM",@"4KM",@"5KM", nil];
        searchData3=[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"若干", nil];
        searchData4=[NSArray arrayWithObjects:@"小学",@"高中",@"大专",@"本科",@"硕士",@"博士",@"不限", nil];
        searchData5=[NSArray arrayWithObjects:@"1年~2年",@"2年~3年",@"3年以上",@"不限", nil];
        searchData6=[NSArray arrayWithObjects:@"6KM",@"2KM",@"3KM",@"4KM",@"面试", nil];
        
        self.pv1=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-260, 320, 260) WithArray:searchData1];
        [self.pv1 setCode:1];
        [self.pv1 setDelegate:self];
        [self.view addSubview:self.pv1];
        
        self.pv2=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-260, 320, 260) WithArray:searchData2];
        [self.pv2 setCode:2];
        [self.pv2 setDelegate:self];
        [self.view addSubview:self.pv2];
        
        self.pv3=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-260, 320, 260) WithArray:searchData3];
        [self.pv3 setCode:3];
        [self.pv3 setDelegate:self];
        [self.view addSubview:self.pv3];
        
        self.pv4=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-260, 320, 260) WithArray:searchData4];
        [self.pv4 setCode:4];
        [self.pv4 setDelegate:self];
        [self.view addSubview:self.pv4];
        
        self.pv5=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-260, 320, 260) WithArray:searchData5];
        [self.pv5 setCode:5];
        [self.pv5 setDelegate:self];
        [self.view addSubview:self.pv5];
        
        self.pv6=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-260, 320, 260) WithArray:searchData6];
        [self.pv6 setCode:6];
        [self.pv6 setDelegate:self];
        [self.view addSubview:self.pv6];
    }
    return self;
}

- (UILabel*)addFrameType:(CGFloat)y Title:(NSString*)title Name:(NSString*)name Tag:(NSInteger)tag
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
    [lblContent setTag:tag];
    [lblContent addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectorType:)]];
    [frame addSubview:lblContent];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(300, 11, 9, 18)];
    [image setImage:[UIImage imageNamed:@"arrowright"]];
    [frame addSubview:image];
    return lblContent;
}

- (UITextField*)addFrameTypeTextField:(CGFloat)y Title:(NSString*)title
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
    UITextField *tfContent=[[UITextField alloc]initWithFrame:CGRectMake1(150, 0, 140, 40)];
    [tfContent setDelegate:self];
    [tfContent setTextColor:TITLECOLOR];
    [tfContent setFont:[UIFont systemFontOfSize:14]];
    [tfContent setTextAlignment:NSTextAlignmentRight];
    [frame addSubview:tfContent];
    return tfContent;
}

- (void)pickerViewDone:(int)code
{
    if(code==1){
        pvv1=[self.pv1.picker selectedRowInComponent:0];
        NSString *value=[self.pv1.pickerArray objectAtIndex:pvv1];
        [lblJobName setText:value];
    }else if(code==2){
        pvv2=[self.pv2.picker selectedRowInComponent:0];
        NSString *value=[self.pv2.pickerArray objectAtIndex:pvv2];
        [lblJobType setText:value];
    }else if(code==3){
        pvv3=[self.pv3.picker selectedRowInComponent:0];
        NSString *value=[self.pv3.pickerArray objectAtIndex:pvv3];
        [lblJobNumber setText:value];
    }else if(code==4){
        pvv4=[self.pv4.picker selectedRowInComponent:0];
        NSString *value=[self.pv4.pickerArray objectAtIndex:pvv4];
        [lblJobWage setText:value];
    }else if(code==5){
        pvv5=[self.pv5.picker selectedRowInComponent:0];
        NSString *value=[self.pv5.pickerArray objectAtIndex:pvv5];
        [lblJobWorkYear setText:value];
    }else if(code==6){
        pvv6=[self.pv6.picker selectedRowInComponent:0];
        NSString *value=[self.pv6.pickerArray objectAtIndex:pvv6];
        [lblJobMoney setText:value];
    }
}

- (void)selectorType:(UITapGestureRecognizer*)sender
{
    [self hideKeyBoard];
    NSInteger tag=[sender.view tag];
    [self showPickerView:tag];
}

- (void)publish:(id)sender
{
    [self hideKeyBoard];
    NSString *remark=[tvRemark text];
    NSString *phone=[tfPhone text];
    NSString *contact=[tfContact text];
    NSString *address=[tfAddress text];
    NSLog(@"pvv1=%d\npvv2=%d\npvv3=%d\npvv4=%d\npvv5=%d\npvv5=%d\nremark=%@\nphone=%@\ncontact=%@\naddress=%@",pvv1,pvv2,pvv3,pvv4,pvv5,pvv6,remark,phone,contact,address);
}

- (void)showPickerView:(NSInteger)tag
{
    [self.pv1 setHidden:tag==1?NO:YES];
    [self.pv2 setHidden:tag==2?NO:YES];
    [self.pv3 setHidden:tag==3?NO:YES];
    [self.pv4 setHidden:tag==4?NO:YES];
    [self.pv5 setHidden:tag==5?NO:YES];
    [self.pv6 setHidden:tag==6?NO:YES];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*) text
{
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)hideKeyBoard
{
    [tvRemark resignFirstResponder];
    [tfPhone resignFirstResponder];
    [tfContact resignFirstResponder];
    [tfAddress resignFirstResponder];
    [tfEmail resignFirstResponder];
}

@end