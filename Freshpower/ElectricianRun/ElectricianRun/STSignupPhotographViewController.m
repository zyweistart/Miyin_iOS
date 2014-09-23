//
//  STSignupPhotographViewController.m
//  ElectricianRun
//
//  Created by Start on 3/6/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STSignupPhotographViewController.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

#define ORIGINAL_MAX_WIDTH 640.0f
#define SUBMITREQUESTCODE 100000


@interface STSignupPhotographViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, VPImageCropperDelegate>

@end

@implementation STSignupPhotographViewController {
    NSInteger selectIndex;
    UIImageView *photographIDImageView;
    UIImageView *photographELImageView;
    BOOL identityImg;
    BOOL elecImg;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"电工注册";
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"提交"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(submit:)];
        identityImg=NO;
        elecImg=NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 64, 320, 332)];
    [self.view addSubview:control];
    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, 60, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"身份证图片"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    photographIDImageView=[[UIImageView alloc]initWithFrame:CGRectMake(122, 40, 76, 76)];
    [photographIDImageView setImage:[UIImage imageNamed:@"nophoto"]];
    [photographIDImageView setUserInteractionEnabled:YES];
    photographIDImageView.tag=1;
    [photographIDImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photograph:)]];
    [control addSubview:photographIDImageView];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(15, 126, 60, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"电工证图片"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    photographELImageView=[[UIImageView alloc]initWithFrame:CGRectMake(122, 166, 76, 76)];
    [photographELImageView setImage:[UIImage imageNamed:@"nophoto"]];
    [photographELImageView setUserInteractionEnabled:YES];
    photographELImageView.tag=2;
    [photographELImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photograph:)]];
    [control addSubview:photographELImageView];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 262, 280, 60)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"       照片需为用户本人手持证件拍摄，身份证、电工证上的所有信息清晰可见，必须能看清证件号。照片需免冠，建议未化妆，手持证件人的五官清晰可见。照片内容真实有效，不得做任何修改。"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setNumberOfLines:0];
    [control addSubview:lbl];
}

- (void)photograph:(UITapGestureRecognizer*)tgr
{
    selectIndex=((UIImageView*)tgr.view).tag;
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)submit:(id)sender
{
    if(!identityImg){
        [Common alert:@"请拍摄身份证件"];
        return;
    }
    if(!elecImg){
        [Common alert:@"请拍摄电工证件"];
        return;
    }
    
    NSData *idPicDataPath=UIImagePNGRepresentation([photographIDImageView image]);
    NSData *elPicDataPath=UIImagePNGRepresentation([photographELImageView image]);
    
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:self.name forKey:@"name"];//姓名
    [p setObject:self.phone forKey:@"telNum"];//手机号码
    [p setObject:self.card forKey:@"identityNo"];//身份证号码
    [p setObject:self.address forKey:@"intentArea"];//意向工作地区
    [p setObject:idPicDataPath forKey:@"identityImg"];
    [p setObject:elPicDataPath forKey:@"elecImg"];
    [p setObject:@"1" forKey:@"operateType"];
    [p setObject:self.province forKey:@"province"];
    [p setObject:self.city forKey:@"city"];
    [p setObject:self.area forKey:@"area"];

    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:SUBMITREQUESTCODE];
    [self.hRequest setIsBodySubmit:YES];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest start:URLelecRegister params:p];
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode
{
    if(repCode==SUBMITREQUESTCODE){
        NSString *result=[[response resultJSON]objectForKey:@"rs"];
        if([@"1" isEqualToString:result]){
            [Common alert:@"注册成功，信息已提交！"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else if([@"-1" isEqualToString:result]){
            [Common alert:@"注册失败，请稍候再试！"];
        }else{
            [Common alert:@"未知异常"];
        }
    }
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    if(selectIndex==1){
        photographIDImageView.image = editedImage;
        identityImg=YES;
    }else if(selectIndex==2){
        photographELImageView.image = editedImage;
        elecImg=YES;
    }
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
//    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
    return NO;
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

@end
