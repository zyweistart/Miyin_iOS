//
//  FoodSelectViewController.h
//  Graff Now
//
//  Created by Yang Shubo on 13-8-27.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodSelectViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    IBOutlet UINavigationBar *navigationBar;
    
    IBOutlet UICollectionView *colView;
    IBOutlet UINavigationItem *navItem;
}

@property (nonatomic,assign) int myCurrentTempTarget;

- (IBAction)OnBtnBack:(id)sender;
-(IBAction)OnBtnNew:(id)sender;


@end
