//
//  DataCenter.m
//  Graff Now
//
//  Created by Yang Shubo on 13-8-27.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//


#import "DataCenter.h"
#import "FoodType.h"
#import "Device.h"
#import "AudioToolbox/AudioToolbox.h" 
#import "NSDictionary_JSONExtensions.h"
#import "CJSONSerializer.h"
#define Add2List(__NAME__,__IMAGE__,__TEMP__,__TIME__) ft = [[FoodType alloc] init];ft.icoImageName=__IMAGE__;ft.MaxTemperature = __TEMP__;ft.CookTime = __TIME__;ft.FoodName = __NAME__;[self.FoodList addObject:ft]     

#define Add2RingList(__NAME__,__FILE__) ar = [[AlarmRing alloc] init];ar.RingName=__NAME__;ar.RingFilePath=__FILE__;soundID = 0;AudioServicesCreateSystemSoundID((__bridge CFURLRef)[[NSBundle mainBundle] URLForResource:ar.RingFilePath withExtension: @"aif"], &soundID);ar.RingId=soundID;[self.AlarmRingList addObject:ar]

#define Add2RingIDList(__NAME__,__ID__) ar = [[AlarmRing alloc] init];ar.RingName=__NAME__;ar.RingId=__ID__;[self.AlarmRingList addObject:ar]


@implementation DataCenter
{
    
}

- (id)init
{
    self.IsC = YES;
    self.FoodList = [[NSMutableArray alloc] init];
    self.AlarmRingList = [[NSMutableArray alloc] init];
    self.Temperature = 200;
     
    
    ///[self.FoodList addObject:self.CurrentFood];
    
    [self LoadInnerSetTemp];
    
    AlarmRing* ar;
    //SystemSoundID soundID = 0;
    
    //AudioServicesCreateSystemSoundID((CFURLRef)), &soundID);

    //NSString* name =  [NSString stringWithFormat:@"Ringtone %d",i-1020];
    //NSLog(@"%@",name);
    //Add2RingIDList(name,i);
    ar = [[AlarmRing alloc] init];
    ar.RingName= [NSString stringWithFormat:@"Ringtone %d",1];
    ar.RingId=-1;
    ar.RingFilePath = @"beep alarm1";
    [self.AlarmRingList addObject:ar];
    
    ar = [[AlarmRing alloc] init];
    ar.RingName= [NSString stringWithFormat:@"Ringtone %d",2];
    ar.RingId=-1;
    ar.RingFilePath = @"beep alarm2";
    [self.AlarmRingList addObject:ar];
    
    ar = [[AlarmRing alloc] init];
    ar.RingName= [NSString stringWithFormat:@"Ringtone %d",3];
    ar.RingId=-1;
    ar.RingFilePath = @"beep alarm3";
    [self.AlarmRingList addObject:ar];
    
    
    self.TemperatureAlarm = self.TimerAlarm = [self.AlarmRingList objectAtIndex:0];
    //Add2RingIDList(@"Bloom",1022);
    //Add2RingIDList(@"Bloom",1022);
    //Add2RingIDList(@"Bloom",1022);
    //Add2RingIDList(@"Bloom",1022);
    //Add2RingIDList(@"Bloom",1022);
    //Calypso.caf//Add2RingList(@"Ringtone 3",@"");
    //Add2RingList(@"Ringtone 4",@"");
    //Add2RingList(@"Ringtone 5",@"");
    //Add2RingList(@"Ringtone 6",@"");
    
    self.TimerList = [[NSMutableArray alloc] init];
    return [super init];
}

