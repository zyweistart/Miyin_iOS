//
//  STSignupViewController.m
//  ElectricianRun
//
//  Created by Start on 2/28/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STSignupViewController.h"
#import "STSignupPhotographViewController.h"
#import "CityParser.h"
#import "DataPickerView.h"
#import "ChineseToPinyin.h"

#define  REQUESTCODESUBMITSIGNUP 500

@interface STSignupViewController () <DataPickerViewDelegate>

@end

@implementation STSignupViewController {
    UITextField *txtName;
    UITextField *txtPhone;
    UITextField *txtCard;
    UITextField *txtProvince;
    UITextField *txtCity;
    UITextField *txtCounty;
    CityParser *cityParser;
    DataPickerView *dpvProvince;
    DataPickerView *dpvCity;
    DataPickerView *dpvCounty;
    
    NSMutableArray *dataProvinces;
    NSMutableArray *dataCitys;
    NSMutableArray *dataCountys;
}

- (id)init{
    self = [super init];
    if (self) {
        self.title=@"电工注册";
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (id)initWithPhone:(NSString*)phone{
    self.phone=phone;
    self = [self init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    cityParser=[[CityParser alloc]init];
    [cityParser startParser];
    
    dataProvinces=[[cityParser citys] objectForKey:@"province_item"];
    
    dpvProvince=[[DataPickerView alloc]initWithData:dataProvinces];
    [dpvProvince setDelegate:self];
    
    dpvCity=[[DataPickerView alloc]initWithData:dataCitys];
    [dpvCity setDelegate:self];
    
    dpvCounty=[[DataPickerView alloc]initWithData:dataCountys];
    [dpvCounty setDelegate:self];
    
    UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 64, 320, 330)];
    [control addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:control];
    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 90, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"姓名:"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    txtName=[[UITextField alloc]initWithFrame:CGRectMake(105, 10, 150, 30)];
    [txtName setFont:[UIFont systemFontOfSize: 12.0]];
    [txtName setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtName setBorderStyle:UITextBorderStyleRoundedRect];
    [control addSubview:txtName];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 90, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"手机:"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    txtPhone=[[UITextField alloc]initWithFrame:CGRectMake(105, 50, 150, 30)];
    [txtPhone setFont:[UIFont systemFontOfSize: 12.0]];
    [txtPhone setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtPhone setBorderStyle:UITextBorderStyleRoundedRect];
    [txtPhone setKeyboardType:UIKeyboardTypeNumberPad];
    [txtPhone setText:self.phone];
    [control addSubview:txtPhone];
 
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 90, 90, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"身份证号码:"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    txtCard=[[UITextField alloc]initWithFrame:CGRectMake(105, 90, 150, 30)];
    [txtCard setFont:[UIFont systemFontOfSize: 12.0]];
    [txtCard setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtCard setBorderStyle:UITextBorderStyleRoundedRect];
//    [txtCard setKeyboardType:UIKeyboardTypeNumberPad];
    [control addSubview:txtCard];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 130, 90, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"希望工作地"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 170, 90, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"省份:"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    txtProvince=[[UITextField alloc]initWithFrame:CGRectMake(105, 170, 150, 30)];
    [txtProvince setFont:[UIFont systemFontOfSize: 12.0]];
    [txtProvince setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtProvince setBorderStyle:UITextBorderStyleRoundedRect];
    [txtProvince setInputView:dpvProvince];
    [control addSubview:txtProvince];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 210, 90, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"城市:"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    txtCity=[[UITextField alloc]initWithFrame:CGRectMake(105, 210, 150, 30)];
    [txtCity setFont:[UIFont systemFontOfSize: 12.0]];
    [txtCity setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtCity setBorderStyle:UITextBorderStyleRoundedRect];
    [txtCity setInputView:dpvCity];
    [control addSubview:txtCity];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 250, 90, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"县城镇:"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    txtCounty=[[UITextField alloc]initWithFrame:CGRectMake(105, 250, 150, 30)];
    [txtCounty setFont:[UIFont systemFontOfSize: 12.0]];
    [txtCounty setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtCounty setBorderStyle:UITextBorderStyleRoundedRect];
    [txtCounty setInputView:dpvCounty];
    [control addSubview:txtCounty];
    
    UIButton *btnSubmit=[[UIButton alloc]initWithFrame:CGRectMake(80, 290, 160, 30)];
    [btnSubmit setTitle:@"提交" forState:UIControlStateNormal];
    [btnSubmit setBackgroundColor:BTNCOLORGB];
    [btnSubmit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [control addSubview:btnSubmit];
    
    [txtProvince setText:[dataProvinces objectAtIndex:0]];
    [self change:1];
    
}

- (void)backgroundDoneEditing:(id)sender
{
    [txtName resignFirstResponder];
    [txtPhone resignFirstResponder];
    [txtCard resignFirstResponder];
    [txtProvince resignFirstResponder];
    [txtCity resignFirstResponder];
    [txtCounty resignFirstResponder];
}

- (void)submit:(id)sender
{
    NSString *name=[txtName text];
    if([@"" isEqualToString:name]){
        [Common alert:@"姓名不能为空,请填写"];
        return;
    }
    NSString *phone=[txtPhone text];
    if([@"" isEqualToString:phone]){
        [Common alert:@"手机号码不能为空,请填写"];
        return;
    }
    if([phone length]!=11){
        [Common alert:@"请输入正确的手机号码"];
        return;
    }
    NSString *card=[txtCard text];
    if([@"" isEqualToString:card]){
        [Common alert:@"身份证号不能为空,请填写"];
        return;
    }
    if([card length]!=15&&[card length]!=18){
        [Common alert:@"请输入正确的身份证号码"];
        return;
    }
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:name forKey:@"name"];//姓名
    [p setObject:phone forKey:@"telNum"];//手机号码
    [p setObject:card forKey:@"identityNo"];//身份证号码
    
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:REQUESTCODESUBMITSIGNUP];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest start:URLcheckElecIdent params:p];
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode
{
    if(repCode==REQUESTCODESUBMITSIGNUP){
        NSDictionary *json=[response resultJSON];
        if(json){
            int result=[[[response resultJSON] objectForKey:@"result"]intValue];
            if(result==0){
                NSString *name=[txtName text];
                NSString *phone=[txtPhone text];
                NSString *card=[txtCard text];
                NSString *province=[txtProvince text];
                NSString *city=[txtCity text];
                NSString *county=[txtCounty text];
                STSignupPhotographViewController *signupPhotographViewController=[[STSignupPhotographViewController alloc]init];
                [signupPhotographViewController setName:name];
                [signupPhotographViewController setPhone:phone];
                [signupPhotographViewController setCard:card];
                [signupPhotographViewController setAddress:[NSString stringWithFormat:@"%@%@%@",province,city,county]];
                [signupPhotographViewController setProvince:province];
                [signupPhotographViewController setCity:city];
                [signupPhotographViewController setArea:county];
                [self.navigationController pushViewController:signupPhotographViewController animated:YES];
            }else if(result==1){
                [Common alert:@"电工注册信息已经存在"];
                //已经存在则返回上一页
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [Common alert:[NSString stringWithFormat:@"服务异常，错误代码：%d",result]];
            }
        }
    }
}

