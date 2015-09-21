//
//  CustomAddTemp.m
//  Grill Now
//
//  Created by Yang Shubo on 13-12-31.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//  自定义食物界面

#import "CustomAddTemp.h"
#import "Marcro.h"
#import "DataCenter.h"

@interface CustomAddTemp ()

@end

@implementation CustomAddTemp

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)SetFootType:(FoodType*) food
{
    foodType = food;
}

- (IBAction)btnOK:(id)sender {
}

- (IBAction)btnDelete:(id)sender {
    [[DataCenter getInstance] RemoveCustomTemp:foodType];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnModify:(id)sender {
}

- (IBAction)btnHide:(id)sender {
    if(popInputOwn)
    {
        [popInputOwn resignFirstResponder];
        
      /*  NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
        self.view.frame = rect;
        [UIView commitAnimations];*/
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    navBar.tintColor=RGBMAKE(0x77, 0x6b, 0x5f, 0xFF);
    UIImage* backImage = [UIImage imageNamed:@"back.png"];
    CGRect backframe = CGRectMake(0,0,54,30);
    UIButton* backButton= [[UIButton alloc] initWithFrame:backframe];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(OnBtnChangeBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    navItem.leftBarButtonItem = leftBarButtonItem;
    
    _myFoodName.placeholder = @"my food name";
    _myFoodName.keyboardType = UIKeyboardTypeURL;
    _myFoodName.adjustsFontSizeToFitWidth = YES;
    
    if([[DataCenter getInstance]IsC]){
        [lbRare setPlaceholder:@"30"];
        [lbMedRare setPlaceholder:@"40"];
        [lbMedium setPlaceholder:@"50"];
        [lbWelldone setPlaceholder:@"60"];
        [self.lblRare setText:@"℃"];
        [self.lblMedRare setText:@"℃"];
        [self.lblMedium setText:@"℃"];
        [self.lblWelldone setText:@"℃"];
    }else{
        [lbRare setPlaceholder:[NSString stringWithFormat:@"%d",(int)[[DataCenter getInstance]CConvertF:30.0]]];
        [lbMedRare setPlaceholder:[NSString stringWithFormat:@"%d",(int)[[DataCenter getInstance]CConvertF:40.0]]];
        [lbMedium setPlaceholder:[NSString stringWithFormat:@"%d",(int)[[DataCenter getInstance]CConvertF:50.0]]];
        [lbWelldone setPlaceholder:[NSString stringWithFormat:@"%d",(int)[[DataCenter getInstance]CConvertF:60.0]]];
        [self.lblRare setText:@"℉"];
        [self.lblMedRare setText:@"℉"];
        [self.lblMedium setText:@"℉"];
        [self.lblWelldone setText:@"℉"];
    }
    
    // Do any additional setup after loading the view from its nib.
}


- (NSString *)getUniqueStrByUUID
{
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);//create a new UUID
    
    NSString    *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    
    CFRelease(uuidObj);
    
    return uuidString ;
}

// 这里进行对已创建的自定义食物的数据设置
-(void)viewWillAppear:(BOOL)animated
{
    if(foodType)
    {
        if([[DataCenter getInstance]IsC]){
            lbRare.text = [NSString stringWithFormat:@"%d",(int)foodType.Rare];
            lbMedium.text = [NSString stringWithFormat:@"%d",(int)foodType.Medium];
            lbMedRare.text = [NSString stringWithFormat:@"%d",(int)foodType.MedRare];
            lbWelldone.text = [NSString stringWithFormat:@"%d",(int)foodType.Welldone];
        }else{
            lbRare.text = [NSString stringWithFormat:@"%d",(int)[[DataCenter getInstance]CConvertF:foodType.Rare]];
            lbMedium.text = [NSString stringWithFormat:@"%d",(int)[[DataCenter getInstance]CConvertF:foodType.Medium]];
            lbMedRare.text = [NSString stringWithFormat:@"%d",(int)[[DataCenter getInstance]CConvertF:foodType.MedRare]];
            lbWelldone.text = [NSString stringWithFormat:@"%d",(int)[[DataCenter getInstance]CConvertF:foodType.Welldone]];
        }
        _myFoodName.text = foodType.FoodName;
    }
}

- (void)OnBtnChangeBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)BindFood
{
    if(foodType == nil)
    {  // 自定义食物创建
        foodType = [[FoodType alloc] init];
        foodType.Id = [self getUniqueStrByUUID];
        foodType.FoodName = self.myFoodName.text;// 食物名称
        foodType.icoImageName = @"custom.png";
        foodType.Rare = [lbRare.text floatValue];
        foodType.Medium = [lbMedium.text floatValue];
        foodType.MedRare = [lbMedRare.text floatValue];
        foodType.Welldone = [lbWelldone.text floatValue];
    }
    else
    {   // 这是自定义食物已创建
        foodType.Rare = [lbRare.text floatValue];
        foodType.Medium = [lbMedium.text floatValue];
        foodType.MedRare = [lbMedRare.text floatValue];
        foodType.Welldone = [lbWelldone.text floatValue];
        foodType.FoodName = _myFoodName.text;
    }
    //如果为华氏则转为摄氏
    if(![[DataCenter getInstance]IsC]){
        foodType.Rare = [[DataCenter getInstance]FConvertC:foodType.Rare];
        foodType.Medium =[[DataCenter getInstance]FConvertC:foodType.Medium];
        foodType.MedRare =[[DataCenter getInstance]FConvertC:foodType.MedRare];
        foodType.Welldone=[[DataCenter getInstance]FConvertC:foodType.Welldone];
    }

}

// 点击空白处收起键盘
- (IBAction)btnHideKeyborad:(id)sender {
    if(popInputOwn)
    {
        [popInputOwn resignFirstResponder];
    }
    
    [_myFoodName resignFirstResponder];
}

// OK按钮事件
- (IBAction)OnBtnSave:(id)sender
{ 
    if(foodType == nil)
    {
        [self BindFood];
        [[DataCenter getInstance] AddCustomTemp:foodType]; // 将数据保存在文件中
    }
    else
    {
        [self BindFood];
        [[DataCenter getInstance] ModifyCustomTemp:foodType]; // 修改数据
    }
    [DataCenter getInstance].CurrentFood = nil;
    [[DataCenter getInstance] setCurrentFood:foodType];
    //[DataCenter getInstance].CurrentFood = foodType;
    [DataCenter getInstance].CurrentTempTarget = foodType.Welldone;
    [DataCenter getInstance].CurrentTempName = @"Welldone";
//    [DataCenter getInstance].myFoodName = @"我的食物";
    
    // 数据被改变后发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:MSG_SELECT_FOOD object:foodType];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    //MainPageViewController* ctl = [DataCenter getInstance].MainMenu ;
    //[self.navigationController popToViewController:ctl animated:YES];
    //[self.navigationController pushViewController:ctl animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
    
   
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    popInputOwn = textField;
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    popInputOwn = textField;
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location >= 3)
        return NO; // return NO to not change text
    return YES;
}

@end
