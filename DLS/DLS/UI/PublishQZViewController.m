//
//  PublishQZViewController.m
//  DLS
//  发布求职
//  Created by Start on 5/18/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "PublishQZViewController.h"
#import "ButtonView.h"

#define BGCOLOR [UIColor colorWithRed:(246/255.0) green:(246/255.0) blue:(246/255.0) alpha:1]
#define TITLECOLOR [UIColor colorWithRed:(127/255.0) green:(127/255.0) blue:(127/255.0) alpha:1]

@interface PublishQZViewController ()

@end

@implementation PublishQZViewController{
    UIScrollView *scrollFrame;
    NSInteger pvv1,pvv2;
    NSArray *searchData1,*searchData2;
    
    UILabel *lblJobName,*lblJobType,*lblJobNumber,*lblJobWage,*lblJobWorkYear,*lblJobMoney;
    UITextView *tvRemark;
    UITextField *tfName,*tfPeopleNum,*tfContact,*tfPhone,*tfEmail,*tfAddress,*tfCompanyName;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"发布求职"];
        [self.view setBackgroundColor:BGCOLOR];
        scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [scrollFrame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        scrollFrame.contentSize=CGSizeMake(320,560);
        [self.view addSubview:scrollFrame];
        tfName=[self addFrameTypeTextField:10 Title:@"姓名"];
        [self addFrameTypeTextField:60 Title:@"年龄"];
        [self addFrameTypeTextField:110 Title:@"性别"];
        tfPeopleNum=[self addFrameTypeTextField:160 Title:@"手机号码"];
        [tfPeopleNum setKeyboardType:UIKeyboardTypeNumberPad];
        lblJobWage=[self addFrameType:210 Title:@"职位类型" Name:@"请选择职位类别" Tag:4];
        tfPeopleNum=[self addFrameTypeTextField:260 Title:@"期望地区"];
        tfPeopleNum=[self addFrameTypeTextField:310 Title:@"工作经历"];
        
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0,360,320,140)];
        [frame setBackgroundColor:[UIColor whiteColor]];
        [scrollFrame addSubview:frame];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 100, 30)];
        [lbl setText:@"自我描述"];
        [lbl setTextColor:TITLECOLOR];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [frame addSubview:lbl];
        tvRemark=[[UITextView alloc]initWithFrame:CGRectMake1(10, 30, 300, 105)];
        [tvRemark setTextColor:TITLECOLOR];
        [tvRemark setDelegate:self];
        [tvRemark setFont:[UIFont systemFontOfSize:14]];
        [frame addSubview:tvRemark];
        //发布
        ButtonView *button=[[ButtonView alloc]initWithFrame:CGRectMake1(10, 510, 300, 40) Name:@"发布"];
        [button addTarget:self action:@selector(publish:) forControlEvents:UIControlEventTouchUpInside];
        [scrollFrame addSubview:button];
        
        searchData1=[NSArray arrayWithObjects:
                     [NSDictionary dictionaryWithObjectsAndKeys:@"教师",MKEY,@"1",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"技术员",MKEY,@"2",MVALUE, nil], nil];
        searchData2=[NSArray arrayWithObjects:
                     [NSDictionary dictionaryWithObjectsAndKeys:@"男",MKEY,@"0",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"女",MKEY,@"1",MVALUE, nil], nil];
        
        self.pv1=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-260, 320, 260) WithArray:searchData1];
        [self.pv1 setCode:1];
        [self.pv1 setDelegate:self];
        [self.view addSubview:self.pv1];
        
        self.pv2=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-260, 320, 260) WithArray:searchData2];
        [self.pv2 setCode:2];
        [self.pv2 setDelegate:self];
        [self.view addSubview:self.pv2];
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
        NSDictionary *d=[self.pv1.pickerArray objectAtIndex:pvv1];
        [lblJobType setText:[d objectForKey:MKEY]];
    }else if(code==2){
        pvv2=[self.pv2.picker selectedRowInComponent:0];
        NSDictionary *d=[self.pv2.pickerArray objectAtIndex:pvv2];
        [lblJobWage setText:[d objectForKey:MKEY]];
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
    NSString *name=[tfName text];
    NSString *peopleNum=[tfPeopleNum text];
    NSString *remark=[tvRemark text];
    NSString *phone=[tfPhone text];
    NSString *contact=[tfContact text];
    NSString *address=[tfAddress text];
    NSString *email=[tfEmail text];
    NSString *companyName=[tfCompanyName text];
    
    NSDictionary *d1=[self.pv1.pickerArray objectAtIndex:pvv1];
    NSString *pvv1v=[d1 objectForKey:MKEY];
    NSDictionary *d2=[self.pv2.pickerArray objectAtIndex:pvv2];
    NSString *pvv2v=[d2 objectForKey:MKEY];
    
    //    NSLog(@"职位名称=%@\n职位类别=%@\n招聘人数=%@\n学历要求=%@\n工作年限=%@\n每月薪资=%@\n任职要求=%@\n联系人=%@\n联系电话=%@\n地址=%@",name,pvv2v,peopleNum,pvv4v,pvv5v,pvv6v,remark,phone,contact,address);
    
    
    //    {"work_year":"3","phone":"15906614216","job_category":"1","classId":111,"degree_required":"5","contact_person":"联系人","cName":"公司名称","address":"地址","email":"17855@qq.com","job_title":"标题","hiring":"1","Id":0,"month_salary":"2","access_token":"access_token_984f374857327df90d71f1c0353391e2","job_specification":"要求"}
    
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]accessToken] forKey:@"access_token"];
    [params setObject:pvv1v forKey:@"work_year"];
    [params setObject:phone forKey:@"phone"];
    [params setObject:pvv2v forKey:@"job_category"];
    [params setObject:@"0" forKey:@"Id"];
    [params setObject:@"111" forKey:@"classId"];
    [params setObject:contact forKey:@"contact_person"];
    [params setObject:address forKey:@"address"];
    [params setObject:companyName forKey:@"cName"];
    [params setObject:email forKey:@"email"];
    [params setObject:name forKey:@"job_title"];
    [params setObject:peopleNum forKey:@"hiring"];
    [params setObject:remark forKey:@"job_specification"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:@"SaveForm" requestParams:params];
}

