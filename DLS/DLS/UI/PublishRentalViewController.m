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
}

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"发布出租"];
        [self.view setBackgroundColor:BGCOLOR];
        
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
        UIView *imageView=[[UIView alloc]initWithFrame:CGRectMake1(0, 160, 320, 140)];
        [imageView setBackgroundColor:BGCOLOR];
        [footView addSubview:imageView];
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
        [button addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:button];
        
        [self buildTableViewWithView:self.view];
        [self.tableView setTableHeaderView:headView];
        [self.tableView setTableFooterView:footView];
        
        searchData1=[NSArray arrayWithObjects:@"1KM",@"2KM",@"3KM",@"4KM",@"5KM", nil];
        searchData2=[NSArray arrayWithObjects:@"2KM",@"2KM",@"3KM",@"4KM",@"5KM", nil];
        
        self.pv1=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-260, 320, 260) WithArray:searchData1];
        [self.pv1 setCode:1];
        [self.pv1 setDelegate:self];
        [self.view addSubview:self.pv1];
        
        self.pv2=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-260, 320, 260) WithArray:searchData2];
        [self.pv2 setCode:2];
        [self.pv2 setDelegate:self];
        [self.view addSubview:self.pv2];
        
        self.dataItemArray=[[NSMutableArray alloc]init];
        
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
        NSString *value=[self.pv1.pickerArray objectAtIndex:pvv1];
        [lblRentalType setText:value];
    }else if(code==2){
        pvv2=[self.pv2.picker selectedRowInComponent:0];
        NSString *value=[self.pv2.pickerArray objectAtIndex:pvv2];
        [lblSBType setText:value];
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
    [self.dataItemArray addObject:@"1"];
    [self.tableView reloadData];
}

- (void)publish:(id)sender
{
    [self hideKeyBoard];
    NSString *remark=[tvRemark text];
    NSString *phone=[tfPhone text];
    NSString *contact=[tfContact text];
    NSString *address=[tfAddress text];
    NSLog(@"pvv1=%d\npvv2=%d\nremark=%@\nphone=%@\ncontact=%@\naddress=%@",pvv1,pvv2,remark,phone,contact,address);
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
    return cell;
}

@end
