//
//  STCalculateViewController.m
//  ElectricianRun
//  在线计算
//  Created by Start on 1/24/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STCalculateViewController.h"

@interface STCalculateViewController ()

@end

@implementation STCalculateViewController {
    
    NSInteger currentRow;
    
    NSArray *selectData;
    
    UIImageView *ivImage;
    
    UILabel *lblValue1;
    UILabel *lblValue2;
    UILabel *lblValue3;
    UILabel *lblValue4;
    
    UITextField *txtValue1;
    UITextField *txtValue2;
    UITextField *txtValue3;
    UITextField *txtValue4;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    selectData=[[NSArray alloc]initWithObjects:
                @"倍率",@"电量",@"功率因数",
                @"有功功率", @"无功功率", @"负荷率",
                @"变压器负载率",@"视在功率", nil];
    
    UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 64, 320, 280)];
    [control addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:control];
    
    ivImage=[[UIImageView alloc]init];
    [control addSubview:ivImage];
    
    //值1
    lblValue1=[[UILabel alloc]initWithFrame:CGRectMake(10, 80, 80, 30)];
    lblValue1.font=[UIFont systemFontOfSize:12.0];
    [lblValue1 setTextColor:[UIColor blackColor]];
    [lblValue1 setBackgroundColor:[UIColor clearColor]];
    [lblValue1 setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lblValue1];
    
    txtValue1=[[UITextField alloc]initWithFrame:CGRectMake(100, 80, 150, 30)];
    [txtValue1 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValue1 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValue1 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValue1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValue1 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValue1 setKeyboardType:UIKeyboardTypeDecimalPad];
    [control addSubview:txtValue1];
    //值2
    lblValue2=[[UILabel alloc]initWithFrame:CGRectMake(10, 120, 80, 30)];
    lblValue2.font=[UIFont systemFontOfSize:12.0];
    [lblValue2 setTextColor:[UIColor blackColor]];
    [lblValue2 setBackgroundColor:[UIColor clearColor]];
    [lblValue2 setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lblValue2];
    
    txtValue2=[[UITextField alloc]initWithFrame:CGRectMake(100, 120, 150, 30)];
    [txtValue2 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValue2 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValue2 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValue2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValue2 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValue2 setKeyboardType:UIKeyboardTypeDecimalPad];
    [control addSubview:txtValue2];
    //值3
    lblValue3=[[UILabel alloc]initWithFrame:CGRectMake(10, 160, 80, 30)];
    lblValue3.font=[UIFont systemFontOfSize:12.0];
    [lblValue3 setTextColor:[UIColor blackColor]];
    [lblValue3 setBackgroundColor:[UIColor clearColor]];
    [lblValue3 setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lblValue3];
    
    txtValue3=[[UITextField alloc]initWithFrame:CGRectMake(100, 160, 150, 30)];
    [txtValue3 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValue3 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValue3 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValue3 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValue3 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValue3 setKeyboardType:UIKeyboardTypeDecimalPad];
    [control addSubview:txtValue3];
    //值4
    lblValue4=[[UILabel alloc]initWithFrame:CGRectMake(10, 200, 80, 30)];
    lblValue4.font=[UIFont systemFontOfSize:12.0];
    [lblValue4 setTextColor:[UIColor blackColor]];
    [lblValue4 setBackgroundColor:[UIColor clearColor]];
    [lblValue4 setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lblValue4];
    
    txtValue4=[[UITextField alloc]initWithFrame:CGRectMake(100, 200, 150, 30)];
    [txtValue4 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValue4 setEnabled:NO];
    [txtValue4 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValue4 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValue4 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValue4 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValue4 setKeyboardType:UIKeyboardTypeDecimalPad];
    [control addSubview:txtValue4];
    
    UIButton *btnCalculate=[[UIButton alloc]initWithFrame:CGRectMake(80, 240, 160, 30)];
    [btnCalculate.titleLabel setFont:[UIFont systemFontOfSize: 12.0]];
    [btnCalculate setTitle:@"计算" forState:UIControlStateNormal];
    [btnCalculate setBackgroundColor:[UIColor colorWithRed:(55/255.0) green:(55/255.0) blue:(139/255.0) alpha:1]];
    [btnCalculate addTarget:self action:@selector(calculate:) forControlEvents:UIControlEventTouchUpInside];
    [control addSubview:btnCalculate];
    
    int IMAGEHEIGHT=428.0;
    if(!inch4){
        IMAGEHEIGHT=340.0;
    }
    
    UIPickerView* pickerView = [ [ UIPickerView alloc] initWithFrame:CGRectMake(0.0,IMAGEHEIGHT,320.0,50.0)];
    pickerView.delegate = self;
    pickerView.dataSource =  self;
    [self.view addSubview:pickerView];
    
    [self updateView:0];
    
}

