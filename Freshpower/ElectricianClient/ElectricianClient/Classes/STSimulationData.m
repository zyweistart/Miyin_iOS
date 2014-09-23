//
//  STSimulationData.m
//  ElectricianClient
//
//  Created by Start on 3/28/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STSimulationData.h"

@implementation STSimulationData

//负荷值
float burdenRandoms[10][24]={
    {1244.13,1234.83,1156.34 , 1255.29 , 1273.52 , 1056.14 , 1142.30 , 1293.07 , 1332.72 , 1226.96 , 1283.67 , 1216.52 , 1271.54 , 1274.38 , 1402.97 , 1022.01 , 1396.59 , 1061.62 , 1158.14 , 1182.62 , 1153.33 , 1181.36 , 1181.27 , 1338.01 },
    {1114.60 , 1291.67 , 1145.66 , 1279.11 , 1117.72 , 1108.46 , 1127.37 , 1325.82 , 1196.61 , 1113.62 , 1270.27 , 1312.67 , 1277.92 , 1302.57 , 966.15 , 1227.97 , 1436.14 , 1224.59 , 1318.40 , 1295.61 , 1230.68 , 1212.17 , 1193.72 , 1283.84 },
    {1089.78 , 1195.35 , 1142.26 , 1189.38 , 1057.26 , 1240.33 , 1081.97 , 1318.37 , 1336.96 , 1308.89 , 1077.05 , 1371.09 , 1065.95 , 973.90 , 963.94 , 1173.88 , 1047.22 , 1303.83 , 1023.17 , 1273.35 , 1096.84 , 1339.20 , 1217.62 , 1297.70 },
    {1241.61 , 1232.02 , 1250.25 , 1117.63 , 1176.37 , 1058.59 , 1066.78 , 1293.13 , 1081.17 , 1437.73 , 1187.23 , 1108.10 , 1255.90 , 1359.08 , 1021.86 , 1224.64 , 1297.02 , 1283.12 , 1041.02 , 1259.90 , 1076.40 , 1186.19 , 1198.88 , 1073.74 },
    {1254.24 , 1175.67 , 1328.06 , 1101.99 , 1241.85 , 1300.24 , 1203.67 , 1130.01 , 1199.78 , 1256.77 , 1019.58 , 1366.10 , 1210.54 , 1241.59 , 1348.23 , 1380.88 , 1056.17 , 1237.50 , 1221.76 , 1147.19 , 1116.03 , 1192.76 , 1180.19 , 1287.20 },
    {1303.92 , 1186.39 , 1098.97 , 1249.51 , 1235.93 , 1233.28 , 1249.73 , 1278.04 , 1169.38 , 1394.13 , 1339.11 , 1255.76 , 1421.88 , 1228.94 , 1044.84 , 1268.38 , 1381.61 , 1315.12 , 1386.56 , 1240.96 , 1334.13 , 1085.66 , 1172.01 , 1214.71 },
    {1173.04 , 1321.47 , 1254.16 , 1056.88 , 1102.63 , 1303.47 , 1148.80 , 1155.97 , 1180.06 , 1230.40 , 1217.03 , 1171.01 , 1326.10 , 1325.81 , 1190.71 , 1097.44 , 1169.05 , 1267.13 , 991.67 , 1292.44 , 1138.99 , 1152.94 , 1255.66 , 1118.11 },
    {1337.36 , 1201.85 , 1257.08 , 1181.75 , 1307.76 , 1185.47 , 1152.32 , 1138.30 , 1330.32 , 1168.33 , 1279.63 , 1209.50 , 1416.76 , 1055.05 , 1323.01 , 1321.04 , 1353.00 , 1037.87 , 1095.60 , 1267.24 , 1178.40 , 1149.48 , 1191.23 , 1339.85 },
    {1110.26 , 1149.26 , 1301.18 , 1088.93 , 1174.29 , 1179.90 , 1093.26 , 1305.82 , 1102.35 , 1387.12 , 1231.51 , 1039.13 , 1419.58 , 1049.38 , 1430.92 , 1238.82 , 1012.46 , 1205.46 , 1342.90 , 1234.79 , 1190.22 , 1133.92 , 1178.75 , 1058.23 },
    {1312.14 , 1065.39 , 1248.68 , 1149.04 , 1068.37 , 1263.63 , 1060.09 , 1327.16 , 1077.20 , 1391.38 , 1062.00 , 1205.61 , 1003.05 , 1266.73 , 1429.69 , 1257.94 , 1199.26 , 1016.95 , 1370.93 , 1228.27 , 1199.03 , 1249.14 , 1065.11 , 1283.64}
};
//电量电费
float electricityRandoms[24]={1244.13 , 1234.83 , 1156.34 , 1255.29 ,1273.52 , 1056.14 , 1142.30 , 1293.07 , 1332.72 , 1226.96 , 1283.67 ,1216.52 , 1271.54 , 1274.38 , 1402.97 , 1022.01 , 1396.59 , 1061.62 ,
    1158.14 , 1182.62 , 1153.33 , 1181.36 , 1181.27 , 1338.01};

