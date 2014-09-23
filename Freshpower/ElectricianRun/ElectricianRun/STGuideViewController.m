//
//  STGuideViewController.m
//  ElectricianRun
//
//  Created by Start on 2/11/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STGuideViewController.h"
#import "STIndexViewController.h"
#import "STStudyViewController.h"
#import "STMyeViewController.h"
#import "STUserExperienceAlarmViewController.h"

#import "SQLiteOperate.h"

#define DOWNLOADPIC 500
#define DOWNLOADHTML 501

@interface STGuideViewController ()

@end

@implementation STGuideViewController {
    SQLiteOperate *db;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self downLoadPicture];
    [self downLoadHtml];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //首页
    UINavigationController *indexViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STIndexViewController alloc]init]];
    indexViewControllerNav.navigationBarHidden=YES;
    indexViewControllerNav.tabBarItem.title=@"首页";
    indexViewControllerNav.tabBarItem.image=[UIImage imageNamed:@"shouye"];
    //我要学习
    UINavigationController *studyViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STStudyViewController alloc]init]];
    studyViewControllerNav.tabBarItem.title=@"我要学习";
    studyViewControllerNav.tabBarItem.image=[UIImage imageNamed:@"xuexi"];
    //我的e电工
    UINavigationController *myeViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STMyeViewController alloc]init]];
    myeViewControllerNav.tabBarItem.title=@"我的e电工";
    myeViewControllerNav.tabBarItem.image=[UIImage imageNamed:@"dgb"];
    
    [self setViewControllers:[NSArray arrayWithObjects:
                              indexViewControllerNav,
                              studyViewControllerNav,
                              myeViewControllerNav,
                              nil] animated:YES];
    
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
//    page1.title = @"Hello world";
//    page1.desc = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    page1.bgImage = [UIImage imageNamed:@"guide1"];
//    page1.titleImage = [UIImage imageNamed:@"original"];
    
    EAIntroPage *page2 = [EAIntroPage page];
//    page2.title = @"This is page 2";
//    page2.desc = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.";
    page2.bgImage = [UIImage imageNamed:@"guide2"];
//    page2.titleImage = [UIImage imageNamed:@"supportcat"];
    
    EAIntroPage *page3 = [EAIntroPage page];
//    page3.title = @"This is page 3";
//    page3.desc = @"Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.";
    page3.bgImage = [UIImage imageNamed:@"guide3"];
//    page3.titleImage = [UIImage imageNamed:@"femalecodertocat"];
    
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
    [p setObject:@"0" forKey:@"type"];
    [p setObject:[NSString stringWithFormat:@"%d",TOPIMAGENUM] forKey:@"num"];
    
    self.hPicRequest=[[HttpRequest alloc]init:self delegate:self responseCode:DOWNLOADPIC];
    [self.hPicRequest setIsShowMessage:NO];
    [self.hPicRequest setIsShowNetConnectionMessage:NO];
    [self.hPicRequest start:URLnews params:p];
}

//下载新闻
- (void)downLoadHtml
{
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:@"1" forKey:@"type"];
    [p setObject:@"7" forKey:@"num"];
    
    self.hHtmlRequest=[[HttpRequest alloc]init:self delegate:self responseCode:DOWNLOADHTML];
    [self.hHtmlRequest setIsShowMessage:NO];
    [self.hHtmlRequest setIsShowNetConnectionMessage:NO];
    [self.hHtmlRequest start:URLnews params:p];
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
    }else if(repCode==DOWNLOADHTML){
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
            if([db createTable]){
                NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM NEW WHERE URL='%@'",url];
                NSMutableArray *indata=[db query:sqlQuery];
                for(NSDictionary *outd in outdata){
                    
                    NSString *outname=[outd objectForKey:@"NAME"];
                    NSString *outicon_name=[outd objectForKey:@"ICO_NAME"];
                    NSString *outfile_name=[outd objectForKey:@"FILE_NAME"];
                    NSString *outcontent=[outd objectForKey:@"CONTENT"];

                    NSMutableString *iconurl=[[NSMutableString alloc]initWithString:url];
                    [iconurl appendFormat:@"images/%@",outicon_name];
                    
                    BOOL flag=NO;
                    for(NSDictionary *ind in indata){
                        flag=NO;
                        NSString *inname=[ind objectForKey:@"name"];
                        NSString *inicon_name=[ind objectForKey:@"icon_name"];
                        NSString *infile_name=[ind objectForKey:@"file_name"];
                        NSString *incontent=[ind objectForKey:@"content"];
                        
                        if([outname isEqualToString:inname]&&
                           [outicon_name isEqualToString:inicon_name]&&
                           [outfile_name isEqualToString:infile_name]&&
                           [outcontent isEqualToString:incontent]){
                            
                            flag=YES;
                            
                            break;
                        }
                        
                    }
                    if(!flag){
                        NSString *sql = [NSString stringWithFormat:
                                         @"INSERT INTO NEW (URL,NAME,ICO_NAME,FILE_NAME,CONTENT) VALUES ('%@', '%@', '%@' ,'%@' ,'%@')",url, outname, outicon_name, outfile_name, outcontent];
                        if([db execSql:sql]){
                            NSString *ufile=[NSString stringWithFormat:@"%@%@",url,outfile_name];
                            NSString *uicon=[NSString stringWithFormat:@"%@images/%@",url,outicon_name];
                            [self AsynchronousDownloadWithUrl:ufile FileName:outfile_name];
                            [self AsynchronousDownloadWithUrl:uicon FileName:outicon_name];
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
