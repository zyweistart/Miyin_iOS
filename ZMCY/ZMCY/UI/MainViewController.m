#import "MainViewController.h"
#import "NewsDetailViewController.h"
#import "ResourceViewController.h"
#import "MarketViewController.h"
#import "ChiLibraryViewController.h"
#import "AppViewController.h"
#import "MemberViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"照明产业"];
        UIButton *bScreening = [[UIButton alloc]init];
        [bScreening setFrame:CGRectMake1(0, 0, 30, 30)];
        [bScreening setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
        [bScreening addTarget:self action:@selector(goCategory:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                target:nil action:nil];
        negativeSpacerRight.width = -10;
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacerRight, [[UIBarButtonItem alloc] initWithCustomView:bScreening], nil];
        
        self.bgFrame=[[UIView alloc]initWithFrame:self.view.bounds];
        [self.bgFrame setBackgroundColor:DEFAULTITLECOLORA(100,0.5)];
        [self.bgFrame setUserInteractionEnabled:YES];
        [self.bgFrame addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goScreening)]];
        [self.view addSubview:self.bgFrame];
        [self.bgFrame setHidden:YES];
        //筛选
        UIView *leftViewFrame=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CGWidth(140),self.view.bounds.size.height)];
        [leftViewFrame setBackgroundColor:[UIColor whiteColor]];
        [self.bgFrame addSubview:leftViewFrame];
        //功能
        self.button1=[self createLeftButtonWithTitle:@"资讯" WithX:0 Tag:1];
        [leftViewFrame addSubview:self.button1];
        self.button2=[self createLeftButtonWithTitle:@"资源" WithX:40 Tag:2];
        [leftViewFrame addSubview:self.button2];
        self.button3=[self createLeftButtonWithTitle:@"市场" WithX:80 Tag:3];
        [leftViewFrame addSubview:self.button3];
        self.button4=[self createLeftButtonWithTitle:@"智库" WithX:120 Tag:4];
        [leftViewFrame addSubview:self.button4];
        self.button5=[self createLeftButtonWithTitle:@"应用" WithX:160 Tag:5];
        [leftViewFrame addSubview:self.button5];
        self.button6=[self createLeftButtonWithTitle:@"会员" WithX:200 Tag:6];
        [leftViewFrame addSubview:self.button6];
        [self.button1 setBackgroundColor:DEFAULTITLECOLOR(240)];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        NSInteger row=[indexPath row];
        NSDictionary *data=[self.dataItemArray objectAtIndex:row];
        NSString *key=[data objectForKey:@"key"];
        if([@"banner" isEqualToString:key]){
        }else if([@"advert" isEqualToString:key]){
        }else{
            [self.navigationController pushViewController:[[NewsDetailViewController alloc]initWithData:data] animated:YES];
        }
    }
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"3" forKey:@"Id"];
    [params setObject:[NSString stringWithFormat:@"%ld",[self currentPage]] forKey:@"index"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setRequestCode:500];
    [self.hRequest handle:@"GetListALL" requestParams:params];
}

- (void)requestFinishedByRequestCode:(NSInteger)reqCode Path:(NSString*)path Object:(id)sender
{
    if(reqCode==500){
        UIImageView *imageView=(UIImageView*)sender;
        if(imageView){
            UIImage *image=[[UIImage alloc] initWithContentsOfFile:path];
            if(image){
                [imageView setImage:image];
            }
        }
    }
}

- (void)goCategory:(id)sender
{
    [self goScreening];
}

- (void)goScreening
{
    [self.bgFrame setHidden:![self.bgFrame isHidden]];
}

- (void)goFunc:(UIButton*)sender
{
    [self.button1 setBackgroundColor:[UIColor whiteColor]];
    [self.button2 setBackgroundColor:[UIColor whiteColor]];
    [self.button3 setBackgroundColor:[UIColor whiteColor]];
    [self.button4 setBackgroundColor:[UIColor whiteColor]];
    [self.button5 setBackgroundColor:[UIColor whiteColor]];
    [self.button6 setBackgroundColor:[UIColor whiteColor]];
    [sender setBackgroundColor:DEFAULTITLECOLOR(240)];
    if(sender.tag==1){
        [self.bgFrame setHidden:YES];
    }else if(sender.tag==2){
        [self.navigationController pushViewController:[[ResourceViewController alloc]init] animated:YES];
    }else if(sender.tag==3){
        [self.navigationController pushViewController:[[MarketViewController alloc]init] animated:YES];
    }else if(sender.tag==4){
        [self.navigationController pushViewController:[[ChiLibraryViewController alloc]init] animated:YES];
    }else if(sender.tag==5){
        [self.navigationController pushViewController:[[AppViewController alloc]init] animated:YES];
    }else if(sender.tag==6){
        [self.navigationController pushViewController:[[MemberViewController alloc]init] animated:YES];
    }
}

- (UIButton*)createLeftButtonWithTitle:(NSString*)title WithX:(CGFloat)x Tag:(NSInteger)tag;
{
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake1(0, x, 140, 40)];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [button setTitleColor:DEFAULTITLECOLOR(150) forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"求职信息"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"求职信息"] forState:UIControlStateHighlighted];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, CGWidth(-40), 0, 0)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, CGWidth(-50), 0, 0)];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTag:tag];
    [button addTarget:self action:@selector(goFunc:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end