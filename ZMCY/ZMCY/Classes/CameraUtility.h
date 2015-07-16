//
//  CameraUtility.h
//  Ume
//
//  Created by Start on 15/7/9.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CameraUtility : NSObject

+ (BOOL) isCameraAvailable;

+ (BOOL) isRearCameraAvailable;

+ (BOOL) isFrontCameraAvailable;

+ (BOOL) doesCameraSupportTakingPhotos;
+ (BOOL) isPhotoLibraryAvailable;
+ (BOOL) canUserPickVideosFromPhotoLibrary;
+ (BOOL) canUserPickPhotosFromPhotoLibrary;

+ (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType;

@end
