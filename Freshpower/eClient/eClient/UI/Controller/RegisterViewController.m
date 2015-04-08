//
//  RegisterViewController.m
//  eClient
//  注册
//  Created by Start on 3/20/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "RegisterViewController.h"
#import "SVTextField.h"
#import "SVButton.h"
#import "SVCheckbox.h"
#import "NSString+Utils.h"

#define TITLE1COLOR [UIColor colorWithRed:(150/255.0) green:(150/255.0) blue:(150/255.0) alpha:1]
#define LINECOLOR [UIColor colorWithRed:(41/255.0) green:(129/255.0) blue:(228/255.0) alpha:1]

@interface RegisterViewController ()

@end

@implementation RegisterViewController{
    SVTextField *svUserName;
    SVTextField *svPassword;
    NSString *USERNAME;
    NSString *PASSWORD;
    NSInteger type;
    UIImageView *managerImage,*elecImage;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"注册"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    [scrollFrame setContentSize:CGSizeMake1(320, 330)];
    [self.view addSubview:scrollFrame];
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 40, 320, 330)];
    [scrollFrame addSubview:frame];
    managerImage=[self createHeadTypeSwitch:frame X:52 imageName:@"manager" type:1];
    elecImage=[self createHeadTypeSwitch:frame X:187 imageName:@"elec" type:4];
    svUserName=[[SVTextField alloc]initWithFrame:CGRectMake1(10, 115, 300, 40) Title:@"账号"];
    [svUserName.tf setKeyboardType:UIKeyboardTypePhonePad];
    [frame addSubview:svUserName];
    svPassword=[[SVTextField alloc]initWithFrame:CGRectMake1(10, 165, 200, 40) Title:@"密码"];
    [frame addSubview:svPassword];
    SVButton *bGet=[[SVButton alloc]initWithFrame:CGRectMake1(220, 165, 90, 40) Title:@"获取" Type:2];
    [bGet addTarget:self action:@selector(get:) forControlEvents:UIControlEventTouchUpInside];
    [frame addSubview:bGet];
    SVButton *bLogin=[[SVButton alloc]initWithFrame:CGRectMake1(10, 225, 300, 40) Title:@"注册" Type:2];
    [bLogin addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [frame addSubview:bLogin];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(20,275,280,20)];
    [lbl setText:@"轻触上面的“注册”按钮，即表示你同意"];
    [lbl setTextColor:TITLE1COLOR];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [frame addSubview:lbl];
    lbl=[[UILabel alloc]initWithFrame:CGRectMake1(15, 295, 280, 20)];
    [lbl setText:@"《e电工软件许可及服务协议》"];
    [lbl setTextColor:LINECOLOR];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setUserInteractionEnabled:YES];
    [lbl addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(readMe:)]];
    [frame addSubview:lbl];
    
    type=1;
    [self showHeadImageType];
}

- (void)get:(id)sender
{
    USERNAME=[svUserName.tf text];
    if([@"" isEqualToString:USERNAME]){
        [Common alert:@"请输入手机号码"];
        return;
    }
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"99010199" forKey:@"GNID"];
    [params setObject:USERNAME forKey:@"QTUSER"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:501];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:URL_appUserCenter requestParams:params];
}


- (void)login:(id)sender
{
    USERNAME=[svUserName.tf text];
    PASSWORD=[[[svPassword.tf text] uppercaseString] md5];
    if([@"" isEqualToString:USERNAME]){
        [Common alert:@"请输入手机号码"];
        return;
    }
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"99010101" forKey:@"GNID"];
    [params setObject:USERNAME forKey:@"QTUSER"];
    [params setObject:PASSWORD forKey:@"QTKEY"];
    [params setObject:[NSString stringWithFormat:@"%d",type] forKey:@"QTKEY2"];
    [params setObject:@"" forKey:@"QTVAL"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:502];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:URL_appUserCenter requestParams:params];
}

- (void)readMe:(id)sender
{
    NSLog(@"服务条款");
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if(501==reqCode){
        if([response successFlag]){
            [Common alert:[response msg]];
        }
    }else if(502==reqCode){
        if([response successFlag]){
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (UIImageView*)createHeadTypeSwitch:(UIView*)frame X:(CGFloat)x imageName:(NSString*)imageName type:(NSInteger)t
{
    UIView *vManager=[[UIView alloc]initWithFrame:CGRectMake1(x, 10,83, 83)];
    vManager.layer.cornerRadius = 5;
    vManager.layer.masksToBounds = YES;
    vManager.layer.borderWidth = 1;
    vManager.layer.borderColor = [TITLECOLOR CGColor];
    [vManager setBackgroundColor:[UIColor whiteColor]];
    [frame addSubview:vManager];
    UIImageView *head=[[UIImageView alloc]initWithFrame:CGRectMake1(15, 15, 53, 53)];
    [head setImage:[UIImage imageNamed:imageName]];
    [vManager addSubview:head];
    UIImageView *shead=[[UIImageView alloc]initWithFrame:CGRectMake1(65, 5, 13, 13)];
    [vManager addSubview:shead];
    [vManager setUserInteractionEnabled:YES];
    vManager.tag=t;
    [vManager addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sw:)]];
    return shead;
}

- (void)showHeadImageType
{
    if(type==1) {
        [managerImage setImage:[UIImage imageNamed:@"勾"]];
        [elecImage setImage:[UIImage imageNamed:@"未勾"]];
    }else if(type==4){
        [managerImage setImage:[UIImage imageNamed:@"未勾"]];
        [elecImage setImage:[UIImage imageNamed:@"勾"]];
    }
}

- (void)sw:(UITapGestureRecognizer*)sender
{
    type=[sender.view tag];
    [self showHeadImageType];
}

@end
