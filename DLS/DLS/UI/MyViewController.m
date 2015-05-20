//
//  MyViewController.m
//  DLS
//
//  Created by Start on 3/2/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "MyViewController.h"
#import "MyCZViewController.h"
#import "MyQZViewController.h"
#import "MySBXSViewController.h"
#import "MySBWXViewController.h"
#import "MyBJXSViewController.h"
#import "MyZPXXViewController.h"
#import "MyQZYPViewController.h"
#import "MyHelpCenterViewController.h"
#import "CustomerServiceViewController.h"

#import "SettingViewController.h"
#import "CollectionViewController.h"
#import "AccountViewController.h"
#import "IntegralViewController.h"
#import "MessageViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

#import "UIButton+TitleImage.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define LOGINREGISTERBGCOLOR [UIColor colorWithRed:(58/255.0) green:(117/255.0) blue:(207/255.0) alpha:0.5]
#define LINEBGCOLOR [UIColor colorWithRed:(167/255.0) green:(183/255.0) blue:(216/255.0) alpha:0.5]

static CGFloat kImageOriginHight = 220.f;

@interface MyViewController ()

@end

@implementation MyViewController{
    UIView *topFrame;
    UIView *personalFrame;
    UIView *bLoginRegister;
    UIButton *bHead;
    UIButton *bSign;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"我的"];
        self.dataItemArray=[[NSMutableArray alloc]init];
        
        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"我的出租",@"我的求租", nil]];
        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"招聘信息",@"求职信息", nil]];
