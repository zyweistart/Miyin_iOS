//
//  BaseTabBarViewController.h
//  Ume
//
//  Created by Start on 5/15/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarViewController : UITabBarController

-(UIViewController*)viewControllerWithTabTitle:(NSString*) title image:(UIImage*)image ViewController:(UIViewController*)viewController;

-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage;

@end
