//
//  STNewsDetailViewController.m
//  ElectricianRun
//  新闻详细页
//  Created by Start on 1/25/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STNewsDetailViewController.h"

@interface STNewsDetailViewController ()

@end

@implementation STNewsDetailViewController {
    NSDictionary *data;
}

- (id)initWithData:(NSDictionary*)d
{
    self=[super init];
    if(self){
        data=d;
        self.title=@"新闻详细";
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        UIWebView *webView=[[UIWebView alloc]initWithFrame:self.view.frame];
        [webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        if(data==nil){
            NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"page.bundle/《中国电力报》：浙江新能量保障机场变电站运行.html"];
            
            NSURL* url = [NSURL fileURLWithPath:path];
            NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
            [webView loadRequest:request];
        }else{
            NSString *url=[data objectForKey:@"url"];
            NSString *file_name=[data objectForKey:@"file_name"];
            
            if([HttpRequest isNetworkConnection]){
                NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,file_name]]];
                [webView loadRequest:request];
            }else{
                //创建文件管理器
                NSFileManager* fileManager = [NSFileManager defaultManager];
                //获取Documents主目录
                NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                //得到相应的Documents的路径
                NSString* docDir = [paths objectAtIndex:0];
                //更改到待操作的目录下
                [fileManager changeCurrentDirectoryPath:[docDir stringByExpandingTildeInPath]];
                NSString *path = [docDir stringByAppendingPathComponent:file_name];
                //如果图标文件已经存在则进行显示否则进行下载
                if([fileManager fileExistsAtPath:path]){
                    NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                    NSString *html= [NSString stringWithContentsOfFile:path encoding:gbkEncoding error:nil];
                    [webView loadHTMLString:html baseURL:nil];
                }else{
                    [Common alert:@"当前新闻可能已经被删除"];
                    return self;
                }
            }
        }
        [self.view addSubview:webView];
    }
    return self;
}




@end
