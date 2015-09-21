//
//  FoodSelectViewController.m
//  Graff Now
//
//  Created by Yang Shubo on 13-8-27.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//  食物展示界面

#import "FoodSelectViewController.h"
#import "Marcro.h"
#import "FoodSelectCell.h"
#import "DataCenter.h"
#import "CustomAddTemp.h"

@interface FoodSelectViewController ()

@end

@implementation FoodSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    navigationBar.tintColor=RGBMAKE(0x77, 0x6b, 0x5f, 0xFF);
    UIImage* backImage = [UIImage imageNamed:@"back.png"];
    CGRect backframe = CGRectMake(0,0,54,30);
    UIButton* backButton= [[UIButton alloc] initWithFrame:backframe];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(OnBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    navItem.leftBarButtonItem = leftBarButtonItem;
    UINib *cellNib = [UINib nibWithNibName:@"FoodSelectCell" bundle:nil]; [colView registerNib:cellNib forCellWithReuseIdentifier:@"FoodSelectCell"];
    
    backImage = [UIImage imageNamed:@"plus.png"];
    backframe = CGRectMake(0,0,54,30);
    backButton= [[UIButton alloc] initWithFrame:backframe];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(OnBtnNew:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    navItem.rightBarButtonItem = rightBarButtonItem;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

// 将要打开页面
-(void)viewWillAppear:(BOOL)animated
{
    // [DataCenter getInstance] 初始化
    [[DataCenter getInstance] LoadCustomTemp];
    [colView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [DataCenter getInstance].FoodList.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FoodSelectCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FoodSelectCell" forIndexPath:indexPath];
    
    // cell在数组FoodList中取值（问题所在）
    FoodType * ft = [[DataCenter getInstance].FoodList objectAtIndex:indexPath.row];
    if(cell==nil)
    {
        FoodType * t = [[DataCenter getInstance].FoodList objectAtIndex:indexPath.row];
        cell = [[FoodSelectCell alloc] initWithFoodType:t];

    }
    else
    {
        [cell BindObject:ft];

    }
    
    return cell;
}



// 点击cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    FoodType * ft = [[DataCenter getInstance].FoodList objectAtIndex:indexPath.row];
    
    if(ft.Id==nil)
    {
        // 点击该cell返回上个页面
        // KVO，观察标示名：MSG_SELECT_FOOD，如果变化将发送通知，调用某个方法，传递的参数是ft
        [[NSNotificationCenter defaultCenter] postNotificationName:MSG_SELECT_FOOD object:ft];
        [DataCenter getInstance].CurrentFood = ft;
        [DataCenter getInstance].CurrentTempTarget = ft.Welldone;
        [DataCenter getInstance].CurrentTempName = @"Welldone";
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {   // 点击改cell进入自定义食物设定界面
        CustomAddTemp* temp = [[CustomAddTemp alloc] init];
        [temp SetFootType:ft];
        [self.navigationController pushViewController:temp animated:YES];
        
        //[self.navigationController pushViewController:temp animated:YES];
    }
    //[self.navigationController popToRootViewControllerAnimated:YES];
    //[self.navigationController popViewControllerAnimated:YES];
  
}

//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    cell.alpha = 0.5;
}


// 点击加好按钮事件
-(IBAction)OnBtnNew:(id)sender
{
    CustomAddTemp * temp = [[CustomAddTemp alloc] init];
    [self.navigationController pushViewController:temp animated:YES];

}

// 返回按钮
- (IBAction)OnBtnBack:(id)sender {
    
//    [DataCenter getInstance].CurrentTempTarget = self.myCurrentTempTarget;
    [DataCenter getInstance].CurrentTempName = @"Welldone";
    [self.navigationController popViewControllerAnimated:YES];
}

@end
