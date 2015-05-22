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
    
    UILabel *lblSex,*lblJobWage;
    UITextField *tfTitle,*tfName,*tfAge,*tfPhone,*tfResion,*tfHistory;
    UITextView *tvRemark;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"发布求职"];
        [self.view setBackgroundColor:BGCOLOR];
        scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [scrollFrame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        scrollFrame.contentSize=CGSizeMake1(320,600);
        [self.view addSubview:scrollFrame];
        tfTitle=[self addFrameTypeTextField:10 Title:@"标题"];
        tfName=[self addFrameTypeTextField:60 Title:@"姓名"];
        tfAge=[self addFrameTypeTextField:110 Title:@"年龄"];
        [tfAge setKeyboardType:UIKeyboardTypeNumberPad];
        lblSex=[self addFrameType:160 Title:@"性别" Name:@"请选择" Tag:1];
        tfPhone=[self addFrameTypeTextField:210 Title:@"手机号码"];
        [tfPhone setKeyboardType:UIKeyboardTypeNumberPad];
        lblJobWage=[self addFrameType:260 Title:@"职位类型" Name:@"请选择" Tag:2];
        tfResion=[self addFrameTypeTextField:310 Title:@"期望地区"];
        tfHistory=[self addFrameTypeTextField:360 Title:@"工作经历"];
        
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0,410,320,140)];
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
        ButtonView *button=[[ButtonView alloc]initWithFrame:CGRectMake1(10, 560, 300, 40) Name:@"发布"];
        [button addTarget:self action:@selector(publish:) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollFrame addSubview:button];
        
        self.pv1=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-CGHeight(260), CGWidth(320), CGHeight(260)) WithArray:[CommonData getSex]];
        [self.pv1 setCode:1];
        [self.pv1 setDelegate:self];
        [self.view addSubview:self.pv1];
        
        self.pv2=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-CGHeight(260), CGWidth(320), CGHeight(260)) WithArray:[CommonData getJob]];
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
        [lblSex setText:[d objectForKey:MKEY]];
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
    
    NSString *title=[tfTitle text];
    NSString *name=[tfName text];
    NSString *age=[tfAge text];
    NSString *phone=[tfPhone text];
    NSString *resion=[tfResion text];
    NSString *history=[tfHistory text];
    NSString *remark=[tvRemark text];
    
    NSDictionary *d1=[self.pv1.pickerArray objectAtIndex:pvv1];
    NSString *pvv1v=[d1 objectForKey:MVALUE];
    NSDictionary *d2=[self.pv2.pickerArray objectAtIndex:pvv2];
    NSString *pvv2v=[d2 objectForKey:MVALUE];
    
//    NSLog(@"名称=%@\n年龄=%@\n电话=%@\n地区=%@\n工作经历=%@\n自我描述=%@\n性别=%@\n类型=%@",name,age,phone,resion,history,remark,pvv1v,pvv2v);
    //    {"work_year":"3","phone":"15906614216","job_category":"1","classId":111,"degree_required":"5","contact_person":"联系人","cName":"公司名称","address":"地址","email":"17855@qq.com","job_title":"标题","hiring":"1","Id":0,"month_salary":"2","access_token":"access_token_984f374857327df90d71f1c0353391e2","job_specification":"要求"}
//    {content='安了, sex=1, title=123, phone=13588713117, job_category=2, classId=171, address=杭州, monthlypay=, age=52, Id=0, experience=刺激了, contact=芭比, access_token=access_token_93afc5c208eadfcf006cc7bdee403ef5}
    
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]accessToken] forKey:@"access_token"];
    [params setObject:@"0" forKey:@"Id"];
    [params setObject:@"171" forKey:@"classId"];
    [params setObject:title forKey:@"title"];
    [params setObject:name forKey:@"contact"];
    [params setObject:history forKey:@"experience"];
    [params setObject:age forKey:@"age"];
    [params setObject:resion forKey:@"address"];
    [params setObject:pvv2v forKey:@"job_category"];
    [params setObject:phone forKey:@"phone"];
    [params setObject:pvv1v forKey:@"sex"];
    [params setObject:remark forKey:@"content"];
//    [params setObject:@"" forKey:@"monthlypay"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:@"SaveForm" requestParams:params];
}

- (void)showPickerView:(NSInteger)tag
{
    [self.pv1 setHidden:tag==1?NO:YES];
    [self.pv2 setHidden:tag==2?NO:YES];
}

- (void)hideKeyBoard
{
    [tfName resignFirstResponder];
    [tfAge resignFirstResponder];
    [tfPhone resignFirstResponder];
    [tfResion resignFirstResponder];
    [tfHistory resignFirstResponder];
    [tvRemark resignFirstResponder];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        [Common alert:@"发布成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#define  __SCREEN_WIDTH 320
#define  __SCREEN_HEIGHT 600
#define  NAVIGATION_BAR_HEIGHT 40
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    scrollFrame.contentSize = CGSizeMake1(__SCREEN_WIDTH,__SCREEN_HEIGHT+216);//原始滑动距离增加键盘高度
    CGPoint pt = [textField convertPoint:CGPointMake(0, 0) toView:scrollFrame];//把当前的textField的坐标映射到scrollview上
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

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    scrollFrame.contentSize = CGSizeMake1(__SCREEN_WIDTH,__SCREEN_HEIGHT+216);//原始滑动距离增加键盘高度
    CGPoint pt = [textView convertPoint:CGPointMake(0, 0) toView:scrollFrame];//把当前的textField的坐标映射到scrollview上
    if(scrollFrame.contentOffset.y-pt.y+NAVIGATION_BAR_HEIGHT<=0)//判断最上面不要去滚动
        [scrollFrame setContentOffset:CGPointMake(0, pt.y-NAVIGATION_BAR_HEIGHT) animated:YES];//华东
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
