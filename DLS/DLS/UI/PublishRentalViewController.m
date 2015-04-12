//
//  PublishRentalViewController.m
//  DLS
//  发布出租
//  Created by Start on 3/12/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "PublishRentalViewController.h"
#import "ButtonView.h"

#define BGCOLOR [UIColor colorWithRed:(246/255.0) green:(246/255.0) blue:(246/255.0) alpha:1]
#define TITLECOLOR [UIColor colorWithRed:(127/255.0) green:(127/255.0) blue:(127/255.0) alpha:1]

@interface PublishRentalViewController ()

@end

@implementation PublishRentalViewController{
    UIView *headView,*footView;
    NSInteger pvv1,pvv2;
    NSArray *searchData1,*searchData2;
    UILabel *lblRentalType,*lblSBType;
    UITextView *tvRemark;
    UITextField *tfTitle,*tfContact,*tfPhone,*tfAddress;
    UIButton *bAdd;
    UIImageView *image1,*image2,*image3,*image4,*image5;
    NSMutableArray *imageList;
}

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"发布出租"];
        [self.view setBackgroundColor:BGCOLOR];
        
        pvv1=-1;
        pvv2=-1;
        
        headView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 110)];
        [headView setBackgroundColor:BGCOLOR];
        footView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 610)];
        [footView setBackgroundColor:BGCOLOR];
        //
        lblRentalType=[self addFrameType:10 Title:@"选择类型" Name:@"请选择" Tag:1 Frame:headView];
        //
        tfTitle=[self addFrameTypeTextField:60 Title:@"标题" Frame:headView];
        //
        lblSBType=[self addFrameType:10 Title:@"设备类型" Name:@"请选择" Tag:2 Frame:footView];
        //添加
        ButtonView *buttonAdd=[[ButtonView alloc]initWithFrame:CGRectMake1(10, 60, 300, 40) Name:@"再添加设备"];
        [buttonAdd addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:buttonAdd];
        //
        tfAddress=[self addFrameTypeTextField:110 Title:@"设备地址" Frame:footView];
        //
        UIView *imageViewFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 160, 320, 140)];
        [imageViewFrame setBackgroundColor:BGCOLOR];
        [footView addSubview:imageViewFrame];
        
        image1=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 0, 52, 52)];
        [image1 setImage:[UIImage imageNamed:@"配件销售"]];
        [imageViewFrame addSubview:image1];
        [image1 setHidden:YES];
        
        image2=[[UIImageView alloc]initWithFrame:CGRectMake1(72, 0, 52, 52)];
        [image2 setImage:[UIImage imageNamed:@"配件销售"]];
        [imageViewFrame addSubview:image2];
        [image2 setHidden:YES];
        
        image3=[[UIImageView alloc]initWithFrame:CGRectMake1(134, 0, 52, 52)];
        [image3 setImage:[UIImage imageNamed:@"配件销售"]];
        [imageViewFrame addSubview:image3];
        [image3 setHidden:YES];
        
        image4=[[UIImageView alloc]initWithFrame:CGRectMake1(196, 0, 52, 52)];
        [image4 setImage:[UIImage imageNamed:@"配件销售"]];
        [imageViewFrame addSubview:image4];
        [image4 setHidden:YES];
        
        image5=[[UIImageView alloc]initWithFrame:CGRectMake1(258, 0, 52, 52)];
        [image5 setImage:[UIImage imageNamed:@"配件销售"]];
        [imageViewFrame addSubview:image5];
        [image5 setHidden:YES];
        
        bAdd=[[UIButton alloc]initWithFrame:image1.frame];
        [bAdd addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
        [bAdd setImage:[UIImage imageNamed:@"addimg"] forState:UIControlStateNormal];
        [imageViewFrame addSubview:bAdd];
        //
        tfContact=[self addFrameTypeTextField:310 Title:@"联系人" Frame:footView];
        //
        tfPhone=[self addFrameTypeTextField:360 Title:@"电话" Frame:footView];
        //备注
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0,410,320,140)];
        [frame setBackgroundColor:[UIColor whiteColor]];
        [footView addSubview:frame];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 100, 30)];
        [lbl setText:@"备注"];
        [lbl setTextColor:TITLECOLOR];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [frame addSubview:lbl];
        tvRemark=[[UITextView alloc]initWithFrame:CGRectMake1(10, 30, 300, 105)];
        [tvRemark setTextColor:TITLECOLOR];
        [tvRemark setDelegate:self];
        [tvRemark setFont:[UIFont systemFontOfSize:14]];
        [frame addSubview:tvRemark];
        //发布
        ButtonView *button=[[ButtonView alloc]initWithFrame:CGRectMake1(10, 560, 300, 40) Name:@"发布"];
        [button addTarget:self action:@selector(publish:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:button];
        
        [self buildTableViewWithView:self.view];
        [self.tableView setTableHeaderView:headView];
        [self.tableView setTableFooterView:footView];
        
        searchData1=[NSArray arrayWithObjects:
                     [NSDictionary dictionaryWithObjectsAndKeys:@"汽车吊",MKEY,@"1",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"履带吊",MKEY,@"2",MVALUE, nil], nil];
        searchData2=[NSArray arrayWithObjects:
                     [NSDictionary dictionaryWithObjectsAndKeys:@"8吨",MKEY,@"8",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"12吨",MKEY,@"12",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"25吨",MKEY,@"25",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"35吨",MKEY,@"35",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"50吨",MKEY,@"50",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"65吨",MKEY,@"65",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"70吨",MKEY,@"70",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"90吨",MKEY,@"90",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"100吨",MKEY,@"100",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"120吨",MKEY,@"120",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"130吨",MKEY,@"130",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"150吨",MKEY,@"150",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"180吨",MKEY,@"180",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"200吨",MKEY,@"200",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"220吨",MKEY,@"220",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"260吨",MKEY,@"260",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"300吨",MKEY,@"300",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"350吨",MKEY,@"350",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"400吨",MKEY,@"400",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"500吨",MKEY,@"500",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"600吨",MKEY,@"600",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"800吨",MKEY,@"800",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"1000吨",MKEY,@"1000",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"1200吨",MKEY,@"1200",MVALUE, nil],nil];
        
        self.pv1=[[SinglePickerView alloc]initWithFrame:CGRectMake1(0, self.view.bounds.size.height-260, 320, 260) WithArray:searchData1];
        [self.pv1 setCode:1];
        [self.pv1 setDelegate:self];
        [self.view addSubview:self.pv1];
        
        self.pv2=[[SinglePickerView alloc]initWithFrame:CGRectMake1(0, self.view.bounds.size.height-260, 320, 260) WithArray:searchData2];
        [self.pv2 setCode:2];
        [self.pv2 setDelegate:self];
        [self.view addSubview:self.pv2];
        
        self.dataItemArray=[[NSMutableArray alloc]init];
        
        imageList=[[NSMutableArray alloc]init];
        
    }
    return self;
}

