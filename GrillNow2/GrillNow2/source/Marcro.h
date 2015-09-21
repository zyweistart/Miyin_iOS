//
//  Marcro.h
//  Graff Now
//
//  Created by Yang Shubo on 13-8-27.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#ifndef Graff_Now_Marcro_h
#define Graff_Now_Marcro_h

#define RGBMAKE(__R__,__G__,__B__,__A__) [UIColor colorWithRed:((float)__R__)/((float)255) green:((float)__G__)/((float)255) blue:((float)__B__)/((float)255) alpha:((float)__A__)/((float)255)]

#define MAKEARGB(__A__,__R__,__G__,__B__) [UIColor colorWithRed:((float)__R__)/((float)255) green:((float)__G__)/((float)255) blue:((float)__B__)/((float)255) alpha:((float)__A__)/((float)255)]

#define MAKERGB(__R__,__G__,__B__) MAKEARGB(255,__R__,__G__,__B__)


#define MSG_SELECT_FOOD @"MSG_SELECT_FOOD"

#endif
