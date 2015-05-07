//
//  HomeBannerView.m
//  DLS
//
//  Created by Start on 3/11/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "HomeBannerView.h"
#import "UIButton+TitleImage.h"
#import "ListViewController.h"
#import "VIPViewController.h"
#import "ETFoursquareImages.h"

#define TITLE1COLOR  [UIColor colorWithRed:(76/255.0) green:(121/255.0) blue:(206/255.0) alpha:1]
#define TITLECOLOR  [UIColor colorWithRed:(124/255.0) green:(124/255.0) blue:(124/255.0) alpha:1]

@implementation HomeBannerView{
    NSDictionary *data;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        CGRectMake(0, 0, 320, 270)
        int IMAGEHEIGHT=120;
        ETFoursquareImages *foursquareImages = [[ETFoursquareImages alloc] initWithFrame:CGRectMake1(0, 0, 320,IMAGEHEIGHT)];
        [foursquareImages setImagesHeight:CGHeight(IMAGEHEIGHT)];
        [self addSubview:foursquareImages];
        NSMutableArray *images=[[NSMutableArray alloc]init];
        //如果不够则加载默认的图片
        if([images count]==0){
            for(int i=0;i<3;i++){
                [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"image%d",i+1]]];
            }
        }
        [foursquareImages setImages:images];
        
        UIView *mainFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, IMAGEHEIGHT, 320, 200)];
        [mainFrame setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:mainFrame];
        [self addModel:@"autocrane_i" Title:@"汽车吊求租" Frame:mainFrame Tag:1 X:5 Y:5 Title2:@"有求必应" Title3:@"各类汽车吊等你来租"];
        [self addModel:@"autocrane_o" Title:@"汽车吊出租" Frame:mainFrame Tag:5 X:160 Y:5 Title2:@"海量推送" Title3:@"各类汽车吊即刻出租"];
        [self addModel:@"crawlercrane_i" Title:@"履带吊求租" Frame:mainFrame Tag:2 X:5 Y:70 Title2:@"有求必应" Title3:@"各类履带吊等你来租"];
        [self addModel:@"crawlercrane_o" Title:@"履带吊出租" Frame:mainFrame Tag:6 X:160 Y:70 Title2:@"海量推送" Title3:@"各类履带吊即刻出租"];
        [self addModel:@"vip" Title:@"塔吊求租" Frame:mainFrame Tag:3 X:5 Y:135 Title2:@"有求必应" Title3:@"各类塔吊等你来租"];
        [self addModel:@"tender" Title:@"塔吊出租" Frame:mainFrame Tag:7 X:160 Y:135 Title2:@"海量推送" Title3:@"各类塔吊即刻出租"];
        
        
//        [self addModel:@"autocrane_i" Title:@"汽车吊求租" Frame:mainFrame Tag:1 X:0 Y:0];
//        [self addModel:@"crawlercrane_i" Title:@"履带吊求租" Frame:mainFrame Tag:2 X:80 Y:0];
//        [self addModel:@"vip" Title:@"VIP独家项目" Frame:mainFrame Tag:3 X:160 Y:0];
//        [self addModel:@"engineering_i" Title:@"工程信息" Frame:mainFrame Tag:4 X:240 Y:0];
//        [self addModel:@"autocrane_o" Title:@"汽车吊出租" Frame:mainFrame Tag:5 X:0 Y:90];
//        [self addModel:@"crawlercrane_o" Title:@"履带吊出租" Frame:mainFrame Tag:6 X:80 Y:90];
//        [self addModel:@"tender" Title:@"招标公告" Frame:mainFrame Tag:7 X:160 Y:90];
//        [self addModel:@"recruitment" Title:@"招聘信息" Frame:mainFrame Tag:8 X:240 Y:90];
        
        data=[[NSDictionary alloc]initWithObjectsAndKeys:
              @"汽车吊求租",@"1",
              @"履带吊求租",@"2",
              @"VIP独家项目",@"3",
              @"工程信息",@"4",
              @"汽车吊出租",@"5",
              @"履带吊出租",@"6",
              @"招标公告",@"7",
              @"招聘信息",@"8",
              @"塔吊求租",@"3",
              @"塔吊出租",@"7",nil];
        
    }
    return self;
}

- (void)addModel:(NSString*)image Title:(NSString*)title Frame:(UIView*)frame Tag:(NSUInteger)tag X:(CGFloat)x Y:(CGFloat)y Title2:(NSString*)title2 Title3:(NSString*)title3
{
//    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake1(x, y, 80, 90)];
//    [button setTitle:title forImage:[UIImage imageNamed:image]];
//    [button setTitleColor:TITLECOLOR forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(goToMain:) forControlEvents:UIControlEventTouchUpInside];
//    button.tag=tag;
//    [frame addSubview:button];
    UIImageView *view=[[UIImageView alloc]initWithFrame:CGRectMake1(x, y, 150, 60)];
    view.tag=tag;
    [view setUserInteractionEnabled:YES];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                initWithTarget:self action:@selector(goToMain:)]];
    [view setImage:[UIImage imageNamed:@"dh"]];
    UIImageView *uiimage=[[UIImageView alloc]initWithFrame:CGRectMake1(2, 10, 40, 40)];
    [uiimage setImage:[UIImage imageNamed:image]];
    [view addSubview:uiimage];
    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(44, 5, 106, 20)];
    [lbl setText:title];
    [lbl setFont:[UIFont systemFontOfSize:16]];
    [lbl setTextColor:TITLE1COLOR];
    [view addSubview:lbl];
    lbl=[[UILabel alloc]initWithFrame:CGRectMake1(44, 25, 106, 15)];
    [lbl setText:title2];
    [lbl setFont:[UIFont systemFontOfSize:11]];
    [lbl setTextColor:TITLECOLOR];
    [view addSubview:lbl];
    lbl=[[UILabel alloc]initWithFrame:CGRectMake1(44, 40, 106, 15)];
    [lbl setText:title3];
    [lbl setFont:[UIFont systemFontOfSize:11]];
    [lbl setTextColor:TITLECOLOR];
    [view addSubview:lbl];
    
    [frame addSubview:view];
}

- (void)goToMain:(UITapGestureRecognizer*)sender {
    int tag=[sender.view tag];
    if(tag==1||tag==2||tag==5||tag==6||tag==3||tag==7){
        [self.controller.navigationController pushViewController:[[VIPViewController alloc]initWithType:tag] animated:YES];
    }else{
        [self.controller.navigationController pushViewController:[[ListViewController alloc]initWithTitle:[data objectForKey:[NSString stringWithFormat:@"%d",tag]] Type:tag] animated:YES];
    }
}
@end