//根据当前时间获取负荷随机数据
+ (NSMutableArray *)getRandomChargeData
{
    int r=arc4random() % 10;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    int hour=[[formatter stringFromDate:[NSDate date]] intValue];
    NSMutableArray *v=[[NSMutableArray alloc]init];
    for(int i=0;i<24;i++){
        if(i<hour){
            [v addObject:[[NSNumber alloc]initWithFloat:burdenRandoms[r][i]]];
        }
    }
    return v;
}

+ (NSMutableArray *)getElectricityData
{
    NSMutableArray *v=[[NSMutableArray alloc]init];
    for(int i=0;i<24;i++){
        [v addObject:[[NSNumber alloc]initWithFloat:electricityRandoms[i]]];
    }
    return v;
}

//随机产生出线系数的数组
+ (NSMutableArray*)getOutScale
{
    double scaleArr[6][6]={
        {0.18,0.34,0.48,0.22,0.31,0.47},
        {0.22,0.31,0.47,0.19,0.33,0.48},
        {0.19,0.33,0.48,0.22,0.31,0.47},
        {0.21,0.31,0.48,0.22,0.32,0.46},
        {0.22,0.32,0.46,0.2,0.31,0.49},
        {0.2,0.31,0.49,0.18,0.34,0.48}
    };
    int rand=arc4random() % 6;
    NSMutableArray *v=[[NSMutableArray alloc]init];
    for(int i=0;i<6;i++){
        [v addObject:[[NSNumber alloc]initWithFloat:scaleArr[rand][i]]];
    }
    return v;
}

//随机产生进行系数的数组
+ (NSMutableArray*)getInScale
{
    double scaleArr[6][2] ={
        {0.55,0.45},
        {0.56,0.44},
        {0.54,0.46},
        {0.53,0.47},
        {0.52,0.48},
        {0.57,0.43}
    };
    int rand=arc4random() % 6;
    NSMutableArray *v=[[NSMutableArray alloc]init];
    for(int i=0;i<2;i++){
        [v addObject:[[NSNumber alloc]initWithFloat:scaleArr[rand][i]]];
    }
    return v;
}

//随机产生平均电价
+ (double)getBeforeAveragePrice
{
    double averagePriceArr[5] = {0.8,0.9,1.0,1.1,1.2};
    int rand=arc4random() % 3;
    return averagePriceArr[rand];
}


+ (NSString *)getSimpleLineName:(int)index
{
    if(index==0){
        return @"B1";
    }else if(index==1){
        return @"B1-1";
    }else if(index==2){
        return @"B1-2";
    }else if(index==3){
        return @"B1-3";
    }else if(index==4){
        return @"B2";
    }else if(index==5){
        return @"B2-1";
    }else if(index==6){
        return @"B2-2";
    }else {
        return @"B2-3";
    }
}

+ (NSString *)getLineName:(int)index
{
    if(index==0){
        return @"进线B1";
    }else if(index==1){
        return @"出线B1-1";
    }else if(index==2){
        return @"出线B1-2";
    }else if(index==3){
        return @"出线B1-3";
    }else if(index==4){
        return @"进线B2";
    }else if(index==5){
        return @"出线B2-1";
    }else if(index==6){
        return @"出线B2-2";
    }else {
        return @"出线B2-3";
    }
}

+ (NSString *)getChildLineName:(int)index
{
    if(index==0){
        return @"出线B1-1";
    }else if(index==1){
        return @"出线B1-2";
    }else if(index==2){
        return @"出线B1-3";
    }else if(index==3){
        return @"出线B2-1";
    }else if(index==4){
        return @"出线B2-2";
    }else if(index==5){
        return @"出线B2-3";
    }else {
        return @"未知";
    }
}

@end