- (void)pickerDidPressDoneWithRow:(NSInteger)row {
    if([txtProvince isFirstResponder]){
        NSString *name=[dataProvinces objectAtIndex:row];
        if(![name isEqualToString:[txtProvince text]]){
            [txtProvince setText:name];
            [self change:1];
        }
        [txtProvince resignFirstResponder];
    }
    if([txtCity isFirstResponder]){
        NSString *name=[dataCitys objectAtIndex:row];
        if(![name isEqualToString:[txtCity text]]){
            [txtCity setText:name];
            [self change:2];
        }
        [txtCity resignFirstResponder];
    }
    if([txtCounty isFirstResponder]){
        NSString *name=[dataCountys objectAtIndex:row];
        [txtCounty setText:name];
        [txtCounty resignFirstResponder];
    }
}

- (void)change:(int)v{
    NSString *nameP=[txtProvince text];
    NSString *pinyinP=[[ChineseToPinyin pinyinFromChiniseString:nameP] lowercaseString];
    if(v==1){
        dataCitys=[[cityParser citys]objectForKey:[NSString stringWithFormat:@"%@_province_item",pinyinP]];
        [dpvCity setData:dataCitys];
        if([dataCitys count]>0){
            [txtCity setText:[dataCitys objectAtIndex:0]];
            NSString *nameC=[txtCity text];
            NSString *pinyinC=[[ChineseToPinyin pinyinFromChiniseString:nameC] lowercaseString];
            if([@"市辖区" isEqualToString:nameC]||[@"市辖县" isEqualToString:nameC]){
                pinyinC=[NSString stringWithFormat:@"%@%@",pinyinP,pinyinC];
            }
            dataCountys=[[cityParser citys]objectForKey:[NSString stringWithFormat:@"%@_city_item",pinyinC]];
            [dpvCounty setData:dataCountys];
            if([dataCountys count]>0){
                [txtCounty setText:[dataCountys objectAtIndex:0]];
            }else{
                [txtCounty setText:@""];
            }
        }else{
            [txtCity setText:@""];
            [txtCounty setText:@""];
        }
    }else if(v==2){
        NSString *nameC=[txtCity text];
        NSString *pinyinC=[[ChineseToPinyin pinyinFromChiniseString:nameC] lowercaseString];
        if([@"市辖区" isEqualToString:nameC]||[@"市辖县" isEqualToString:nameC]){
            pinyinC=[NSString stringWithFormat:@"%@%@",pinyinP,pinyinC];
        }
        dataCountys=[[cityParser citys]objectForKey:[NSString stringWithFormat:@"%@_city_item",pinyinC]];
        [dpvCounty setData:dataCountys];
        if([dataCountys count]>0){
            [txtCounty setText:[dataCountys objectAtIndex:0]];
        }else{
            [txtCounty setText:@""];
        }
    }
}

- (void)pickerDidPressCancel{
    if([txtProvince isFirstResponder]){
        [txtProvince resignFirstResponder];
    }
    if([txtCity isFirstResponder]){
        [txtCity resignFirstResponder];
    }
    if([txtCounty isFirstResponder]){
        [txtCounty resignFirstResponder];
    }
}

@end