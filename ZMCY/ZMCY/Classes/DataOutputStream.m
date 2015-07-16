#import "DataOutputStream.h"


@implementation DataOutputStream

- (id)init{
    self = [super init];
    if(self != nil){
        data = [[NSMutableData alloc] init];
        length = 0;
    }
    return self;
}

- (void)writeChar:(int8_t)v {
    int8_t ch[1];
    ch[0] = (v & 0x0ff);
    [data appendBytes:ch length:1];
    length++;
}

- (void)writeShort:(int16_t)v {
    int8_t ch[2];
    ch[0] = (v & 0x0ff00)>>8;
    ch[1] = (v & 0x0ff);
    [data appendBytes:ch length:2];
    length = length + 2;
}

- (void)writeInt:(int32_t)v {
    int8_t ch[4];
    for(int32_t i = 0;i<4;i++){
        ch[i] = ((v >> ((3 - i)*8)) & 0x0ff);
    }
    [data appendBytes:ch length:4];
    length = length + 4;
}

- (void)writeLong:(int64_t)v {
    int8_t ch[8];
    for(int32_t i = 0;i<8;i++){
        ch[i] = ((v >> ((7 - i)*8)) & 0x0ff);
    }
    [data appendBytes:ch length:8];
    length = length + 8;
}

- (void)writeUTF:(NSString *)v {
    NSData *d = [v dataUsingEncoding:NSUTF8StringEncoding];
    NSInteger len = [d length];
    [self writeShort:len];
    [data appendData:d];
    length = length + len;
}

- (void)writeBytes:(NSData *)v {
    [data appendData:v];
    NSInteger len = [v length];
    length = length + len;
}

- (NSData *)toByteArray{
    return [[NSData alloc] initWithData:data];
}

@end
