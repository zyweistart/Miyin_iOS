//
//  Common.m
//  DLS
//
//  Created by Start on 3/6/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "Common.h"
#import "NSString+Utils.h"

@implementation Common

+ (id)getCache:(NSString *)key{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:key];
}

+ (void)setCache:(NSString *)key data:(id)data{
    NSUserDefaults *setting=[NSUserDefaults standardUserDefaults];
    [setting setObject:data forKey:key];
    [setting synchronize];
}

+ (BOOL)getCacheByBool:(NSString *)key{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings boolForKey:key];
}

+ (void)setCacheByBool:(NSString *)key data:(BOOL)data{
    NSUserDefaults *setting=[NSUserDefaults standardUserDefaults];
    [setting setBool:data forKey:key];
    [setting synchronize];
}

+ (NSData *)toJSONData:(id)theData
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}

+ (void)alert:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"信息"
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil, nil];
    [alert show];
}

+ (UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (NSString*)getString:(NSString*)data
{
    if(data==nil){
        return @"";
    }
    if([data isKindOfClass:[NSNull class]]){
        return @"";
    }
    return [NSString stringWithFormat:@"%@",data];
}

+ (NSString*)convertTime:(NSString*)time
{
    NSString *data=[Common getString:time];
    if([@"" isEqualToString:data]){
        return data;
    }
    if([data length]<11){
        return data;
    }
    NSMutableString *str=[[NSMutableString alloc]initWithString:data];
    return [str substringWithRange:NSMakeRange(0,10)];
}

+ (void)AsynchronousDownloadImageWithUrl:(NSString *)u ShowImageView:(UIImageView*)showImage
{
    NSString *fName=[u md5];
    //创建文件管理器
    NSFileManager* fileManager = [NSFileManager defaultManager];
    //获取Documents主目录
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //得到相应的Documents的路径
    NSString* docDir = [paths objectAtIndex:0];
    //更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[docDir stringByExpandingTildeInPath]];
    NSString *path = [docDir stringByAppendingPathComponent:fName];
    if(![fileManager fileExistsAtPath:path]){
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
        dispatch_async(queue, ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:u]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (data) {
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
                    //把临时下载好的文件移动到主文档目录下
                    [fileManager moveItemAtPath:tmpPath toPath:path error:nil];
                    if(showImage){
                        [showImage setImage:[[UIImage alloc] initWithContentsOfFile:path]];
                    }
                }
            });
            
        });

    }else{
        if(showImage){
            [showImage setImage:[[UIImage alloc] initWithContentsOfFile:path]];
        }
    }
}

@end