- (UILabel*)addFrameType:(CGFloat)y Title:(NSString*)title Name:(NSString*)name Tag:(NSInteger)tag Frame:(UIView*)f
{
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0,y,320,40)];
    [frame setBackgroundColor:[UIColor whiteColor]];
    [f addSubview:frame];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 100, 40)];
    [lbl setText:title];
    [lbl setTextColor:TITLECOLOR];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [frame addSubview:lbl];
    UILabel *lblContent=[[UILabel alloc]initWithFrame:CGRectMake1(200, 0, 90, 40)];
    [lblContent setText:name];
    [lblContent setTextColor:TITLECOLOR];
    [lblContent setFont:[UIFont systemFontOfSize:14]];
    [lblContent setTextAlignment:NSTextAlignmentRight];
    [lblContent setUserInteractionEnabled:YES];
    [lblContent setTag:tag];
    [lblContent addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectorType:)]];
    [frame addSubview:lblContent];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(300, 11, 9, 18)];
    [image setImage:[UIImage imageNamed:@"arrowright"]];
    [frame addSubview:image];
    return lblContent;
}

- (UITextField*)addFrameTypeTextField:(CGFloat)y Title:(NSString*)title Frame:(UIView*)f
{
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0,y,320,40)];
    [frame setBackgroundColor:[UIColor whiteColor]];
    [f addSubview:frame];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 100, 40)];
    [lbl setText:title];
    [lbl setTextColor:TITLECOLOR];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [frame addSubview:lbl];
    UITextField *tfContent=[[UITextField alloc]initWithFrame:CGRectMake1(150, 0, 140, 40)];
    [tfContent setDelegate:self];
    [tfContent setTextColor:TITLECOLOR];
    [tfContent setFont:[UIFont systemFontOfSize:14]];
    [tfContent setTextAlignment:NSTextAlignmentRight];
    [frame addSubview:tfContent];
    return tfContent;
}