//        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"我的出租",@"我的求租",@"设备销售",@"设备维修",@"配件销售",@"VIP工程", nil]];
//        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"招聘信息",@"我的求职", nil]];
        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"帮助中心",@"客服中心", nil]];

        self.tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.view addSubview:self.tableView];
        
        self.expandZoomImageView=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 0, 320, kImageOriginHight)];
        self.expandZoomImageView.userInteractionEnabled=YES;
        [self.expandZoomImageView setImage:[UIImage imageNamed:@"personalbg"]];
        self.tableView.contentInset = UIEdgeInsetsMake(CGHeight(kImageOriginHight), 0, 0, 0);
        [self.tableView addSubview:self.expandZoomImageView];
        
        //设置
        UIButton *btnSetting = [[UIButton alloc]initWithFrame:CGRectMake1(270, 20, 40, 40)];
        [btnSetting setImage:[UIImage imageNamed:@"setting"]forState:UIControlStateNormal];
        [btnSetting addTarget:self action:@selector(goSetting:) forControlEvents:UIControlEventTouchUpInside];
        [self.expandZoomImageView addSubview:btnSetting];
        
        personalFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, kImageOriginHight-170, 320, 160)];
        [self.expandZoomImageView addSubview:personalFrame];
        bLoginRegister=[[UIView alloc]initWithFrame:CGRectMake1(110, 40, 100, 30)];
        [bLoginRegister setBackgroundColor:LOGINREGISTERBGCOLOR];
        bLoginRegister.layer.cornerRadius = 2;
        bLoginRegister.layer.masksToBounds = YES;
        [personalFrame addSubview:bLoginRegister];
        //登陆
        UIButton *bLogin=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 49, 30)];
        [bLogin setTitle:@"登陆" forState:UIControlStateNormal];
        [bLogin.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bLogin.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [bLogin addTarget:self action:@selector(goLogin:) forControlEvents:UIControlEventTouchUpInside];
        [bLoginRegister addSubview:bLogin];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(49, 5, 1, 20)];
        [line setBackgroundColor:LINEBGCOLOR];
        [bLoginRegister addSubview:line];
        //注册
        UIButton *bRegister=[[UIButton alloc]initWithFrame:CGRectMake1(50, 0, 50, 30)];
        [bRegister setTitle:@"注册" forState:UIControlStateNormal];
        [bRegister.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bRegister.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [bRegister addTarget:self action:@selector(goRegister:) forControlEvents:UIControlEventTouchUpInside];
        [bLoginRegister addSubview:bRegister];
        //头像
        bHead=[[UIButton alloc]initWithFrame:CGRectMake1(120, 0, 80, 80)];
        [bHead.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bHead addTarget:self action:@selector(goPersonalInfo:) forControlEvents:UIControlEventTouchUpInside];
        [personalFrame addSubview:bHead];
        //签到
        bSign=[[UIButton alloc]initWithFrame:CGRectMake1(110, 90, 100, 20)];
        bSign.layer.cornerRadius = 10;
        bSign.layer.masksToBounds = YES;
        bSign.layer.borderWidth=1;
        bSign.layer.borderColor= [[UIColor whiteColor]CGColor];
        [bSign setTitle:@"每日签到" forState:UIControlStateNormal];
        [bSign.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [bSign setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bSign addTarget:self action:@selector(sign:) forControlEvents:UIControlEventTouchUpInside];
        [personalFrame addSubview:bSign];
        //底部功能
        UIView *bottomFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 120, 320, 40)];
        [personalFrame addSubview:bottomFrame];
        UIButton *bCollection=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 79, 40)];
        [bCollection setTitle:@"收藏" forImage:[UIImage imageNamed:@"collection"]];
        [bCollection addTarget:self action:@selector(goCollection:) forControlEvents:UIControlEventTouchUpInside];
        [bottomFrame addSubview:bCollection];
        UIButton *bAccount=[[UIButton alloc]initWithFrame:CGRectMake1(80, 0, 79, 40)];
        [bAccount setTitle:@"账号" forImage:[UIImage imageNamed:@"account"]];
        [bAccount addTarget:self action:@selector(goAccount:) forControlEvents:UIControlEventTouchUpInside];
        [bottomFrame addSubview:bAccount];
        UIButton *bIntegral=[[UIButton alloc]initWithFrame:CGRectMake1(160, 0, 80, 40)];
        [bIntegral setTitle:@"积分" forImage:[UIImage imageNamed:@"integral"]];
        [bIntegral addTarget:self action:@selector(goIntegral:) forControlEvents:UIControlEventTouchUpInside];
        [bottomFrame addSubview:bIntegral];
        UIButton *bMessage=[[UIButton alloc]initWithFrame:CGRectMake1(240, 0, 80, 40)];
        [bMessage setTitle:@"消息" forImage:[UIImage imageNamed:@"message"]];
        [bMessage addTarget:self action:@selector(goMessage:) forControlEvents:UIControlEventTouchUpInside];
        [bottomFrame addSubview:bMessage];
        //竖线
        UIView *line1=[[UIView alloc]initWithFrame:CGRectMake1(79, 0, 1, 40)];
        [line1 setBackgroundColor:LINEBGCOLOR];
        [bottomFrame addSubview:line1];
        UIView *line2=[[UIView alloc]initWithFrame:CGRectMake1(159, 0, 1, 40)];
        [line2 setBackgroundColor:LINEBGCOLOR];
        [bottomFrame addSubview:line2];
        UIView *line3=[[UIView alloc]initWithFrame:CGRectMake1(239, 0, 1, 40)];
        [line3 setBackgroundColor:LINEBGCOLOR];
        [bottomFrame addSubview:line3];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.expandZoomImageView.frame = CGRectMake(0, -CGHeight(kImageOriginHight), self.tableView.frame.size.width, CGHeight(kImageOriginHight));
    
    [self showUser];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < -CGHeight(kImageOriginHight)) {
        CGRect f = self.expandZoomImageView.frame;
        f.origin.y = yOffset;
        f.size.height =  -yOffset;
        self.expandZoomImageView.frame = f;
        [personalFrame setFrame:CGRectMake(0, f.size.height-CGHeight(170), CGWidth(320), CGHeight(160))];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataItemArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataItemArray objectAtIndex:section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGHeight(10);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGHeight(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGHeight(45);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CMainCell = @"CMainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CMainCell];
    }
    NSString *content=[[self.dataItemArray objectAtIndex:[indexPath section]]objectAtIndex:[indexPath row]];
    [cell.imageView setImage:[UIImage imageNamed:content]];
    cell.textLabel.text = content;
    if(!([indexPath section]==2&&[indexPath row]==1)){
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    if(section==0){
        if(![[User Instance]isLogin]){
            [self presentViewControllerNav:[[LoginViewController alloc]init]];
            return;
        }
        if(row==0){
            [self presentViewControllerNav:[[MyCZViewController alloc]init]];
        }else if(row==1){
            [self presentViewControllerNav:[[MyQZViewController alloc]init]];
        }
    }else if(section==1){
        if(![[User Instance]isLogin]){
            [self presentViewControllerNav:[[LoginViewController alloc]init]];
            return;
        }
        if(row==0){
            [self presentViewControllerNav:[[MyZPXXViewController alloc]init]];
        }else if(row==1){
            [self presentViewControllerNav:[[MyQZYPViewController alloc]init]];
        }
    }else{
        if(row==0){
             [self presentViewControllerNav:[[MyHelpCenterViewController alloc]init]];
        }else if(row==1){
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"tel://%@",@"057187071527"]]];
            [self presentViewControllerNav:[[CustomerServiceViewController alloc]init]];
        }
    }
}

