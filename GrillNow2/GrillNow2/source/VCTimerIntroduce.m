//
//  VCTimerIntroduce.m
//  Grill Now
//
//  Created by Yang Shubo on 14-3-17.
//  Copyright (c) 2014年 Yang Shubo. All rights reserved.
//

#import "VCTimerIntroduce.h"

@interface VCTimerIntroduce ()

@end

@implementation VCTimerIntroduce

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        curIndex = 0;
        // Custom initialization
    }
    return self;
}
- (IBAction)onBtnNext:(id)sender {
    curIndex++;
    if([self loadStep:curIndex]==NO)
    {
        [self.view removeFromSuperview];
    }
}

-(id)initWithView:(NSArray*) views Images:(NSArray*)images
{
    
    NSString *homeDictionary = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];//获取根目录
    NSString *homePath  = [homeDictionary stringByAppendingPathComponent:@"introduce.dat"];//添加储存的文件名
    id data = [NSKeyedUnarchiver unarchiveObjectWithFile:homePath];
    if(data == 0)
    {
        
        [NSKeyedArchiver archiveRootObject:@"Introduce" toFile:homePath];
        view = [NSArray arrayWithArray:views];
        imgs = [NSArray arrayWithArray:images];
        
        return  [self init];
    }
    else
    {
        return nil;
    }
   
}
-(BOOL)loadStep:(NSInteger)index
{
    
    if(view.count>index && imgs.count>index)
    {
        if(curImage != nil)
        {
            [curImage removeFromSuperview];
            curImage = nil;
        }
        curImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[imgs objectAtIndex:index]]];
        
        CGRect rect = ((UIView*)[view objectAtIndex:index]).frame;
        
        rect.origin.x += rect.size.width/2;
        rect.origin.y += rect.size.height/2;
        
        CGRect rectImage = curImage.frame;
        
        rectImage.origin = rect.origin;

        rectImage.origin.x -= rectImage.size.width/2;
        rectImage.origin.y -= rectImage.size.height/2;
        //rectImage.origin.y += rectImage.size.height/2;
        
        curImage.frame = rectImage;
        [self.view addSubview:curImage];
        
        return YES;
    }
    
    return NO;
}
- (void)viewDidLoad
{
    [self loadStep:0];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