- (void)updateView:(NSInteger)row{
    currentRow=row;
    self.title=[selectData objectAtIndex:row];
    
    [ivImage setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"f%d",currentRow+1]]]];
    
    if (row==0) {
        //倍率
        [lblValue1 setText:@"CT变比"];
        [lblValue2 setText:@"PT变比"];
        [lblValue3 setText:@"倍率"];
        
        [txtValue1 setText:@""];
        [txtValue2 setText:@""];
        [txtValue3 setText:@""];
        [txtValue3 setEnabled:NO];
        
        [lblValue4 setHidden:YES];
        [txtValue4 setHidden:YES];
        [ivImage setFrame:CGRectMake(96, 40, 128, 11.5)];
    } else if (row==1) {
        //电量
        [lblValue1 setText:@"本次读入"];
        [lblValue2 setText:@"上次读入"];
        [lblValue3 setText:@"倍率"];
        [lblValue4 setText:@"电量"];
        
        [txtValue1 setText:@""];
        [txtValue2 setText:@""];
        [txtValue3 setText:@""];
        [txtValue3 setEnabled:YES];
        [txtValue4 setText:@""];
        [txtValue4 setEnabled:NO];
        
        [lblValue4 setHidden:NO];
        [txtValue4 setHidden:NO];
        
        [ivImage setFrame:CGRectMake(70, 40, 180, 11.5)];
    } else if (row==2) {
        //功率因数
        [lblValue1 setText:@"有功功率"];
        [lblValue2 setText:@"无功功率"];
        [lblValue3 setText:@"功率因数"];
        
        [txtValue1 setText:@""];
        [txtValue2 setText:@""];
        [txtValue3 setText:@""];
        [txtValue3 setEnabled:NO];
        
        [lblValue4 setHidden:YES];
        [txtValue4 setHidden:YES];
        
        [ivImage setFrame:CGRectMake(56.25, 40, 207.5, 31.5)];
    } else if (row==3) {
        //有功功率
        [lblValue1 setText:@"线电压"];
        [lblValue2 setText:@"电流"];
        [lblValue3 setText:@"功率因数"];
        [lblValue4 setText:@"有功功率"];
        
        [txtValue1 setText:@""];
        [txtValue2 setText:@""];
        [txtValue3 setText:@""];
        [txtValue3 setEnabled:YES];
        [txtValue4 setText:@""];
        [txtValue4 setEnabled:NO];
        
        [lblValue4 setHidden:NO];
        [txtValue4 setHidden:NO];
        
        [ivImage setFrame:CGRectMake(34.75, 40, 250.5, 15.5)];
    } else if (row==4) {
        //无功功率
        [lblValue1 setText:@"线电压"];
        [lblValue2 setText:@"电流"];
        [lblValue3 setText:@"功率因数"];
        [lblValue4 setText:@"无功功率"];
        
        [txtValue1 setText:@""];
        [txtValue2 setText:@""];
        [txtValue3 setText:@""];
        [txtValue3 setEnabled:YES];
        [txtValue4 setText:@""];
        [txtValue4 setEnabled:NO];
        
        [lblValue4 setHidden:NO];
        [txtValue4 setHidden:NO];
        
        [ivImage setFrame:CGRectMake(19.25, 40, 281.5, 16)];
    } else if (row==5) {
        //负荷率
        [lblValue1 setText:@"平均负荷"];
        [lblValue2 setText:@"最大负荷"];
        [lblValue3 setText:@"负荷率"];
        
        [txtValue1 setText:@""];
        [txtValue2 setText:@""];
        [txtValue3 setText:@""];
        [txtValue3 setEnabled:NO];
        
        [lblValue4 setHidden:YES];
        [txtValue4 setHidden:YES];
        
        [ivImage setFrame:CGRectMake(88.5, 40, 143, 11)];
    } else if (row==6) {
        //变压器负载率
        [lblValue1 setText:@"视在功率"];
        [lblValue2 setText:@"变压器容量"];
        [lblValue3 setText:@"变压器负载率"];
        
        [txtValue1 setText:@""];
        [txtValue2 setText:@""];
        [txtValue3 setText:@""];
        [txtValue3 setEnabled:NO];
        
        [lblValue4 setHidden:YES];
        [txtValue4 setHidden:YES];
        
        [ivImage setFrame:CGRectMake(2, 40, 316, 13)];
    } else if (row==7) {
        //视在功率
        [lblValue1 setText:@"有功耗量"];
        [lblValue2 setText:@"无功耗量"];
        [lblValue3 setText:@"视在功率"];
        
        [txtValue1 setText:@""];
        [txtValue2 setText:@""];
        [txtValue3 setText:@""];
        [txtValue3 setEnabled:NO];
        
        [lblValue4 setHidden:YES];
        [txtValue4 setHidden:YES];
        
        [ivImage setFrame:CGRectMake(53.5, 40, 213, 15.5)];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self updateView:row];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (!view) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];
        label.text = [selectData objectAtIndex:row];
        label.textColor = [UIColor blueColor];
        label.font=[UIFont systemFontOfSize:14];
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        [view addSubview:label];
    }
    return view ;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [selectData count];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0f;
}

