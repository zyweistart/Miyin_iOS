#import "TabBarFrameViewController.h"
#import "Tools.h"

@interface TabBarFrameViewController ()

@end

@implementation TabBarFrameViewController{
    //接收到的数据
    NSMutableString *receiveSBString;
    NSNotificationCenter *nc;
    
    NSMutableArray *demoseTTArray;
    NSMutableArray *demoTArray;
}

- (id)init
{
    self=[super init];
    if(self){
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        //初始化默认配置
        if([@"" isEqualToString:[[Data Instance]getCf]]){
            [[Data Instance]setCf:@"c"];
        }
        if([@"" isEqualToString:[[Data Instance]getAlarm]]){
            [[Data Instance]setAlarm:@"Beep1"];
        }
        if([@"" isEqualToString:[[Data Instance]getLanguage]]){
            [[Data Instance]setLanguage:@"0"];;
        }
        //设置默认的温度值
        [[[Data Instance]sett]setObject:@"100" forKey:@"p1"];
        [[[Data Instance]sett]setObject:@"100" forKey:@"p2"];
        [[[Data Instance]sett]setObject:@"100" forKey:@"p3"];
        [[[Data Instance]sett]setObject:@"400" forKey:@"p4"];
        self.bgFrame=[[UIView alloc]initWithFrame:self.view.bounds];
        [self.bgFrame setBackgroundColor:DEFAULTITLECOLORA(150, 0.5)];
        [self.bgFrame setHidden:YES];
        [self.view addSubview:self.bgFrame];
        
        self.mAlertView=[[AlertView alloc]initWithFrame:CGRectMake1(10, 100, 300, 180)];
        [self.mAlertView.button addTarget:self action:@selector(AlertClose) forControlEvents:UIControlEventTouchUpInside];
        [self.mAlertView setHidden:YES];
        [self.bgFrame addSubview:self.mAlertView];
        
        self.mHomeViewController=[[HomeViewController alloc]init];
        self.mToolsViewController=[[ToolsViewController alloc]init];
        self.mSettingViewController=[[SettingViewController alloc]init];
        self.mInfoViewController=[[InfoViewController alloc]init];
        self.viewControllers = [NSArray arrayWithObjects:
                                [self viewControllerWithTabTitle:NSLocalizedString(@"Menu",nil) image:@"icon-nav-home" ViewController:self.mHomeViewController],
                                [self viewControllerWithTabTitle:NSLocalizedString(@"Tools",nil) image:@"icon-nav-tools" ViewController:self.mToolsViewController],
                                [self viewControllerWithTabTitle:NSLocalizedString(@"Info",nil) image:@"icon-nav-info" ViewController:self.mInfoViewController],
                                [self viewControllerWithTabTitle:NSLocalizedString(@"Setting",nil) image:@"icon-nav-setting" ViewController:self.mSettingViewController], nil];
        
        if([[Data Instance]isDemo]){
            //生成随机数
            demoseTTArray=[[NSMutableArray alloc]init];
            int v1 = arc4random() % 438 + 100;
            int v2 = arc4random() % 438 + 100;
            int v3 = arc4random() % 438 + 100;
            int v4 = arc4random() % 438 + 100;
            [demoseTTArray addObject:[NSString stringWithFormat:@"{\"sett\":{\"p1\":%d}}",v1]];
            [demoseTTArray addObject:[NSString stringWithFormat:@"{\"sett\":{\"p2\":%d}}",v2]];
            [demoseTTArray addObject:[NSString stringWithFormat:@"{\"sett\":{\"p3\":%d}}",v3]];
            [demoseTTArray addObject:[NSString stringWithFormat:@"{\"sett\":{\"p4\":%d}}",v4]];
            for(int i=0;i<[demoseTTArray count];i++){
                NSString *json=[demoseTTArray objectAtIndex:i];
                [self AnalyticalJson:json];
            }
            demoTArray=[[NSMutableArray alloc]init];
            for(int i=0;i<100;i++){
                int v1 = arc4random() % 40 + 25;
                int v2 = arc4random() % 40 + 25;
                int v3 = arc4random() % 40 + 25;
                int v4 = arc4random() % 40 + 25;
                [demoTArray addObject:[NSString stringWithFormat:@"{\"t\":[{\"p1\":%d},{\"p2\":%d},{\"p3\":%d},{\"p4\":%d}]}",v1,v2,v3,v4]];
            }
            [self demoUpdateTimer];
            self.mDemoTimer=[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(demoUpdateTimer) userInfo:nil repeats:YES];
        }
        
        receiveSBString=[NSMutableString new];
        if(![[Data Instance]isDemo]){
            //设置消息通知
            nc = [NSNotificationCenter defaultCenter];
            [nc addObserver: self
                   selector: @selector(ValueChangText:)
                       name: NOTIFICATION_VALUECHANGUPDATE
                     object: nil];
            //开始接收消息
            self.appDelegate = [[UIApplication sharedApplication] delegate];
            [self.appDelegate.bleManager notification:0xFFE0 characteristicUUID:0xFFE4 p:self.appDelegate.bleManager.activePeripheral on:YES];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if([[Data Instance]isDemo]){
        if(self.mDemoTimer){
            [self.mDemoTimer invalidate];
            self.mDemoTimer=nil;
        }
    }else{
        [nc removeObserver:self name:NOTIFICATION_VALUECHANGUPDATE object:nil];
    }
}

- (UINavigationController*)viewControllerWithTabTitle:(NSString*) title image:(NSString*)image ViewController:(UIViewController*)viewController
{
    UINavigationController *frameViewControllerNav=[[UINavigationController alloc]initWithRootViewController:viewController];
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
                    continue;
                }
            }
        }else{
            [receiveSBString appendString:strContent];
            if([@"}" isEqualToString:strContent]){
                if([@"{\"power\":\"off\"}" isEqualToString:receiveSBString]){
                    [self AnalyticalJson:receiveSBString];
                    break;
                }
            }
        }
    }
}

