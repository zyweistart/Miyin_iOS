#import "HttpRequest.h"
#import "ATMHud.h"
#import "MBProgressHUD.h"
#import "Reachability.h"

@implementation HttpRequest
{
    ATMHud *_atmHud;
    MBProgressHUD *_mbpHud;
    NSMutableData *_data;
    long downloadFileSize;
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
        NSString *bodyContent=[[NSString alloc] initWithData:[Common toJSONData:params] encoding:NSUTF8StringEncoding];
        //时间戳;
//        NSString *timestamp=[NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]*1000];
        NSString *timestamp=@"1425720173772";
        //随机数
//        NSString *nonce=[NSString stringWithFormat:@"%d",arc4random() % 1000];
        NSString *nonce=@"192";
        //封装成数组
//        NSString *arr[]={ACCESSKEY,timestamp,nonce};
        //数组排序

        //签名
        NSString *signature=@"bc290c4cda2d188f60cee19ac22eb3db5a8e0ac0";
        NSString *url=HTTP_SERVER_URL(action, signature, timestamp, nonce);
        // 初始化一个请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        // 设置请求方法
        request.HTTPMethod = @"POST";
        // 60秒请求超时
        request.timeoutInterval = 60;
        // 对字符串进行编码后转成NSData对象
        NSData *data = [bodyContent dataUsingEncoding:NSUTF8StringEncoding];
        // 设置请求头信息-请求体长度
//        [request setValue:[NSString stringWithFormat:@"%ld", data.length] forHTTPHeaderField:@"Content-Length"];
        // 设置请求头信息-请求数据类型
//        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        // 设置请求主体
        request.HTTPBody = data;
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
        [_delegate requestFinishedByResponse:response requestCode:self.requestCode];
        NSLog(@"%@",[response msg]);
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