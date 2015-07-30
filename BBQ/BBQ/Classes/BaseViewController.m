#import "BaseViewController.h"
#ifndef TEST
#endif

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)init{
    self=[super init];
    if(self){
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.appDelegate = [[UIApplication sharedApplication] delegate];
        
        self.mConnectedPanel=[[UIView alloc]initWithFrame:self.view.bounds];
        [self.mConnectedPanel setBackgroundColor:DEFAULTITLECOLORA(150, 0.5)];
        UILabel *lblMessage=[[UILabel alloc]initWithFrame:CGRectMake1(0, 200, 320, 60)];
        [lblMessage setText:@"Connection is broken"];
        [lblMessage setFont:[UIFont systemFontOfSize:35]];
        [lblMessage setTextAlignment:NSTextAlignmentCenter];
        [lblMessage setTextColor:[UIColor whiteColor]];
        [lblMessage setBackgroundColor:DEFAULTITLECOLORA(50, 0.5)];
        [self.mConnectedPanel addSubview:lblMessage];
        [self.view addSubview:self.mConnectedPanel];
        [self.mConnectedPanel setHidden:YES];
    }
    return self;
}

- (id)initWithData:(NSDictionary*)data
{
    self=[self init];
    if(self){
        self.data=data;
    }
    return self;
}

- (void)cTitle:(NSString*)title
{
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 80, 30)];
    [lbl setText:title];
    [lbl setFont:[UIFont systemFontOfSize:20]];
    [lbl setTextColor:[UIColor whiteColor]];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView=lbl;
}

- (void)viewDidLoad
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    [super viewDidLoad];
}

- (void)goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onControllerResult:(NSInteger)resultCode data:(NSMutableDictionary*)result
{
    
}

//- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
//{
//    if([response successFlag]){
//        
//    }
//}
//
//- (void)requestFailed:(int)reqCode
//{
//    NSLog(@"网络请求失败");
//}

@end
