//
//  ACResponse.m
//  ACyulu
//
//  Created by Start on 12-12-6.
//  Copyright (c) 2012年 ancun. All rights reserved.
//

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
                [response setCode:[NSString stringWithFormat:@"%@",[resultJSON objectForKey:@"code"]]];
                [response setMsg:[NSString stringWithFormat:@"%@",[resultJSON objectForKey:@"Message"]]];
            }
        }
    }
    return response;
}

@end