- (void)showPickerView:(NSInteger)tag
{
    [self.pv1 setHidden:tag==2?NO:YES];
    [self.pv2 setHidden:tag==4?NO:YES];
}

#pragma mark - UITextViewDelegate UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGPoint origin = textField.frame.origin;
    CGPoint point = [textField.superview convertPoint:origin toView:scrollFrame];
    float navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGPoint offset = scrollFrame.contentOffset;
    offset.y = (point.y - navBarHeight-40);
    [scrollFrame setContentOffset:offset animated:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    CGPoint origin = textView.frame.origin;
    CGPoint point = [textView.superview convertPoint:origin toView:scrollFrame];
    float navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGPoint offset = scrollFrame.contentOffset;
    offset.y = (point.y - navBarHeight-40);
    [scrollFrame setContentOffset:offset animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    [scrollFrame setContentOffset:CGPointMake(0, 0) animated:YES];
    return YES;
}

- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*) text
{
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        [scrollFrame setContentOffset:CGPointMake(0, 0) animated:YES];
        return NO;
    }else{
        return YES;
    }
}

- (void)hideKeyBoard
{
    [tfName resignFirstResponder];
    [tfPeopleNum resignFirstResponder];
    [tfCompanyName resignFirstResponder];
    [tvRemark resignFirstResponder];
    [tfPhone resignFirstResponder];
    [tfContact resignFirstResponder];
    [tfAddress resignFirstResponder];
    [tfEmail resignFirstResponder];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        [Common alert:@"发布成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
