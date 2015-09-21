//
//  FootTemperatureList.m
//  Grill Now
//
//  Created by Yang Shubo on 13-9-4.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import "FootTemperatureList.h"
#import "DataCenter.h"
@interface FootTemperatureList ()

@end

@implementation FootTemperatureList

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithFood:(FoodType*)food
{
    foodType = food;
    return [self init];
}
-(void)viewWillAppear:(BOOL)animated
{
    if(foodType!=nil)
    {
        if(foodType.Rare!=0)
        {
            [self setLabel:lbRare Content:foodType.Rare];
        }
        if(foodType.MedRare!=0)
        {
            [self setLabel:lbMedRare Content:foodType.MedRare];
        }
        if(foodType.Medium!=0)
        {
            [self setLabel:lbMedium Content:foodType.Medium];
        }
        if(foodType.Welldone!=0)
        {
            [self setLabel:lbWelldone  Content:foodType.Welldone];
        }
    }
    
    //[self viewWillAppear:animated];
}
-(void)setLabel:(UILabel*)lb Content:(float)content
{
    if([DataCenter getInstance].IsC){
        lb.text =[NSString stringWithFormat:@"%d℃",(int)content];
    }
    else{
        lb.text =[NSString stringWithFormat:@"%d℉",(int)[[DataCenter getInstance] ConvertC2F:content]];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
- (IBAction)OnBtnCancel:(id)sender {
    
    [self.view removeFromSuperview];
}

- (IBAction)OnRareBtn:(id)sender {
    
    if(foodType.Rare<=0)
        return;
    
    [DataCenter getInstance].CurrentTempName = @"Rare";
    [DataCenter getInstance].CurrentTempTarget = foodType.Rare;
    [[NSNotificationCenter defaultCenter] postNotificationName:MSG_ONTARGETTEMP object:nil];
    [self.view removeFromSuperview];
}

- (IBAction)OnMediumBtn:(id)sender {
    if(foodType.Medium<=0)
        return;
    [DataCenter getInstance].CurrentTempName = @"Medium";
    [DataCenter getInstance].CurrentTempTarget = foodType.Medium;
    [[NSNotificationCenter defaultCenter] postNotificationName:MSG_ONTARGETTEMP object:nil];
    
    [self.view removeFromSuperview];

}

- (IBAction)OnWelldoneBtn:(id)sender {
    if(foodType.Welldone<=0)
        return;
    [DataCenter getInstance].CurrentTempName = @"Welldone";
    [DataCenter getInstance].CurrentTempTarget = foodType.Welldone;
    [[NSNotificationCenter defaultCenter] postNotificationName:MSG_ONTARGETTEMP object:nil];
    
    [self.view removeFromSuperview];

}

- (IBAction)OnMedRareBtn:(id)sender {
    if(foodType.MedRare<=0)
        return;
    [DataCenter getInstance].CurrentTempName = @"MedRare";
    [DataCenter getInstance].CurrentTempTarget = foodType.MedRare;
    [[NSNotificationCenter defaultCenter] postNotificationName:MSG_ONTARGETTEMP object:nil];
    
    [self.view removeFromSuperview];
}
@end