// 固定食品的数据
-(void)LoadInnerSetTemp
{
    FoodType* ft;
    [self.FoodList removeAllObjects]; // 清空数组
    
    // 设置数据给FoodType，并保存在数组里面
    Add2List(@"fish",@"fish",100,100);self.CurrentFood = ft;
    ft.Rare = 0;
    ft.MedRare = 0;
    ft.Medium = 0;
    ft.Welldone = 72;
    
    ft.isNotMyFood = 1; // 如果大于0就不是自定义食物
    
//    self.CurrentTempName = @"Welldone";
//    self.CurrentTempTarget = 0; // 改变温度，这里是固定值
    
    Add2List(@"turkey",@"turkey.png",110,100);
    ft.Rare = 0;
    ft.MedRare = 0;
    ft.Medium = 0;
    ft.Welldone = 83;
    ft.isNotMyFood = 1; // 如果大于0就不是自定义食物
    
    Add2List(@"beef",@"beef.png",120,120);
    ft.Rare = 52;
    ft.MedRare = 54;
    ft.Medium = 60;
    ft.Welldone = 68;
    ft.isNotMyFood = 1; // 如果大于0就不是自定义食物
    
    Add2List(@"chicken",@"chicken.png",130,130);
    ft.Rare = 0;
    ft.MedRare = 0;
    ft.Medium = 0;
    ft.Welldone = 83;
    ft.isNotMyFood = 1; // 如果大于0就不是自定义食物
    
    Add2List(@"hamburg",@"hamburg.png",140,140);
    ft.Rare = 0;
    ft.MedRare = 0;
    ft.Medium = 0;
    ft.Welldone = 71;
    ft.isNotMyFood = 1; // 如果大于0就不是自定义食物
    
    Add2List(@"lamb",@"lamb.png",150,150);
    ft.Rare = 56;
    ft.MedRare = 60;
    ft.Medium = 70;
    ft.Welldone = 77;
    ft.isNotMyFood = 1; // 如果大于0就不是自定义食物
    
    Add2List(@"pork",@"pork.png",160,160);
    ft.Rare = 0;
    ft.MedRare = 0;
    ft.Medium = 0;
    ft.Welldone = 77;
    ft.isNotMyFood = 1; // 如果大于0就不是自定义食物
    
    Add2List(@"veal",@"veal.png",170,170);
    ft.Rare = 58;
    ft.MedRare = 63;
    ft.Medium = 72;
    ft.Welldone = 77;
    ft.isNotMyFood = 1; // 如果大于0就不是自定义食物
}
// 食物数据的存储（存在self.FoodList中）
-(void)LoadCustomTemp
{
    // 固定食物的数据
    [self LoadInnerSetTemp];
    
    // 创建文件
    NSFileManager* fm = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    // 文件路径
    docDir = [NSString stringWithFormat:@"%@/%@",docDir,@"CustomTemp"];
    // 创建文件夹
    [fm createDirectoryAtPath:docDir withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSArray *files = [fm subpathsAtPath:docDir];
    
    
    for (NSString * file in files) {
        NSString* filePath = [NSString stringWithFormat:@"%@/%@",docDir,file];
//        NSLog(@"Custom File:%@",file);
        FoodType * ft = [[FoodType alloc] init];
        NSData *data = [fm contentsAtPath:filePath];
        NSDictionary* dict = [NSDictionary dictionaryWithJSONData:data error:nil];
        ft.Id = [dict valueForKey:@"Id"];
        ft.icoImageName = [dict valueForKey:@"icoImageName"];
        ft.FoodName = [dict valueForKey:@"FoodName"];
        
        // 这里修改自定义食物的名称
//        ft.FoodName = @"123";
        
        ft.Rare = [[dict valueForKey:@"Rare"] intValue];
        ft.MedRare = [[dict valueForKey:@"MedRare"] intValue];
        ft.Medium = [[dict valueForKey:@"Medium"] intValue];
        ft.Welldone = [[dict valueForKey:@"Welldone"] intValue];
        // 存储的是自定义食物的数据
        [self.FoodList addObject:ft];
    }
}
// 删除文件路径
-(void)RemoveCustomTemp:(FoodType*) food
{
    // 创建文件
    NSFileManager* fm = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    docDir = [NSString stringWithFormat:@"%@/%@/%@.dat",docDir,@"CustomTemp",food.Id];
    [fm removeItemAtPath:docDir error:nil]; // 删除项目路径
}
// 修改
-(void)ModifyCustomTemp:(FoodType*)food
{
    NSFileManager* fm = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    docDir = [NSString stringWithFormat:@"%@/%@",docDir,@"CustomTemp"];
    
    [fm createDirectoryAtPath:docDir withIntermediateDirectories:YES attributes:nil error:nil];
    
    docDir = [NSString stringWithFormat:@"%@/%@.dat",docDir,food.Id];
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary  alloc] init];
    
    [dictionary setValue:food.Id forKey:@"Id"];
    [dictionary setValue:food.icoImageName forKey:@"icoImageName"];
    [dictionary setValue:food.FoodName forKey:@"FoodName"];
    [dictionary setValue:[NSNumber numberWithInt:food.Rare ] forKey:@"Rare"];
    [dictionary setValue:[NSNumber numberWithInt:food.MedRare ] forKey:@"MedRare"];
    [dictionary setValue:[NSNumber numberWithInt:food.Medium ] forKey:@"Medium"];
    [dictionary setValue:[NSNumber numberWithInt:food.Welldone ] forKey:@"Welldone"];
    
    NSError *error = NULL;
    NSData *jsonData = [[CJSONSerializer serializer] serializeObject:dictionary error:&error];
    
    [fm removeItemAtPath:docDir error:nil];
    // 将食物数据存在文件中
    bool result = [fm createFileAtPath:docDir contents:jsonData attributes:nil];
    
    NSLog(@"Save File Result:%d",result);
    //NSData* data = [fm contentsAtPath:docDir];
    
    
}
// 把FoodType的数据到文件
-(void)AddCustomTemp:(FoodType*) food
{
    NSFileManager* fm = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary  alloc] init];
    
    [dictionary setValue:food.Id forKey:@"Id"];
    [dictionary setValue:food.icoImageName forKey:@"icoImageName"];
    [dictionary setValue:food.FoodName forKey:@"FoodName"];
    [dictionary setValue:[NSNumber numberWithInt:food.Rare ] forKey:@"Rare"];
    [dictionary setValue:[NSNumber numberWithInt:food.MedRare ] forKey:@"MedRare"];
    [dictionary setValue:[NSNumber numberWithInt:food.Medium ] forKey:@"Medium"];
    [dictionary setValue:[NSNumber numberWithInt:food.Welldone ] forKey:@"Welldone"];
    
    NSError *error = NULL;
    NSData *jsonData = [[CJSONSerializer serializer] serializeObject:dictionary error:&error];
    
    docDir = [NSString stringWithFormat:@"%@/%@/%@.dat",docDir,@"CustomTemp",food.Id];
    // 将食物数据存在文件中
    [fm createFileAtPath:docDir contents:jsonData attributes:nil];
}
DataCenter* instance;
+(DataCenter*)getInstance
{
    if(instance==nil)
    {
        instance = [[DataCenter alloc] init];
    }
    
    return instance;
}

-(float)ConvertC2F:(float)C
{
//    int i = ((32.6 + C*1.8)*10-2)/10;
//    NSLog(@"温度--1  %0.1f",(32.5 + (C-.05)*1.8f));
//    NSLog(@"温度--2  %0.1f",((32 + (C-0.5)*1.8f)*10+5)/10);
//    return i;
    float i=[self CConvertF:C];
    return i+0.51;
}

-(float)GetTemperature
{
    if(self.IsC)
    {
        return self.Temperature;
    }
    else{
        return [self ConvertC2F:self.Temperature];
    }
}

- (float)CConvertF:(float)C
{
    if(C==0){
        return 0;
    }
    CGFloat fValue=C*9/5+32;
    return fValue;
}

- (float)FConvertC:(float)F
{
    if(F==0){
        return 0;
    }
    CGFloat cValue=(F-32)*5/9;;
    return cValue;
}

@end
