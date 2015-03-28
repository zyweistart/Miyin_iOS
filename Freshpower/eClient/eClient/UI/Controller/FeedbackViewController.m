//
//  FeedbackViewController.m
//  eClient
//
//  Created by Start on 3/29/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "FeedbackViewController.h"
#import "SVButton.h"
#import "SVTextField.h"
#import "SVTextView.h"
#import "SVCheckbox.h"

#define TITLE1COLOR [UIColor colorWithRed:(150/255.0) green:(150/255.0) blue:(150/255.0) alpha:1]

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController{
    UIScrollView *scrollFrame;
    SVCheckbox *cb1,*cb2,*cb3,*cb4,*cb5,*cb6,*cb7,*cb8,*cb9,*cb10,*cb11,*cb12;
    SVTextField *svName,*svPhone;
    SVTextView *tvContent;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"电工神器"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    [scrollFrame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [scrollFrame setContentSize:CGSizeMake1(320, 610)];
    [scrollFrame setUserInteractionEnabled:YES];
    [scrollFrame addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundDoneEditing:)]];
    [self.view addSubview:scrollFrame];
    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 300, 60)];
    [lbl setText:@"    尊敬的顾客，如您想进一步了解产品报价或其他信息，可在下方留下您的联系方式，我们的业务人员将为您进行专业的解答。"];
    [lbl setTextColor:TITLECOLOR];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setNumberOfLines:0];
    [scrollFrame addSubview:lbl];
    lbl=[[UILabel alloc]initWithFrame:CGRectMake1(20, 75, 100, 20)];
    [lbl setText:@"您感兴趣的"];
    [lbl setTextColor:TITLE1COLOR];
    [lbl setFont:[UIFont systemFontOfSize:17]];
    [scrollFrame addSubview:lbl];
    
    cb1=[self addCheckBox:scrollFrame Title:@"我要加盟" X:0 Y:100];
    cb2=[self addCheckBox:scrollFrame Title:@"人工维保服务" X:160 Y:100];
    cb3=[self addCheckBox:scrollFrame Title:@"白云运维服务" X:0 Y:140];
    cb4=[self addCheckBox:scrollFrame Title:@"变电站巡检服务" X:160 Y:140];
    cb5=[self addCheckBox:scrollFrame Title:@"白云监测服务" X:0 Y:180];
    cb6=[self addCheckBox:scrollFrame Title:@"变电站维保服务" X:160 Y:180];
    cb7=[self addCheckBox:scrollFrame Title:@"白云报警服务" X:0 Y:220];
    cb8=[self addCheckBox:scrollFrame Title:@"变电站24小时值守服务" X:160 Y:220];
    cb9=[self addCheckBox:scrollFrame Title:@"彩云监测服务" X:0 Y:260];
    cb10=[self addCheckBox:scrollFrame Title:@"彩云运维服务" X:160 Y:260];
    cb11=[self addCheckBox:scrollFrame Title:@"人工巡检服务" X:0 Y:300];
    cb12=[self addCheckBox:scrollFrame Title:@"彩云集团服务" X:160 Y:300];
    
    svName=[[SVTextField alloc]initWithFrame:CGRectMake1(20, 350, 280, 40) Title:@"姓名"];
    [svName.tf setDelegate:self];
    [scrollFrame addSubview:svName];
    svPhone=[[SVTextField alloc]initWithFrame:CGRectMake1(20, 400, 280, 40) Title:@"号码"];
    [svPhone.tf setDelegate:self];
    [scrollFrame addSubview:svPhone];
    tvContent=[[SVTextView alloc]initWithFrame:CGRectMake1(20, 450, 280, 100) Title:@"留言"];
    [tvContent.tf setDelegate:self];
    [scrollFrame addSubview:tvContent];
    
    SVButton *svSubmit=[[SVButton alloc]initWithFrame:CGRectMake1(20, 560, 280, 40) Title:@"提交" Type:2];
    [svSubmit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [scrollFrame addSubview:svSubmit];
    
    [cb1 setSelected:YES];
}

- (SVCheckbox*)addCheckBox:(UIView*)frame Title:(NSString*)title X:(CGFloat)x Y:(CGFloat)y
{
    UIView *f=[[UIView alloc]initWithFrame:CGRectMake1(x, y, 160, 40)];
    [frame addSubview:f];
    SVCheckbox *cb=[[SVCheckbox alloc]initWithFrame:CGRectMake1(10, 0, 40, 40)];
    [f addSubview:cb];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(50, 0, 110, 40)];
    [lbl setText:title];
    [lbl setTextColor:TITLECOLOR];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setNumberOfLines:0];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [f addSubview:lbl];
    return cb;
}

- (void)submit:(id)sender
{
    NSLog(@"提交");
}

- (void)backgroundDoneEditing:(id)sender {
    [svName.tf resignFirstResponder];
    [svPhone.tf resignFirstResponder];
    [tvContent.tf resignFirstResponder];
}

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

@end
