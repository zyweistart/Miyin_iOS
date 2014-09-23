//
//  CustomAnnotation.m
//  MapDemo
//
//  Created by rongfzh on 12-6-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation
@synthesize coordinate, title, subtitle;

-(id) initWithCoordinate:(CLLocationCoordinate2D) coords
{
	if (self = [super init]) {
		coordinate = coords;
	}
	return self;
}
@end

