//
//  STPurchaseCalculateViewController.m
//  ElectricianRun
//
//  Created by Start on 3/4/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STPurchaseCalculateViewController.h"

@interface STPurchaseCalculateViewController ()

@end

@implementation STPurchaseCalculateViewController {
    UITextField *txtValue1;
    UITextField *txtValue2;
    UITextField *txtValue3;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title=@"在线报价单";
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(back:)];
        
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"购买"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(buy:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 100, 320, 220)];
    [control addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:control];
    //配电房数量(A)
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"配电房数量(A)"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    txtValue1=[[UITextField alloc]initWithFrame:CGRectMake(125, 10, 150, 30)];
    [txtValue1 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValue1 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValue1 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValue1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValue1 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValue1 setKeyboardType:UIKeyboardTypeNumberPad];
    [control addSubview:txtValue1];
    //监测回路(B)
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 50, 100, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"监测回路(B)"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    txtValue2=[[UITextField alloc]initWithFrame:CGRectMake(125, 50, 150, 30)];
    [txtValue2 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValue2 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValue2 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValue2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValue2 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValue2 setKeyboardType:UIKeyboardTypeNumberPad];
    [control addSubview:txtValue2];
    //价格
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 90, 60, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"价格"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    txtValue3=[[UITextField alloc]initWithFrame:CGRectMake(125, 90, 150, 30)];
    [txtValue3 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValue3 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValue3 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValue3 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValue3 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValue3 setKeyboardType:UIKeyboardTypeNumberPad];
    [txtValue3 setEnabled:NO];
    [control addSubview:txtValue3];
    //生成报价单
    UIButton *btnCalculate=[[UIButton alloc]initWithFrame:CGRectMake(110, 140, 100, 30)];
    [btnCalculate setTitle:@"生成报价单" forState:UIControlStateNormal];
    btnCalculate.titleLabel.font=[UIFont systemFontOfSize: 12.0];
    [btnCalculate setBackgroundColor:[UIColor colorWithRed:(55/255.0) green:(55/255.0) blue:(139/255.0) alpha:1]];
    [btnCalculate addTarget:self action:@selector(cal:) forControlEvents:UIControlEventTouchUpInside];
    [control addSubview:btnCalculate];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 180, 250, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"报价说明：双拼出线回路以2个监测回路计算。"];
    [lbl setTextColor:[UIColor redColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
}

- (void)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cal:(id)sender
{
    NSString *A=[txtValue1 text];
    NSString *B=[txtValue2 text];
    if(![@"" isEqualToString:A]&&![@"" isEqualToString:B]){
        double a=[A doubleValue];//配电房数量
        double b=[B doubleValue];//监测回路数
        double v;
        if((b-a*6)<0) {
            v = 10000*a;//价格
        } else {
            v = 10000*a+(b-a*6)*500;//价格
        }
        [txtValue3 setText:[NSString stringWithFormat:@"%.2f",v]];
    }
}

- (void)buy:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:PAYURL]];
}

- (void)backgroundDoneEditing:(id)sender
{
    [txtValue1 resignFirstResponder];
    [txtValue2 resignFirstResponder];
    [txtValue3 resignFirstResponder];
}

@end
