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

#define  __SCREEN_WIDTH 320
#define  __SCREEN_HEIGHT 760
#define  NAVIGATION_BAR_HEIGHT 40
@interface PublishRecruitmentViewController ()

@end

@implementation PublishRecruitmentViewController{
    UIScrollView *scrollFrame;
    NSInteger pvv2,pvv4,pvv5,pvv6;
//    NSArray *searchData2,*searchData4,*searchData5,*searchData6;
    UILabel *lblJobName,*lblJobType,*lblJobNumber,*lblJobWage,*lblJobWorkYear,*lblJobMoney;
    UITextView *tvRemark;
    UITextField *tfName,*tfPeopleNum,*tfContact,*tfPhone,*tfEmail,*tfAddress,*tfCompanyName;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"发布招聘"];
        [self.view setBackgroundColor:BGCOLOR];
        scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [scrollFrame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        scrollFrame.contentSize=CGSizeMake1(__SCREEN_WIDTH,__SCREEN_HEIGHT);
        [self.view addSubview:scrollFrame];
        tfName=[self addFrameTypeTextField:10 Title:@"职位名称"];
        lblJobType=[self addFrameType:60 Title:@"职位类别" Name:@"请选择" Tag:2];
        tfCompanyName=[self addFrameTypeTextField:110 Title:@"公司名称"];
        tfPeopleNum=[self addFrameTypeTextField:160 Title:@"招聘人数"];
        [tfPeopleNum setKeyboardType:UIKeyboardTypeNumberPad];
        lblJobWage=[self addFrameType:210 Title:@"学历要求" Name:@"不限" Tag:4];
        lblJobWorkYear=[self addFrameType:260 Title:@"工作年限" Name:@"不限" Tag:5];
        lblJobMoney=[self addFrameType:310 Title:@"每月薪资" Name:@"面议" Tag:6];
        
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0,360,320,140)];
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
        
        tfContact=[self addFrameTypeTextField:510 Title:@"职位联系人"];
        tfPhone=[self addFrameTypeTextField:560 Title:@"联系电话"];
        [tfPhone setKeyboardType:UIKeyboardTypeNumberPad];
        tfEmail=[self addFrameTypeTextField:610 Title:@"简历接收邮箱"];
        tfAddress=[self addFrameTypeTextField:660 Title:@"工作地址"];
        //发布
        ButtonView *button=[[ButtonView alloc]initWithFrame:CGRectMake1(10, 710, 300, 40) Name:@"发布"];
        [button addTarget:self action:@selector(publish:) forControlEvents:UIControlEventTouchUpInside];
        [scrollFrame addSubview:button];
        
        self.pv2=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-CGHeight(260), CGWidth(320), CGHeight(260)) WithArray:[CommonData getJob]];
        [self.pv2 setCode:2];
        [self.pv2 setDelegate:self];
        [self.view addSubview:self.pv2];
        
        self.pv4=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-CGHeight(260), CGWidth(320), CGHeight(260)) WithArray:[CommonData getEducation]];
        [self.pv4 setCode:4];
        [self.pv4 setDelegate:self];
        [self.view addSubview:self.pv4];
        
        self.pv5=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-CGHeight(260), CGWidth(320), CGHeight(260)) WithArray:[CommonData getYears]];
        [self.pv5 setCode:5];
        [self.pv5 setDelegate:self];
        [self.view addSubview:self.pv5];
        
        self.pv6=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-CGHeight(260), CGWidth(320), CGHeight(260)) WithArray:[CommonData getSalary]];
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
    if(code==2){
        pvv2=[self.pv2.picker selectedRowInComponent:0];
        NSDictionary *d=[self.pv2.pickerArray objectAtIndex:pvv2];
        [lblJobType setText:[d objectForKey:MKEY]];
    }else if(code==4){
        pvv4=[self.pv4.picker selectedRowInComponent:0];
        NSDictionary *d=[self.pv4.pickerArray objectAtIndex:pvv4];
        [lblJobWage setText:[d objectForKey:MKEY]];
    }else if(code==5){
        pvv5=[self.pv5.picker selectedRowInComponent:0];
        NSDictionary *d=[self.pv5.pickerArray objectAtIndex:pvv5];
        [lblJobWorkYear setText:[d objectForKey:MKEY]];
    }else if(code==6){
        pvv6=[self.pv6.picker selectedRowInComponent:0];
        NSDictionary *d=[self.pv6.pickerArray objectAtIndex:pvv6];
        [lblJobMoney setText:[d objectForKey:MKEY]];
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
    
    NSDictionary *d2=[self.pv2.pickerArray objectAtIndex:pvv2];
    NSString *pvv2v=[d2 objectForKey:MVALUE];
    NSDictionary *d4=[self.pv4.pickerArray objectAtIndex:pvv4];
    NSString *pvv4v=[d4 objectForKey:MVALUE];
    NSDictionary *d5=[self.pv5.pickerArray objectAtIndex:pvv5];
    NSString *pvv5v=[d5 objectForKey:MVALUE];
    NSDictionary *d6=[self.pv6.pickerArray objectAtIndex:pvv6];
    NSString *pvv6v=[d6 objectForKey:MVALUE];
    
//    NSLog(@"职位名称=%@\n职位类别=%@\n招聘人数=%@\n学历要求=%@\n工作年限=%@\n每月薪资=%@\n任职要求=%@\n联系人=%@\n联系电话=%@\n地址=%@",name,pvv2v,peopleNum,pvv4v,pvv5v,pvv6v,remark,phone,contact,address);
    
    
//    {"work_year":"3","phone":"15906614216","job_category":"1","classId":111,"degree_required":"5","contact_person":"联系人","cName":"公司名称","address":"地址","email":"17855@qq.com","job_title":"标题","hiring":"1","Id":0,"month_salary":"2","access_token":"access_token_984f374857327df90d71f1c0353391e2","job_specification":"要求"}
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]accessToken] forKey:@"access_token"];
    [params setObject:pvv5v forKey:@"work_year"];
    [params setObject:phone forKey:@"phone"];
    [params setObject:pvv2v forKey:@"job_category"];
    [params setObject:@"0" forKey:@"Id"];
    [params setObject:@"111" forKey:@"classId"];
    [params setObject:pvv4v forKey:@"degree_required"];
    [params setObject:contact forKey:@"contact_person"];
    [params setObject:address forKey:@"address"];
    [params setObject:companyName forKey:@"cName"];
    [params setObject:email forKey:@"email"];
    [params setObject:name forKey:@"job_title"];
    [params setObject:peopleNum forKey:@"hiring"];
    [params setObject:pvv6v forKey:@"month_salary"];
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
    [self.pv2 setHidden:tag==2?NO:YES];
    [self.pv4 setHidden:tag==4?NO:YES];
    [self.pv5 setHidden:tag==5?NO:YES];
    [self.pv6 setHidden:tag==6?NO:YES];
}

