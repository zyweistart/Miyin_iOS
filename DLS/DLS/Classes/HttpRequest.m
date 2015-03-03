////
////  HttpConnection.m
////  Ancun
////
////  Created by Start on 13-9-12.
////
////
//
//#import "HttpRequest.h"
//#import "ATMHud.h"
//#import "MBProgressHUD.h"
//#import "Reachability.h"
//#import "GHNSString+HMAC.h"
//#import "BaseRefreshTableViewController.h"
//
//@implementation HttpRequest {
//    
//    ATMHud *_atmHud;
//    MBProgressHUD *_mbpHud;
//    
//    NSString* _action;
//    NSString* _signKey;
//    NSMutableDictionary* _head;
//    NSMutableDictionary* _request;
//    
//    NSMutableData *_data;
//    long downloadFileSize;
//    
//}
//
////是否已连接网络
//+ (BOOL)isNetworkConnection {
//    Reachability *reach = [Reachability reachabilityForInternetConnection];
//    NetworkStatus netStatus = [reach currentReachabilityStatus];
//    if(netStatus==ReachableViaWWAN||netStatus==ReachableViaWiFi) {
//        return YES;
//    } else {
//        return NO;
//    }
//}
//
//- (void)loginhandle:(NSString*)url requestParams:(NSMutableDictionary*)request {
//    if([[Config Instance]isLogin]) {
//        [request setObject:[[[Config Instance] userInfo] objectForKey:@"accessid"] forKey:@"accessid"];
//        [self handle:url signKey:[[[Config Instance] userInfo] objectForKey:@"accesskey"]  headParams:nil requestParams:request];
//    } else {
//        [Common noLoginAlert:self];
//    }
//}
//
//- (void)handle:(NSString*)url signKey:(NSString*)signKey requestParams:(NSMutableDictionary*)request {
//    [self handle:url signKey:signKey headParams:nil requestParams:request];
//}
//
//- (void)handle:(NSString*)action signKey:(NSString*)signKey headParams:(NSMutableDictionary*)head requestParams:(NSMutableDictionary*)request {
//    if ([HttpRequest isNetworkConnection]) {
//        _action=action;
//        _signKey=signKey;
//        _head=head;
//        _request=request;
//        if(_isFileDownload) {
//            //如果为下载是否使用的是3G移动网络
//            Reachability *reach = [Reachability reachabilityForInternetConnection];
//            if([reach currentReachabilityStatus]==ReachableViaWWAN) {
//                [Common actionSheet:self message:@"即将通过移动网络下载数据，为了节约流量，推荐您使用WIFI无线网络!" tag:1];
//            } else {
//                [self handle];
//            }
//        } else {
//            [self handle];
//        }
//    } else {
//        if(self.controller) {
//            [Common alert:@"网络连接出错，请检测网络设置"];
//        }
//    }
//}
//
//- (void)handle {
//    
//    NSMutableDictionary *common=[[NSMutableDictionary alloc]init];
//    [common setObject:_action forKey:@"action"];
//    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
//    [common setObject:[dateFormatter stringFromDate:[NSDate date]] forKey:@"reqtime"];
//    
//    NSMutableDictionary *mainjson=[[NSMutableDictionary alloc]init];
//    [mainjson setObject:common forKey:@"common"];
//    [mainjson setObject:_request forKey:@"content"];
//    
//    NSMutableDictionary *requestJSON=[[NSMutableDictionary alloc]init];
//    [requestJSON setObject:mainjson forKey:@"request"];
//    NSString *requestBodyContent=[[NSString alloc] initWithData:[Common toJSONData:requestJSON] encoding:NSUTF8StringEncoding];
//    
////    NSString *requestBodyContent=[XML generate:_action requestParams:_request];
//    
//    if(_head==nil) {
//        _head=[[NSMutableDictionary alloc]init];
//    }
//    
//    if([_head objectForKey:@"sign"]==nil) {
//        //签名
//        if(_signKey) {
//            [_head setObject:[[requestBodyContent md5] gh_HMACSHA1:_signKey] forKey:@"sign"];
//        } else {
//            [_head setObject:[requestBodyContent md5] forKey:@"sign"];
//        }
//    }
//    
//    [_head setObject:@"JSON" forKey:@"format"];
//    
//    //请求长度
//    [_head setObject:[NSString stringWithFormat:@"%d",[[requestBodyContent dataUsingEncoding:NSUTF8StringEncoding] length]] forKey:@"reqlength"];
//    
//    // 初始化一个请求
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:ANCUN_HTTP_URL]];
//    // 设置请求方法
//    request.HTTPMethod = @"POST";
//    // 60秒请求超时
//    request.timeoutInterval = 60;
//    //设置请求头参数
//    for(NSString *key in _head) {
//        //URL编码
//        [request addValue:[[_head objectForKey:key] URLEncodedString] forHTTPHeaderField:key];
//    }
//    // 对字符串进行编码后转成NSData对象
//    NSData *data = [requestBodyContent dataUsingEncoding:NSUTF8StringEncoding];
//    //    // 设置请求头信息-请求体长度
//    //    [request setValue:[NSString stringWithFormat:@"%i", data.length] forHTTPHeaderField:@"Content-Length"];
//    //    // 设置请求头信息-请求数据类型
//    //    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    // 设置请求主体
//    request.HTTPBody = data;
//    // 初始化一个连接
//    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
//    // 开始一个异步请求
//    [conn start];
//    
//    if(_isFileDownload){
//        _atmHud=[[ATMHud alloc]init];
//        [self.controller.view addSubview:_atmHud.view];
//        [_atmHud setCaption:@"下载中..."];
//        [_atmHud setProgress:0.01];
//        [_atmHud show];
//        [[Config Instance]setIsCalculateTotal:YES];
//    } else {
//        if(self.controller&&(self.message!=nil||self.isShowMessage)) {
//            _mbpHud = [[MBProgressHUD alloc] initWithView:self.controller.view];
//            [self.controller.view addSubview:_mbpHud];
//            if(self.message) {
//                _mbpHud.labelText = _message;
//            }
//            _mbpHud.dimBackground = NO;
//            _mbpHud.square = YES;
//            [_mbpHud show:YES];
//        }
//    }
//}
//
//#pragma mark 该方法在响应connection时调用
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//    if(_data==nil) {
//        _data=[[NSMutableData alloc]init];
//    }
//    if(self.isFileDownload) {
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//        if(httpResponse && [httpResponse respondsToSelector:@selector(allHeaderFields)]){
//            NSDictionary *httpResponseHeaderFields = [httpResponse allHeaderFields];
//            //获取文件文件的大小
//            downloadFileSize = [[httpResponseHeaderFields objectForKey:@"Content-Length"] longLongValue];
//        }
//    }
//}
//
//#pragma mark 接收到服务器返回的数据
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    [_data appendData:data];
//    if(self.isFileDownload) {
//        //显示下载进度条
//        if(_atmHud) {
//            float size=[_data length]/(float)downloadFileSize;
//            if(size>0) {
//                [_atmHud setProgress:size];
//            }
//        }
//    }
//}
//
//#pragma mark 服务器的数据已经接收完毕时调用
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    if( [_delegate respondsToSelector: @selector(connectionDidFinishLoading:)]) {
//        [_delegate connectionDidFinishLoading:connection];
//    } else if( [_delegate respondsToSelector: @selector(requestFinishedByResponse:requestCode:)]) {
//        Response *response=nil;
//        if(!_isFileDownload) {
//            NSString *responseString =[[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
//            response=[Common toResponseData:responseString];
////            response=[XML analysis:responseString];
//            [response setPropertys:_propertys];
////            [response setResponseString:responseString];
//            if(!_isVerify) {
////                NSLog(@"%@---%@",[response code],[response msg]);
//                [response setSuccessFlag:NO];
//                if([[response code] isEqualToString:@"100000"]) {
//                    [response setSuccessFlag:YES];
//                } else if([[response code] isEqualToString:@"110042"]) {
//                    //暂无记录
//                    if([self.controller isKindOfClass:[BaseRefreshTableViewController class]]) {
//                        [[((BaseRefreshTableViewController*)self.controller) dataItemArray]removeAllObjects];
//                        [[((BaseRefreshTableViewController*)self.controller) tableView]reloadData];
//                    }
//                    [response setSuccessFlag:YES];
//                    if(self.controller){
//                        [Common alert:[response msg]];
//                    }
//                } else if([[response code] isEqualToString:@"110026"]) {
//                    //通行证编号错误或未登录
//                    [[Config Instance]setIsLogin:NO];
//                    [Common noLoginAlert:self];
//                } else if([[response code] isEqualToString:@"110036"]) {
//                    //签名不匹配或密码不正确
//                    [Common alert:@"用户名或密码不正确"];
//                } else if([[response code] isEqualToString:@"120020"]) {
//                    //用户不存在
//                } else if([[response code] isEqualToString:@"120169"]) {
//                    //该手机号码已被注册
//                } else if([[response code] isEqualToString:@"120202"]) {
//                    //录音时长不足
//                    [Common alert:@"录音时长不足，充值相关套餐后才能通话录音"];
//                } else {
//                    [Common alert:[response msg]];
//                }
//            }
//        } else {
//            response=[[Response alloc]init];
//            [response setPropertys:_propertys];
//            [response setData:_data];
//        }
//        [_delegate requestFinishedByResponse:response requestCode:self.requestCode];
//    }
//    //隐藏下载进度条
//    if(_atmHud) {
//        [_atmHud hide];
//    }
//    //隐藏等待条
//    if (_mbpHud) {
//        [_mbpHud hide:YES];
//    }
//}
//
//#pragma mark 网络连接出错时调用
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//    NSLog(@"网络连接出错%@",[error localizedDescription]);
//    if( [_delegate respondsToSelector: @selector(connection:didFailWithError:)]) {
//        [_delegate connection:connection didFailWithError:error];
//    } else if( [_delegate respondsToSelector: @selector(requestFailed:)]) {
//        [_delegate requestFailed:self.requestCode];
//    } else {
//        [Common alert:@"请求异常，请重试！"];
//    }
//    //隐藏下载进度条
//    if(_atmHud) {
//        [_atmHud hide];
//    }
//    //隐藏等待条
//    if (_mbpHud) {
//        [_mbpHud hide:YES];
//    }
//}
//
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if(actionSheet.tag==1) {
//        //移动流量下载行为
//        if(buttonIndex==0) {
//            [self handle];
//        }
//    } else {
//        //未登陆行为
//        if(buttonIndex==0){
//            [Common resultLoginViewController:self.controller resultCode:RESULTCODE_ACLoginViewController_1 requestCode:0 data:nil];
//        }
//    }
//}
//
//@end