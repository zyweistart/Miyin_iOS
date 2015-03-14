#import "HttpRequest.h"
#import "ATMHud.h"
#import "MBProgressHUD.h"
#import "Reachability.h"

@implementation HttpRequest
{
    ATMHud *_atmHud;
    MBProgressHUD *_mbpHud;
    NSMutableData *_data;
    long long downloadFileSize;
}

- (id)init
{
    self=[super init];
    if(self){
        self.isShowMessage=NO;
        self.isFileDownload=NO;
        self.isMultipartFormDataSubmit=NO;
    }
    return self;
}

//是否已连接网络
+ (BOOL)isNetworkConnection
{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    if(netStatus==ReachableViaWWAN||netStatus==ReachableViaWiFi) {
        return YES;
    } else {
        return NO;
    }
}

- (void)handle:(NSString*)action requestParams:(NSMutableDictionary*)params
{
    if ([HttpRequest isNetworkConnection]) {
        //时间戳;
//        NSString *timestamp=[NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]*1000];
        NSString *timestamp=@"1426145110208";
        //随机数
//        NSString *nonce=[NSString stringWithFormat:@"%d",arc4random() % 1000];
        NSString *nonce=@"881";
        //封装成数组
//        NSString *arr[]={ACCESSKEY,timestamp,nonce};
        //数组排序

        //签名
        NSString *signature=@"b1c6607d21672466a41aff9ca476722cd55a1bf8";
        NSString *url=HTTP_SERVER_URL(action, signature, timestamp, nonce);
        // 初始化一个请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        // 设置请求方法
        request.HTTPMethod = @"POST";
        // 60秒请求超时
        request.timeoutInterval = 60;
        
        if(self.isMultipartFormDataSubmit){
            //主体数据POST提交
            
            NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            
            NSString *boundary=@"AaB03x";
            
            // post body
            NSMutableData *body = [NSMutableData data];
            
            // add params (all params are strings)
            for (NSString *p in params) {
                id data=[params objectForKey:p];
                if(![data isKindOfClass:[NSData class]]){
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:gbkEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", [p stringByAddingPercentEscapesUsingEncoding:gbkEncoding]] dataUsingEncoding:gbkEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"%@\r\n", data] dataUsingEncoding:gbkEncoding]];
                }
            }
            // add file data
            for (NSString *p in params) {
                id data=[params objectForKey:p];
                if([data isKindOfClass:[NSData class]]){
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:gbkEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@.png\"\r\n",p,p] dataUsingEncoding:gbkEncoding]];
                    [body appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:gbkEncoding]];
                    [body appendData:data];
                    [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:gbkEncoding]];
                }
            }
            [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:gbkEncoding]];
            
//            NSLog(@"%@",[[NSString alloc] initWithData:body  encoding:gbkEncoding]);
            
            [request setValue:[NSString stringWithFormat:@"multipart/form-data, boundary=%@",boundary] forHTTPHeaderField: @"Content-Type"];
            
            // set the content-length
            [request setValue:[NSString stringWithFormat:@"%ld",[body length]] forHTTPHeaderField:@"Content-Length"];
            
            [request setHTTPBody:body];
            
        }else{
            NSString *bodyContent=[[NSString alloc] initWithData:[Common toJSONData:params] encoding:NSUTF8StringEncoding];
            // 对字符串进行编码后转成NSData对象
            NSData *data = [bodyContent dataUsingEncoding:NSUTF8StringEncoding];
            // 设置请求主体
            request.HTTPBody = data;
        }
        // 初始化一个连接
        NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
        // 开始一个异步请求
        [conn start];
        if(_isFileDownload){
            _atmHud=[[ATMHud alloc]init];
            [self.controller.view addSubview:_atmHud.view];
            [_atmHud setCaption:@"下载中..."];
            [_atmHud setProgress:0.01];
            [_atmHud show];
        } else {
            if(self.controller&&(self.message!=nil||self.isShowMessage)) {
                _mbpHud = [[MBProgressHUD alloc] initWithView:self.controller.view];
                [self.controller.view addSubview:_mbpHud];
                if(self.message) {
                    _mbpHud.labelText = _message;
                }
                _mbpHud.dimBackground = NO;
                _mbpHud.square = YES;
                [_mbpHud show:YES];
            }
        }
    } else {
        NSLog(@"网络连接出错，请检测网络设置");
        if( [_delegate respondsToSelector: @selector(requestFailed:)]) {
            [_delegate requestFailed:self.requestCode];
        }
    }
}

#pragma mark 该方法在响应connection时调用
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(_data==nil) {
        _data=[[NSMutableData alloc]init];
    }
    if(self.isFileDownload) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse && [httpResponse respondsToSelector:@selector(allHeaderFields)]){
            NSDictionary *httpResponseHeaderFields = [httpResponse allHeaderFields];
            //获取文件文件的大小
            downloadFileSize = [[httpResponseHeaderFields objectForKey:@"Content-Length"] longLongValue];
        }
    }
}

#pragma mark 接收到服务器返回的数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
    if(self.isFileDownload) {
        //显示下载进度条
        if(_atmHud) {
            float size=[_data length]/(float)downloadFileSize;
            if(size>0) {
                [_atmHud setProgress:size];
            }
        }
    }
}

#pragma mark 服务器的数据已经接收完毕时调用
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if( [_delegate respondsToSelector: @selector(connectionDidFinishLoading:)]) {
        [_delegate connectionDidFinishLoading:connection];
    } else if( [_delegate respondsToSelector: @selector(requestFinishedByResponse:requestCode:)]) {
        NSString *responseString =[[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
        Response *response=[Response toData:responseString];
        //成功标记
        [response setSuccessFlag:[@"0" isEqualToString:[response code]]];
        if(![response successFlag]){
            [Common alert:[response msg]];
        }
        [_delegate requestFinishedByResponse:response requestCode:self.requestCode];
    }
    //隐藏下载进度条
    if(_atmHud) {
        [_atmHud hide];
    }
    //隐藏等待条
    if (_mbpHud) {
        [_mbpHud hide:YES];
    }
}

#pragma mark 网络连接出错时调用
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if( [_delegate respondsToSelector: @selector(connection:didFailWithError:)]) {
        [_delegate connection:connection didFailWithError:error];
    } else if( [_delegate respondsToSelector: @selector(requestFailed:)]) {
        [_delegate requestFailed:self.requestCode];
    }
    //隐藏下载进度条
    if(_atmHud) {
        [_atmHud hide];
    }
    //隐藏等待条
    if (_mbpHud) {
        [_mbpHud hide:YES];
    }
}

@end