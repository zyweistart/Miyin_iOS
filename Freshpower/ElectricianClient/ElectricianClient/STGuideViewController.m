//
//  STGuideViewController.m
//  ElectricianRun
//
//  Created by Start on 2/11/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STGuideViewController.h"
#import "STIndexViewController.h"
#import "STFindElectricianMapViewController.h"
#import "STMyeViewController.h"
#import "STLoginViewController.h"
#import "STUserSelectViewController.h"

#import "SQLiteOperate.h"

#define DOWNLOADPIC 500

@interface STGuideViewController ()

@end

@implementation STGuideViewController{
    SQLiteOperate *db;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self downLoadPicture];
    
    if([Account isLogin]){
        //首页
        STIndexViewController *indexViewController = [[STIndexViewController alloc]init];
        indexViewController.tabBarItem.title=@"首页";
        indexViewController.tabBarItem.image=[UIImage imageNamed:@"sy2"];
        //我要学习
        UINavigationController *findElectricianMapViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STFindElectricianMapViewController alloc]init]];
        findElectricianMapViewControllerNav.tabBarItem.title=@"找电工";
        findElectricianMapViewControllerNav.tabBarItem.image=[UIImage imageNamed:@"dg2"];
        //我的e电工
        UINavigationController *myeViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STMyeViewController alloc]init]];
        myeViewControllerNav.tabBarItem.title=@"我的e电工";
        myeViewControllerNav.tabBarItem.image=[UIImage imageNamed:@"e2"];
        [self setDelegate:self];
        [self setViewControllers:[NSArray arrayWithObjects:
                                              indexViewController,
                                              findElectricianMapViewControllerNav,
                                              myeViewControllerNav,
                                              nil] animated:YES];
    }else{
        STUserSelectViewController *userSelectViewController = [[STUserSelectViewController alloc]init];
        [self setViewControllers:[NSArray arrayWithObjects:
                                  userSelectViewController,
                                  nil] animated:YES];
        [[self tabBar]setHidden:YES];
    }
    
    //获取最后保存的版本号不存在则为0
    float lastVersionNo=[[Common getCache:DEFAULTDATA_LASTVERSIONNO] floatValue];
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    //获取当前使用的版本号
    NSString *currentVersionNo=[infoDict objectForKey:@"CFBundleShortVersionString"];
    if([currentVersionNo floatValue]>lastVersionNo){
        [self showIntroWithCrossDissolve];
    }
}

- (void)showIntroWithCrossDissolve {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.bgImage = [UIImage imageNamed:@"guide1"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.bgImage = [UIImage imageNamed:@"guide2"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.bgImage = [UIImage imageNamed:@"guide3"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3]];
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
}

- (void)introDidFinish {
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    NSString *currentVersionNo=[infoDict objectForKey:@"CFBundleShortVersionString"];
    [Common setCache:DEFAULTDATA_LASTVERSIONNO data:currentVersionNo];
}

//下载图片
- (void)downLoadPicture
{
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:@"2" forKey:@"type"];
    [p setObject:[NSString stringWithFormat:@"%d",TOPIMAGENUM] forKey:@"num"];
    self.hPicRequest=[[HttpRequest alloc]init:self delegate:self responseCode:DOWNLOADPIC];
    [self.hPicRequest setIsShowMessage:NO];
    [self.hPicRequest setIsShowNetConnectionMessage:NO];
    [self.hPicRequest start:URLnews params:p];
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode
{
    if(repCode==DOWNLOADPIC){
        NSDictionary *dic=[[response resultJSON]objectForKey:@"Rows"];
        if(dic!=nil) {
            if([@"0" isEqualToString:[dic objectForKey:@"result"]]){
                return;
            }
        }
        NSString *url=[[response resultJSON] objectForKey:@"URL"];
        NSMutableArray *outdata=[[response resultJSON] objectForKey:@"FILE_NAMES"];
        db=[[SQLiteOperate alloc]init];
        if([db openDB]){
            if([db createTable1]){
                NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM PIC WHERE URL='%@'",url];
                NSMutableArray *indata=[db query1:sqlQuery];
                for(NSDictionary *outd in outdata){
                    NSString *out_filename=[outd objectForKey:@"FILE_NAME"];
                    BOOL flag=NO;
                    for(NSDictionary *ind in indata){
                        flag=NO;
                        NSString *inname=[ind objectForKey:@"name"];
                        
                        if([out_filename isEqualToString:inname]){
                            
                            flag=YES;
                            
                            break;
                        }
                        
                    }
                    if(!flag){
                        NSString *sql = [NSString stringWithFormat:
                                         @"INSERT INTO PIC (URL,NAME) VALUES ('%@', '%@')",url, out_filename];
                        if([db execSql:sql]){
                            NSString *ufile=[NSString stringWithFormat:@"%@%@",url,out_filename];
                            [self AsynchronousDownloadWithUrl:ufile FileName:out_filename];
                        }
                    }
                }
                
            }
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}

- (void)AsynchronousDownloadWithUrl:(NSString *)u FileName:(NSString *)fName
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_async(queue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:u]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (data) {
                //创建文件管理器
                NSFileManager* fileManager = [NSFileManager defaultManager];
                //获取临时目录
                NSString* tmpDir=NSTemporaryDirectory();
                //更改到待操作的临时目录
                [fileManager changeCurrentDirectoryPath:[tmpDir stringByExpandingTildeInPath]];
                NSString *tmpPath = [tmpDir stringByAppendingPathComponent:fName];
                //创建数据缓冲区
                NSMutableData* writer = [[NSMutableData alloc] init];
                //将字符串添加到缓冲中
                [writer appendData: data];
                //将其他数据添加到缓冲中
                //将缓冲的数据写入到临时文件中
                [writer writeToFile:tmpPath atomically:YES];
                //获取Documents主目录
                NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                //得到相应的Documents的路径
                NSString* docDir = [paths objectAtIndex:0];
                //更改到待操作的目录下
                [fileManager changeCurrentDirectoryPath:[docDir stringByExpandingTildeInPath]];
                NSString *path = [docDir stringByAppendingPathComponent:fName];
                //把临时下载好的文件移动到主文档目录下
                [fileManager moveItemAtPath:tmpPath toPath:path error:nil];
            }
        });
    });
}

@end
