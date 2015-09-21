//
//  Sensors.h
//  Conlib-Tester
//
//  Created by Ole Andreas Torvmark on 10/2/12.
//  Copyright (c) 2012 Texas Instruments All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  sensorC953A: NSObject

///Calibration values unsigned
@property UInt16 c1,c2,c3,c4;
///Calibration values signed
@property int16_t c5,c6,c7,c8;

-(id) initWithCalibrationData:(NSData *)data;

-(int) calcPressure:(NSData *)data;


@end



@interface sensorIMU3000: NSObject

@property float lastX,lastY,lastZ;
@property float calX,calY,calZ;

#define IMU3000_RANGE 500.0

-(id) init;

-(void) calibrate;
-(float) calcXValue:(NSData *)data;
-(float) calcYValue:(NSData *)data;
-(float) calcZValue:(NSData *)data;
+(float) getRange;

@end

@interface sensorKXTJ9 : NSObject

#define KXTJ9_RANGE 4.0

+(float) calcXValue:(NSData *)data;
+(float) calcYValue:(NSData *)data;
+(float) calcZValue:(NSData *)data;
+(float) getRange;

@end

@interface sensorMAG3110 : NSObject

@property float lastX,lastY,lastZ;
@property float calX,calY,calZ;

#define MAG3110_RANGE 2000.0

-(id) init;
-(void) calibrate;
-(float) calcXValue:(NSData *)data;
-(float) calcYValue:(NSData *)data;
-(float) calcZValue:(NSData *)data;
+(float) getRange;

@end

@interface sensorTMP006 : NSObject



+(float) calcTAmb:(NSData *)data;
+(float) calcTObj:(NSData *)data;
@end

@interface sensorSHT21 : NSObject

+(float) calcPress:(NSData *)data;
+(float) calcTemp:(NSData *)data;

@end