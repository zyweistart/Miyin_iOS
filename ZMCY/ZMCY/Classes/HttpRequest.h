//
//  HttpConnection.h
//  Ancun
//
//  Created by Start on 13-9-12.
//
//

#import "Response.h"

@protocol HttpViewDelegate <NSURLConnectionDataDelegate>

@optional
- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode;
- (void)requestFailed:(int)reqCode;

@end

@interface HttpRequest : NSObject<NSURLConnectionDataDelegate,UIActionSheetDelegate>
//请求码
@property int requestCode;
//是否为文件下载
@property BOOL isFileDownload;
//是否显示等待信息框
@property BOOL isShowMessage;
//多文件上传数据提交
@property BOOL isMultipartFormDataSubmit;
//等待信息框的提示信息
@property (strong,nonatomic) NSString *message;
//当前请求的控制器
@property (strong,nonatomic) UIViewController *controller;
//代理对象
@property (strong,nonatomic) NSObject<HttpViewDelegate> *delegate;

+ (BOOL)isNetworkConnection;
- (void)handle:(NSString*)action requestParams:(NSMutableDictionary*)params;

@end