- (void)AnalyticalJson:(NSString*)content
{
    receiveSBString=[NSMutableString new];
    NSData *data=[content dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *resultJSON=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if(resultJSON){
        NSArray *allKeys=[resultJSON allKeys];
        if([allKeys containsObject:@"cf"]){
            //温度单位
            [[Data Instance]setCf:[resultJSON objectForKey:@"cf"]];
            [self.mHomeViewController refreshDataView];
            [self.mInfoViewController.tableView reloadData];
        }else if([allKeys containsObject:@"sett"]){
            //温度设置值
            NSDictionary *data=[resultJSON objectForKey:@"sett"];
            for(id key in [data allKeys]){
                [[[Data Instance]sett]setObject:[data objectForKey:key] forKey:key];
            }
            [self.mHomeViewController refreshDataView];
            [self.mInfoViewController.tableView reloadData];
        }else if([allKeys containsObject:@"t"]){
            //当前温度值
            NSArray *array=[resultJSON objectForKey:@"t"];
            [[Data Instance]setCurrentTValue:[NSMutableArray arrayWithArray:array]];
            [self.mHomeViewController loadData:array];
            [self.mToolsViewController loadData:array];
            [self.mInfoViewController loadData:array];
        }else if([allKeys containsObject:@"alarm"]){
            //发出警报
            NSString *alaram=[resultJSON objectForKey:@"alarm"];
            if([@"fire" isEqualToString:alaram]){
                //火警
                [self playAlarm];
                [self.mAlertView.lblTitle setText:@"Warning"];
                [self.mAlertView.lblMessage setText:NSLocalizedString(@"The grill has flared up!",nil)];
                [self.mAlertView setType:2];
                [self AlertShow];
            }else if([@"false" isEqualToString:alaram]){
                //停止报警
                [self stopAlarm];
                [self.mAlertView setHidden:YES];
                [self.bgFrame setHidden:YES];
            }else{
                //某指针报警
                [self playAlarm];
                [self.mAlertView.lblTitle setText:[NSString stringWithFormat:@"%@-Warning",alaram]];
                [self.mAlertView.lblMessage setText:NSLocalizedString(@"Temperature is high!",nil)];
                [self.mAlertView setType:1];
                [self AlertShow];
            }
        }else if([allKeys containsObject:@"power"]){
            //关机
            [self powerOff:content];
        }else{
            NSLog(@"%@",content);
        }
    }else{
        //发送异常处理
        NSString *json=@"{}";
        [self.appDelegate sendData:json];
    }
}

//打开提示框
- (void)AlertShow
{
    [self.mAlertView setHidden:NO];
    [self.bgFrame setHidden:NO];
}

//关闭提示框
- (void)AlertClose
{
    [self stopAlarm];
    [self.mAlertView setHidden:YES];
    [self.bgFrame setHidden:YES];
    //发送关闭消息到蓝牙
    NSString *json=@"{\"alarm\":false}";
    [self.appDelegate sendData:json];
}

//播放报警声音
- (void)playAlarm
{
    [self stopAlarm];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.wav",[[Data Instance]getAlarm]]];
    NSURL *URL=[NSURL fileURLWithPath:path];
    self.mAVAudioPlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:URL error:nil];
    [self.mAVAudioPlayer setDelegate:self];
    [self.mAVAudioPlayer setVolume:1.0];
    [self.mAVAudioPlayer setNumberOfLoops:-1];
    if([self.mAVAudioPlayer prepareToPlay]){
        [self.mAVAudioPlayer play];
    }
}

//报警声音停止
- (void)stopAlarm
{
    if(self.mAVAudioPlayer){
        [self.mAVAudioPlayer stop];
        self.mAVAudioPlayer=nil;
        [[AVAudioSession sharedInstance] setActive:NO error:nil];
    }
}

//播放结束时执行的动作
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player successfully:(BOOL)flag{
    if (flag) {
//        [self AlertClose];
    }
}

- (void)powerOff:(NSString*)content
{
    [self.mHomeViewController ConnectedState:NO];
    [self.mToolsViewController ConnectedState:NO];
    [self.mInfoViewController ConnectedState:NO];
}

- (void)demoUpdateTimer
{
    int x = arc4random() % 100;
    NSString *json=[demoTArray objectAtIndex:x];
    [self AnalyticalJson:json];
}

@end