#pragma mark - UITextViewDelegate UITextFieldDelegate

//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    CGPoint origin = textField.frame.origin;
//    CGPoint point = [textField.superview convertPoint:origin toView:scrollFrame];
//    float navBarHeight = self.navigationController.navigationBar.frame.size.height;
//    CGPoint offset = scrollFrame.contentOffset;
//    offset.y = (point.y - navBarHeight-40);
//    [scrollFrame setContentOffset:offset animated:YES];
//}
//
//- (void)textViewDidBeginEditing:(UITextView *)textView
//{
//    CGPoint origin = textView.frame.origin;
//    CGPoint point = [textView.superview convertPoint:origin toView:scrollFrame];
//    float navBarHeight = self.navigationController.navigationBar.frame.size.height;
//    CGPoint offset = scrollFrame.contentOffset;
//    offset.y = (point.y - navBarHeight-40);
//    [scrollFrame setContentOffset:offset animated:YES];
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField*)textField
//{
//    [textField resignFirstResponder];
//    [scrollFrame setContentOffset:CGPointMake(0, 0) animated:YES];
//    return YES;
//}

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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    scrollFrame.contentSize = CGSizeMake1(__SCREEN_WIDTH,__SCREEN_HEIGHT+216);//原始滑动距离增加键盘高度
    CGPoint pt = [textField convertPoint:CGPointMake(0, 0) toView:scrollFrame];//把当前的textField的坐标映射到scrollview上
    if(scrollFrame.contentOffset.y-pt.y+NAVIGATION_BAR_HEIGHT<=0)//判断最上面不要去滚动
        [scrollFrame setContentOffset:CGPointMake(0, pt.y-NAVIGATION_BAR_HEIGHT) animated:YES];//华东
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    scrollFrame.contentSize = CGSizeMake1(__SCREEN_WIDTH,__SCREEN_HEIGHT+216);//原始滑动距离增加键盘高度
    CGPoint pt = [textView convertPoint:CGPointMake(0, 0) toView:scrollFrame];//把当前的textField的坐标映射到scrollview上
    if(scrollFrame.contentOffset.y-pt.y+NAVIGATION_BAR_HEIGHT<=0)//判断最上面不要去滚动
        [scrollFrame setContentOffset:CGPointMake(0, pt.y-NAVIGATION_BAR_HEIGHT) animated:YES];//华东
}

- (BOOL)textFieldShouldReturn:(UITextField*)theTextField
{
    [theTextField resignFirstResponder];
    //开始动画
    [UIView beginAnimations:nil context:nil];
    //设定动画持续时间
    [UIView setAnimationDuration:0.3];
    scrollFrame.contentSize = CGSizeMake1(__SCREEN_WIDTH,__SCREEN_HEIGHT);
    //动画结束
    [UIView commitAnimations];
    return YES;
}

- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*) text
{
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        //开始动画
        [UIView beginAnimations:nil context:nil];
        //设定动画持续时间
        [UIView setAnimationDuration:0.3];
        scrollFrame.contentSize = CGSizeMake1(__SCREEN_WIDTH,__SCREEN_HEIGHT);
        //动画结束
        [UIView commitAnimations];
        return NO;
    }else{
        return YES;
    }
}

@end