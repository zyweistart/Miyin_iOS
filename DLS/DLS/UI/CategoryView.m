//
//  CategoryView.m
//  DLS
//
//  Created by Start on 3/6/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "CategoryView.h"
#define LINECOLOR [UIColor colorWithRed:(226/255.0) green:(226/255.0) blue:(226/255.0) alpha:1]
#define TITLECOLOR [UIColor colorWithRed:(111/255.0) green:(111/255.0) blue:(111/255.0) alpha:1]
#define CATEGORYBGCOLOR [UIColor colorWithRed:(94/255.0) green:(144/255.0) blue:(237/255.0) alpha:1]

@implementation CategoryView{
    
}

- (id)initWithFrame:(CGRect)rect Title1:(NSString*)title1 Titlte2:(NSString*)title2 Title3:(NSString*)title3 Title4:(NSString*)title4{
    self=[super initWithFrame:rect];
    if(self){
        //CGRectMake1(0, 0, 320, 40)
        UIView *categoryFrame=[[UIView alloc]initWithFrame:rect];
        [self addSubview:categoryFrame];
        self.button1=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 79, 39)];
        [[self.button1 titleLabel]setFont:[UIFont systemFontOfSize:14]];
        [self.button1 setTitle:title1 forState:UIControlStateNormal];
        self.button1.tag=1;
        [self.button1 addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventTouchUpInside];
        [categoryFrame addSubview:self.button1];
        self.button2=[[UIButton alloc]initWithFrame:CGRectMake1(80, 0, 79, 39)];
        [[self.button2 titleLabel]setFont:[UIFont systemFontOfSize:14]];
        [self.button2 setTitle:title2 forState:UIControlStateNormal];
        self.button2.tag=2;
        [self.button2 addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventTouchUpInside];
        [categoryFrame addSubview:self.button2];
        self.button3=[[UIButton alloc]initWithFrame:CGRectMake1(160, 0, 79, 39)];
        [[self.button3 titleLabel]setFont:[UIFont systemFontOfSize:14]];
        [self.button3 setTitle:title3 forState:UIControlStateNormal];
        self.button3.tag=3;
        [self.button3 addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventTouchUpInside];
        [categoryFrame addSubview:self.button3];
        self.button4=[[UIButton alloc]initWithFrame:CGRectMake1(240, 0, 80, 39)];
        [[self.button4 titleLabel]setFont:[UIFont systemFontOfSize:14]];
        [self.button4 setTitle:title4 forState:UIControlStateNormal];
        self.button4.tag=4;
        [self.button4 addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventTouchUpInside];
        [categoryFrame addSubview:self.button4];
        UIView *line1=[[UIView alloc]initWithFrame:CGRectMake1(79, 0, 1, 39)];
        [line1 setBackgroundColor:LINECOLOR];
        [categoryFrame addSubview:line1];
        UIView *line2=[[UIView alloc]initWithFrame:CGRectMake1(159, 0, 1, 39)];
        [line2 setBackgroundColor:LINECOLOR];
        [categoryFrame addSubview:line2];
        UIView *line3=[[UIView alloc]initWithFrame:CGRectMake1(239, 0, 1, 39)];
        [line3 setBackgroundColor:LINECOLOR];
        [categoryFrame addSubview:line3];
        UIView *line4=[[UIView alloc]initWithFrame:CGRectMake1(0, 39, 320, 1)];
        [line4 setBackgroundColor:LINECOLOR];
        [categoryFrame addSubview:line4];
    }
    return self;
}

- (void)setIndex:(long long)i
{
    self.currentIndex=i;
    [self changeStatus];
}

- (void)switchCategory:(UIButton*)sender {
    self.currentIndex=sender.tag;
    [self changeStatus];
}

- (void)changeStatus{
    if([self.delegate CategoryViewChange:self.currentIndex]){
        [self.button1 setTitleColor:self.currentIndex==1?[UIColor whiteColor]:TITLECOLOR forState:UIControlStateNormal];
        [self.button1 setBackgroundColor:self.currentIndex==1?CATEGORYBGCOLOR:[UIColor whiteColor]];
        [self.button2 setTitleColor:self.currentIndex==2?[UIColor whiteColor]:TITLECOLOR forState:UIControlStateNormal];
        [self.button2 setBackgroundColor:self.currentIndex==2?CATEGORYBGCOLOR:[UIColor whiteColor]];
        [self.button3 setTitleColor:self.currentIndex==3?[UIColor whiteColor]:TITLECOLOR forState:UIControlStateNormal];
        [self.button3 setBackgroundColor:self.currentIndex==3?CATEGORYBGCOLOR:[UIColor whiteColor]];
        [self.button4 setTitleColor:self.currentIndex==4?[UIColor whiteColor]:TITLECOLOR forState:UIControlStateNormal];
        [self.button4 setBackgroundColor:self.currentIndex==4?CATEGORYBGCOLOR:[UIColor whiteColor]];
    }
}

@end
