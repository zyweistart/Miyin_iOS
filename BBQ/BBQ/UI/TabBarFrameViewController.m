#import "TabBarFrameViewController.h"
#import "Tools.h"

@interface TabBarFrameViewController ()

@end

@implementation TabBarFrameViewController{
    //接收到的数据
    NSMutableString *receiveSBString;
}

- (id)init
{
    self=[super init];
    if(self){
        
        //初始化默认配置
        if([@"" isEqualToString:[[Data Instance]getCf]]){
            [[Data Instance]setCf:@"c"];
        }
        if([@"" isEqualToString:[[Data Instance]getAlarm]]){
            [[Data Instance]setAlarm:@"Beep1"];
        }
        if([@"" isEqualToString:[[Data Instance]getLanguage]]){
            [[Data Instance]setLanguage:@"English"];;
        }
        receiveSBString=[NSMutableString new];
        //设置消息通知
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver: self
               selector: @selector(ValueChangText:)
                   name: NOTIFICATION_VALUECHANGUPDATE
                 object: nil];
        //开始接收消息
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate.bleManager notification:0xFFE0 characteristicUUID:0xFFE4 p:appDelegate.bleManager.activePeripheral on:YES];
        
        self.bgFrame=[[UIView alloc]initWithFrame:self.view.bounds];
        [self.bgFrame setBackgroundColor:DEFAULTITLECOLORA(150, 0.5)];
        [self.bgFrame setHidden:YES];
        [self.view addSubview:self.bgFrame];
        
        self.mAlertView=[[AlertView alloc]initWithFrame:CGRectMake1(10, 100, 300, 180)];
        [self.mAlertView.button addTarget:self action:@selector(AlertClose) forControlEvents:UIControlEventTouchUpInside];
        [self.mAlertView setHidden:YES];
        [self.bgFrame addSubview:self.mAlertView];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mHomeViewController=[[HomeViewController alloc]init];
    self.mTimerViewController=[[TimerViewController alloc]init];
    self.mSettingViewController=[[SettingViewController alloc]init];
    self.mInfoViewController=[[InfoViewController alloc]init];
    self.viewControllers = [NSArray arrayWithObjects:
                            [self viewControllerWithTabTitle:@"Home" image:@"icon-nav-home" ViewController:self.mHomeViewController],
                            [self viewControllerWithTabTitle:@"Timer" image:@"icon-nav-timer" ViewController:self.mTimerViewController],
                            [self viewControllerWithTabTitle:@"Setting" image:@"icon-nav-setting" ViewController:self.mSettingViewController],
                            [self viewControllerWithTabTitle:@"Info" image:@"icon-nav-info" ViewController:self.mInfoViewController], nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_VALUECHANGUPDATE object:nil];
}

- (UINavigationController*)viewControllerWithTabTitle:(NSString*) title image:(NSString*)image ViewController:(UIViewController*)viewController
{
    UINavigationController *frameViewControllerNav=[[UINavigationController alloc]initWithRootViewController:viewController];
//    [[frameViewControllerNav navigationBar]setBarTintColor:NAVBG];
//    [[frameViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
    UITabBarItem *tabBarItem=[[UITabBarItem alloc]init];
    [tabBarItem setTitle:title];
    if(image){
        [tabBarItem setImage:[UIImage imageNamed:image]];
        [tabBarItem setSelectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",image]]];
    }
    frameViewControllerNav.tabBarItem = tabBarItem;
    return frameViewControllerNav;
}

//这里取出刚刚从过来的字符串
- (void)ValueChangText:(NSNotification *)notification
{
    CBCharacteristic *tmpCharacter = (CBCharacteristic*)[notification object];
    CHAR_STRUCT buf1;
    //将获取的值传递到buf1中；
    [tmpCharacter.value getBytes:&buf1 length:tmpCharacter.value.length];
    for(int i =0;i<tmpCharacter.value.length;i++) {
        NSString *strContent=[Tools stringFromHexString:[NSString stringWithFormat:@"%02X",buf1.buff[i]&0x000000ff]];
        if([@"\n" isEqualToString:strContent]){
            if([receiveSBString length]>0){
                NSString *last=[receiveSBString substringFromIndex:[receiveSBString length]-1];
                if([@"\r" isEqualToString:last]){
                    [self AnalyticalJson:receiveSBString];
                    receiveSBString=[NSMutableString new];
                    continue;
                }
            }
        }else{
            [receiveSBString appendString:strContent];
        }
    }
}

- (void)AnalyticalJson:(NSString*)content
{
    NSData *data=[content dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *resultJSON=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if(resultJSON){
        NSArray *allKeys=[resultJSON allKeys];
        if([allKeys containsObject:@"cf"]){
            //
            [[Data Instance]setCf:[resultJSON objectForKey:@"cf"]];
        }else if([allKeys containsObject:@"sett"]){
            //
            NSLog(@"%@",content);
            NSDictionary *data=[resultJSON objectForKey:@"sett"];
            for(id key in [data allKeys]){
                [[[Data Instance]sett]setObject:[data objectForKey:key] forKey:key];
            }
        }else if([allKeys containsObject:@"t"]){
            //
            NSArray *array=[resultJSON objectForKey:@"t"];
            [self.mHomeViewController loadData:array];
            [self.mTimerViewController loadData:array];
        }else if([allKeys containsObject:@"alarm"]){
            //发出警报
            NSLog(@"%@",content);
            NSString *alaram=[resultJSON objectForKey:@"alarm"];
            if([@"fire" isEqualToString:alaram]){
                //火警
            }else if([@"false" isEqualToString:alaram]){
                //停止报警
            }else{
                //某指针报警
            }
        }else{
            NSLog(@"%@",content);
        }
    }
}

//打开提示框
- (void)AlertShow
{
    [self.mAlertView.lblTitle setText:@"T1-Warning"];
    [self.mAlertView.lblMessage setText:@"Temperature is high!"];
    [self.mAlertView setType:2];
    [self.mAlertView setHidden:NO];
    [self.bgFrame setHidden:NO];
}
//关闭提示框
- (void)AlertClose
{
    [self.mAlertView setHidden:YES];
    [self.bgFrame setHidden:YES];
}

@end