- (void)goSetting:(id)sender
{
    if(![[User Instance]isLogin]){
        [self presentViewControllerNav:[[LoginViewController alloc]init]];
        return;
    }
    [self presentViewControllerNav:[[SettingViewController alloc]init]];
}

- (void)goLogin:(id)sender
{
    [self presentViewControllerNav:[[LoginViewController alloc]init]];
}

- (void)goRegister:(id)sender
{
    [self presentViewControllerNav:[[RegisterViewController alloc]init]];
}

- (void)goCollection:(id)sender
{
    if(![[User Instance]isLogin]){
        [self presentViewControllerNav:[[LoginViewController alloc]init]];
        return;
    }
    [self presentViewControllerNav:[[CollectionViewController alloc]init]];
}

- (void)goAccount:(id)sender
{
    if(![[User Instance]isLogin]){
        [self presentViewControllerNav:[[LoginViewController alloc]init]];
        return;
    }
    [self presentViewControllerNav:[[AccountViewController alloc]init]];
}

- (void)goIntegral:(id)sender
{
    if(![[User Instance]isLogin]){
        [self presentViewControllerNav:[[LoginViewController alloc]init]];
        return;
    }
    [self presentViewControllerNav:[[IntegralViewController alloc]init]];
}

- (void)goMessage:(id)sender
{
    if(![[User Instance]isLogin]){
        [self presentViewControllerNav:[[LoginViewController alloc]init]];
        return;
    }
    [self presentViewControllerNav:[[MessageViewController alloc]init]];
}

- (void)onControllerResult:(NSInteger)resultCode data:(NSMutableDictionary*)result
{
    if(resultCode==RESULTCODE_LOGIN){
        [self showUser];
    }
}

- (void)showUser
{
    if([[User Instance]isLogin]){
        [bHead setHidden:NO];
        [bSign setHidden:NO];
        NSString *name=[Common getString:[[[User Instance]resultData] objectForKey:@"Name"]];
//        NSString *headImage=[[[User Instance]resultData] objectForKey:@"HeadImage"];
//        NSString *imageUrl=[NSString stringWithFormat:@"%@%@",HTTP_URL,headImage];
//        UIImageView *iv=[[UIImageView alloc]init];
//        [iv setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"头像"]];
//        [bHead setTitle:name forImage:[iv image]];
        [bHead setTitle:name forImage:[UIImage imageNamed:@"头像"]];
        [bLoginRegister setHidden:YES];
        NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
        NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage) object:nil];
        [operationQueue addOperation:op];
    }else{
        [bHead setHidden:YES];
        [bSign setHidden:YES];
        [bLoginRegister setHidden:NO];
    }
}

-(void)sign:(id)sender
{
    if([[User Instance]isLogin]){
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:[[User Instance]accessToken] forKey:@"access_token"];
        self.hRequest=[[HttpRequest alloc]init];
        [self.hRequest setRequestCode:500];
        [self.hRequest setDelegate:self];
        [self.hRequest setController:self];
        [self.hRequest setIsShowMessage:YES];
        [self.hRequest handle:@"UserSignIn" requestParams:params];
    }
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        [bSign setTitle:@"今日已签到" forState:UIControlStateNormal];
        [bSign setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        bSign.layer.borderColor= [[UIColor grayColor]CGColor];
        [bSign setEnabled:NO];
        [Common alert:[response msg]];
    }
}

- (void)goPersonalInfo:(id)sender
{
    if(![[User Instance]isLogin]){
        [self presentViewControllerNav:[[LoginViewController alloc]init]];
        return;
    }
    [self presentViewControllerNav:[[AccountViewController alloc]init]];
}

- (void)downloadImage
{
//    NSString *name=[Common getString:[[[User Instance]resultData] objectForKey:@"Name"]];
//    NSString *HeadImage=[[[User Instance]resultData] objectForKey:@"HeadImage"];
//    if(![@"" isEqualToString:HeadImage]){
//        NSString *URL=[NSString stringWithFormat:@"%@%@",HTTP_URL,HeadImage];
//        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:URL]]];
//        [bHead setTitle:name forImage:image];
//    }
}

@end
