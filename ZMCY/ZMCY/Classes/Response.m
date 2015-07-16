#import "Response.h"

@implementation Response

- (id)init{
    self=[super init];
    if(self){
        _successFlag=NO;
    }
    return self;
}

+ (Response*)toData:(NSString*)repsonseString
{
    Response *response=[[Response alloc]init];
    if(repsonseString!=nil&&![@"" isEqualToString:repsonseString]){
        [response setResponseString:repsonseString];
        [response setData:[[response responseString] dataUsingEncoding: NSUTF8StringEncoding]];
        if([response data]!=nil){
            //转换成JSON格式
            NSDictionary *resultJSON=[NSJSONSerialization JSONObjectWithData:[response data] options:NSJSONReadingMutableLeaves error:nil];
            if(resultJSON!=nil){
                [response setResultJSON:resultJSON];
                NSString *code=[resultJSON objectForKey:@"result"];
                [response setCode:[NSString stringWithFormat:@"%@",code]];
                //判断是否成功
                [response setSuccessFlag:[@"success" isEqualToString:[response code]]];
                if(![response successFlag]){
                    NSString *message=[resultJSON objectForKey:@"reason"];
                    [response setMessage:[NSString stringWithFormat:@"%@",message]];
                }
            }
        }
    }
    return response;
}

@end
