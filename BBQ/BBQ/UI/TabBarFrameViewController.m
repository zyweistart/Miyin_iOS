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
        receiveSBString=[NSMutableString new];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver: self
               selector: @selector(ValueChangText:)
                   name: NOTIFICATION_VALUECHANGUPDATE
                 object: nil];
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

- (UINavigationController*)viewControllerWithTabTitle:(NSString*) title image:(NSString*)image ViewController:(UIViewController*)viewController
{
    UINavigationController *frameViewControllerNav=[[UINavigationController alloc]initWithRootViewController:viewController];
//    [[frameViewControllerNav navigationBar]setBarTintColor:NAVBG];
//    [[frameViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
    UITabBarItem *tabBarItem=[[UITabBarItem alloc]init];
    [tabBarItem setTitle:title];
    if(image){
        [tabBarItem setImage:[UIImage imageNamed:image]];
        [tabBarItem setSelectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@2",image]]];
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
            NSLog(@"%@",content);
            [[Data Instance]setCf:[resultJSON objectForKey:@"cf"]];
        }else if([allKeys containsObject:@"sett"]){
            //
            NSLog(@"%@",content);
            [[[Data Instance] sett]addObject:[resultJSON objectForKey:@"sett"]];
        }else if([allKeys containsObject:@"t"]){
            //
            NSArray *array=[resultJSON objectForKey:@"t"];
            [self.mHomeViewController loadData:array];
        }else if([allKeys containsObject:@"alarm"]){
            //发出警报
        }else{
            NSLog(@"%@",content);
        }
    }
}

@end