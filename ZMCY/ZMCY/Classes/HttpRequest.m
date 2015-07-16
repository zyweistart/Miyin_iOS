#import "HttpRequest.h"
#import "ATMHud.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "NSString+Utils.h"

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


- (void)loginHandle:(NSString*)action requestParams:(NSMutableDictionary*)params
{
    if ([HttpRequest isNetworkConnection]) {
        NSMutableString *URL=[[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%@?%@",HTTP_URL1,action]];
        for(id p in params){
            NSString *v=[params objectForKey:p];
            [URL appendFormat:@"&%@=%@",p,v];
        }
        // 初始化一个请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
        // 60秒请求超时
        request.timeoutInterval = 120;
        
        if(self.uploadFileData){
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:self.uploadFileData];
        }else{
            [request setHTTPMethod:@"GET"];
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


- (void)handle:(NSString*)action requestParams:(NSMutableDictionary*)params
{
    if ([HttpRequest isNetworkConnection]) {
        NSMutableString *URL=[[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%@?",HTTP_URL]];
        //时间戳
        NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
        [params setObject:[NSString stringWithFormat:@"%0.lf",time] forKey:@"httpTime"];
        //参数拼接URL
        for(id p in params){
            NSString *v=[params objectForKey:p];
            [URL appendFormat:@"%@=%@&",p,v];
        }
        NSMutableArray *paramsArray=[[NSMutableArray alloc]init];
        for(id p in params){
            [paramsArray addObject:p];
        }
        //参数排序签名
        NSArray *paramsSortArray = [paramsArray sortedArrayUsingComparator:
                                    ^NSComparisonResult(NSString *obj1, NSString *obj2) {
                                        return [obj1 compare:obj2];
                                    }];
        NSMutableString *aParamsString=[[NSMutableString alloc]init];
        for(int i=0;i<[paramsSortArray count];i++){
            NSString *p=paramsSortArray[i];
            NSString *v=[params objectForKey:p];
            [aParamsString appendFormat:@"%@=%@",p,v];
            if(i+1<[paramsSortArray count]){
                [aParamsString appendString:@"|"];
            }
        }
        [URL appendFormat:@"sign=%@",[aParamsString md5]];
        
        NSString* urlEncoding = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        // 初始化一个请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlEncoding]];
//        NSLog(@"%@",URL);
        // 60秒请求超时
        request.timeoutInterval = 120;
        
        if(self.uploadFileData){
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:self.uploadFileData];
        }else{
            [request setHTTPMethod:@"GET"];
//            NSString *bodyContent=[[NSString alloc] initWithData:[Common toJSONData:params] encoding:NSUTF8StringEncoding];
//            // 对字符串进行编码后转成NSData对象
//            NSData *data = [bodyContent dataUsingEncoding:NSUTF8StringEncoding];
//            // 设置请求主体
//            request.HTTPBody = data;
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
        if(![response successFlag]){
            if([response message]!=nil&&![@""isEqualToString:[response message]]){
                [Common alert:[response message]];
            }
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
    } else{
        [Common alert:[NSString stringWithFormat:@"网络异常，请重试%@",[error localizedDescription]]];
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