- (void)calculate:(id)sender {
    
    double v1=[[txtValue1 text] doubleValue];
    double v2=[[txtValue2 text] doubleValue];
    double v3=[[txtValue3 text] doubleValue];
    if (currentRow==0) {
        //倍率
        double v=v1*v2;
        [txtValue3 setText:[NSString stringWithFormat:@"%.2f",v]];
    } else if (currentRow==1) {
        //电量
        if(v1<v2){
            [Common alert:@"本次读数应该大于上次读数！"];
            return;
        }
        double v=(v1-v2)*v3;
        [txtValue4 setText:[NSString stringWithFormat:@"%.2f",v]];
    } else if (currentRow==2) {
        //功率因数
        double temp=sqrt(v1*v1+v2*v2);
        if(temp <= 0){
            [Common alert:@"除数不能为零！"];
            return;
        }
        double v=v1/temp;
        [txtValue3 setText:[NSString stringWithFormat:@"%.2f",v]];
    } else if (currentRow==3) {
        //有功功率
        if(v3>1){
            [Common alert:@"功率因数必须0~1之间！"];
            return;
        }
        double v=1.732*v1*v2*v3;
        [txtValue4 setText:[NSString stringWithFormat:@"%.2f",v]];
    } else if (currentRow==4) {
        //无功功率
        if(v3>1){
            [Common alert:@"功率因数必须0~1之间！"];
            return;
        }
        double temp = sqrt( 1 - v3 * v3 );
        double v=1.732*v1*v2*temp;
        [txtValue4 setText:[NSString stringWithFormat:@"%.2f",v]];
    } else if (currentRow==5) {
        //负荷率
        if(v2<=0){
            [Common alert:@"除数不能为零！"];
            return;
        }
        double v=v1/v2;
        [txtValue3 setText:[NSString stringWithFormat:@"%.2f",v]];
    } else if (currentRow==6) {
        //变压器负载率
        if(v2<=0){
            [Common alert:@"除数不能为零！"];
            return;
        }
        double v = v1 / v2 * 100;
        [txtValue3 setText:[NSString stringWithFormat:@"%.2f%%",v]];
    } else if (currentRow==7) {
        //视在功率
        double v=sqrt(v1*v1+v2*v2);
        [txtValue3 setText:[NSString stringWithFormat:@"%.2f",v]];
    }
    
    [self backgroundDoneEditing:nil];
    
}

- (void)backgroundDoneEditing:(id)sender {
    [txtValue1 resignFirstResponder];
    [txtValue2 resignFirstResponder];
    [txtValue3 resignFirstResponder];
    [txtValue4 resignFirstResponder];
}

@end