- (void)pickerViewDone:(int)code
{
    if(code==1){
        pvv1=[self.pv1.picker selectedRowInComponent:0];
        NSDictionary *d=[self.pv1.pickerArray objectAtIndex:pvv1];
        [lblRentalType setText:[d objectForKey:MKEY]];
    }else if(code==2){
        pvv2=[self.pv2.picker selectedRowInComponent:0];
        NSDictionary *d=[self.pv2.pickerArray objectAtIndex:pvv2];
        [lblSBType setText:[d objectForKey:MKEY]];
    }
}

- (void)selectorType:(UITapGestureRecognizer*)sender
{
    [self hideKeyBoard];
    NSInteger tag=[sender.view tag];
    [self showPickerView:tag];
}

- (void)add:(id)sender
{
    [self hideKeyBoard];
    if(pvv2==-1){
        [Common alert:@"请选择设备类型"];
        return;
    }
    [self.dataItemArray addObject:[NSString stringWithFormat:@"%d",pvv2]];
    [self.tableView reloadData];
    pvv2=-1;
    [lblSBType setText:@"请选择"];
}

- (void)publish:(id)sender
{
    [self hideKeyBoard];
    NSString *title=[tfTitle text];
    NSString *address=[tfAddress text];
    NSString *contact=[tfContact text];
    NSString *phone=[tfPhone text];
    NSString *remark=[tvRemark text];
    if(pvv1==-1){
        [Common alert:@"请选择类型"];
        return;
    }
    if([self.dataItemArray count]==0){
        [Common alert:@"请先添加设备"];
        return;
    }
    NSDictionary *d=[self.pv1.pickerArray objectAtIndex:pvv1];
    NSString *pvv1v=[d objectForKey:MVALUE];
    NSMutableString *weights=[[NSMutableString alloc]init];
    for(id data in self.dataItemArray){
        NSDictionary *d1=[self.pv2.pickerArray objectAtIndex:[data intValue]];
        NSString *key=[d1 objectForKey:MVALUE];
        //        NSLog(@"设备类型＝%@",key);
        [weights appendFormat:@"%@,",key];
    }
    NSRange deleteRange = {[weights length]-1,1};
    [weights deleteCharactersInRange:deleteRange];
    
    NSLog(@"选择类型=%@\n标题=%@\n设备地址=%@\n联系人=%@\n电话=%@\n备注=%@\n纯位＝%@\n",pvv1v,title,address,contact,phone,remark,weights);
}

- (void)showPickerView:(NSInteger)tag
{
    [self.pv1 setHidden:tag==1?NO:YES];
    [self.pv2 setHidden:tag==2?NO:YES];
}

- (void)hideKeyBoard
{
    [tfTitle resignFirstResponder];
    [tfPhone resignFirstResponder];
    [tfContact resignFirstResponder];
    [tfAddress resignFirstResponder];
    [tvRemark resignFirstResponder];
}

#pragma mark - UITextViewDelegate UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGPoint origin = textField.frame.origin;
    CGPoint point = [textField.superview convertPoint:origin toView:self.tableView];
    float navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGPoint offset = self.tableView.contentOffset;
    offset.y = (point.y - navBarHeight-40);
    [self.tableView setContentOffset:offset animated:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    CGPoint origin = textView.frame.origin;
    CGPoint point = [textView.superview convertPoint:origin toView:self.tableView];
    float navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGPoint offset = self.tableView.contentOffset;
    offset.y = (point.y - navBarHeight-40);
    [self.tableView setContentOffset:offset animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    return YES;
}

- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*) text
{
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        return NO;
    }else{
        return YES;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SAMPLECell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    NSString *key=[self.dataItemArray objectAtIndex:indexPath.row];
    NSDictionary *d=[self.pv2.pickerArray objectAtIndex:[key intValue]];
    cell.textLabel.text = @"设备类型";
    cell.detailTextLabel.text=[d objectForKey:MKEY];
    return cell;
}

- (void)addImage:(UIButton*)sender
{
    [imageList addObject:@"1"];
    int count=[imageList count];
    if(count==5){
        [image5 setHidden:NO];
        [sender setHidden:YES];
    }else if(count==1){
        [image1 setHidden:NO];
        [sender setFrame:image2.frame];
    }else if(count==2){
        [image2 setHidden:NO];
        [sender setFrame:image3.frame];
    }else if(count==3){
        [image3 setHidden:NO];
        [sender setFrame:image4.frame];
    }else if(count==4){
        [image4 setHidden:NO];
        [sender setFrame:image5.frame];
    }
}

@end
