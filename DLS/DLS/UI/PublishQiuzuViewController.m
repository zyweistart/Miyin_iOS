//
//  PublishQiuzuViewController.m
//  DLS
//  发布求租
//  Created by Start on 3/12/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "PublishQiuzuViewController.h"
#import "ButtonView.h"
#import "SB1Cell.h"

#define KEYCELL @"KEY"
#define VALUECELL @"VALUE"

#define BGCOLOR [UIColor colorWithRed:(246/255.0) green:(246/255.0) blue:(246/255.0) alpha:1]
#define TITLECOLOR [UIColor colorWithRed:(127/255.0) green:(127/255.0) blue:(127/255.0) alpha:1]
#define LINEBGCOLOR [UIColor colorWithRed:(225/255.0) green:(225/255.0) blue:(225/255.0) alpha:1]

@interface PublishQiuzuViewController ()

@end

@implementation PublishQiuzuViewController{
    UIView *headView,*footView;
    NSInteger pvv1,pvv2;
    UILabel *lblRentalType,*lblSBType;
    UITextField *tfTitle,*tfSBNumber,*tfAddress,*tfStartTime,*tfEndTime,*tfPrice,*tfPhone;
    UITextView *tvRemark;
    UIDatePicker *startDatePicker,*endDatePicker;
    NSLocale *datelocale;
}

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"发布求租"];
        [self.view setBackgroundColor:BGCOLOR];
        pvv1=-1;
        pvv2=-1;
        
        headView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 110)];
        [headView setBackgroundColor:BGCOLOR];
        footView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 510)];
        [footView setBackgroundColor:BGCOLOR];
        //
        lblRentalType=[self addFrameType:10 Title:@"选择类型" Name:@"请选择" Tag:1 Frame:headView];
        //
        tfTitle=[self addFrameTypeTextField:60 Title:@"标题" Frame:headView];
        [tfTitle setPlaceholder:@"请输入你的标题"];
        //
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0,10,320,40)];
        [frame setBackgroundColor:[UIColor whiteColor]];
        [footView addSubview:frame];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 100, 40)];
        [lbl setText:@"设备类型"];
        [lbl setTextColor:TITLECOLOR];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [frame addSubview:lbl];
        lblSBType=[[UILabel alloc]initWithFrame:CGRectMake1(120, 0, 70, 40)];
        [lblSBType setText:@"请选择"];
        [lblSBType setTextColor:TITLECOLOR];
        [lblSBType setFont:[UIFont systemFontOfSize:14]];
        [lblSBType setTextAlignment:NSTextAlignmentRight];
        [lblSBType setTag:2];
        [lblSBType setUserInteractionEnabled:YES];
        [lblSBType addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectorType:)]];
        [frame addSubview:lblSBType];
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(200, 11, 9, 18)];
        [image setImage:[UIImage imageNamed:@"arrowright"]];
        [frame addSubview:image];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(219, 5, 1, 30)];
        [line setBackgroundColor:LINEBGCOLOR];
        [frame addSubview:line];
        tfSBNumber=[[UITextField alloc]initWithFrame:CGRectMake1(220, 0, 90, 40)];
        [tfSBNumber setDelegate:self];
        [tfSBNumber setPlaceholder:@"需要的数量"];
        [tfSBNumber setTextColor:TITLECOLOR];
        [tfSBNumber setFont:[UIFont systemFontOfSize:14]];
        [tfSBNumber setTextAlignment:NSTextAlignmentCenter];
        [tfSBNumber setKeyboardType:UIKeyboardTypeNumberPad];
        [frame addSubview:tfSBNumber];
        //添加
        ButtonView *buttonAdd=[[ButtonView alloc]initWithFrame:CGRectMake1(10, 60, 300, 40) Name:@"再添加设备"];
        [buttonAdd addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:buttonAdd];
        //
        tfAddress=[self addFrameTypeTextField:110 Title:@"设备地址" Frame:footView];
        [tfAddress setPlaceholder:@"请输入设备地址"];
        [tfAddress setKeyboardType:UIKeyboardTypeDefault];
        //
        frame=[[UIView alloc]initWithFrame:CGRectMake1(0,160,320,40)];
        [frame setBackgroundColor:[UIColor whiteColor]];
        [footView addSubview:frame];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 100, 40)];
        [lbl setText:@"使用时间"];
        [lbl setTextColor:TITLECOLOR];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [frame addSubview:lbl];
        tfStartTime=[[UITextField alloc]initWithFrame:CGRectMake1(120, 0, 90, 40)];
        [tfStartTime setDelegate:self];
        [tfStartTime setPlaceholder:@"开始时间"];
        [tfStartTime setTextColor:TITLECOLOR];
        [tfStartTime setFont:[UIFont systemFontOfSize:14]];
        [tfStartTime setTextAlignment:NSTextAlignmentCenter];
        [frame addSubview:tfStartTime];
        line=[[UIView alloc]initWithFrame:CGRectMake1(219, 5, 1, 30)];
        [line setBackgroundColor:LINEBGCOLOR];
        [frame addSubview:line];
        tfEndTime=[[UITextField alloc]initWithFrame:CGRectMake1(220, 0, 90, 40)];
        [tfEndTime setDelegate:self];
        [tfEndTime setPlaceholder:@"结束时间"];
        [tfEndTime setTextColor:TITLECOLOR];
        [tfEndTime setFont:[UIFont systemFontOfSize:14]];
        [tfEndTime setTextAlignment:NSTextAlignmentCenter];
        [frame addSubview:tfEndTime];
        //
        tfPrice=[self addFrameTypeTextField:210 Title:@"出价" Frame:footView];
        [tfPrice setPlaceholder:@"出价数目"];
        [tfPrice setKeyboardType:UIKeyboardTypeDecimalPad];
        //
        tfPhone=[self addFrameTypeTextField:260 Title:@"电话" Frame:footView];
        [tfPhone setPlaceholder:@"请输入联系人电话"];
        [tfPhone setKeyboardType:UIKeyboardTypePhonePad];
        //备注
        frame=[[UIView alloc]initWithFrame:CGRectMake1(0,310,320,140)];
        [frame setBackgroundColor:[UIColor whiteColor]];
        [footView addSubview:frame];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 100, 30)];
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
        ButtonView *button=[[ButtonView alloc]initWithFrame:CGRectMake1(10, 460, 300, 40) Name:@"发布"];
        [button addTarget:self action:@selector(publish:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:button];
        
        [self buildTableViewWithView:self.view];
        [self.tableView setTableHeaderView:headView];
        [self.tableView setTableFooterView:footView];
        
        self.pv1=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-CGHeight(260), CGWidth(320), CGHeight(260)) WithArray:[CommonData getType2]];
        [self.pv1 setCode:1];
        [self.pv1 setDelegate:self];
        [self.view addSubview:self.pv1];
        
        self.pv2=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-CGHeight(260), CGWidth(320), CGHeight(260)) WithArray:[CommonData getSearchTon2]];
        [self.pv2 setCode:2];
        [self.pv2 setDelegate:self];
        [self.view addSubview:self.pv2];
        
        self.dataItemArray=[[NSMutableArray alloc]init];
        
        // 時區的問題請再找其他協助 不是本篇重點
        datelocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CH"];
        startDatePicker=[self createPicker:tfStartTime doneAction:@selector(doneStartPicker) cancelAction:@selector(doneStartPicker)];
        endDatePicker=[self createPicker:tfEndTime doneAction:@selector(doneEndPicker) cancelAction:@selector(doneEndPicker)];
        
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
    NSString *number=[tfSBNumber text];
    if([@"" isEqualToString:number]){
        [Common alert:@"请输入设备数量"];
        return;
    }
    
    [self.dataItemArray addObject:
     [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",pvv2],KEYCELL,number,VALUECELL, nil]];
    [self.tableView reloadData];
    pvv2=-1;
    [lblSBType setText:@"请选择"];
    [tfSBNumber setText:@""];
}

- (void)publish:(id)sender
{
    [self hideKeyBoard];
    NSString *title=[tfTitle text];
    NSString *address=[tfAddress text];
    NSString *startTime=[tfStartTime text];
    NSString *endTime=[tfEndTime text];
    NSString *price=[tfPrice text];
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
//    NSLog(@"选择类型=%@\n标题=%@\n设备地址=%@\n使用时间=%@---%@\n出价=%@\n电话=%@\n备注=%@\n\n\n",pvv1v,title,address,startTime,endTime,price,phone,remark);
    
    NSMutableString *weights=[[NSMutableString alloc]init];
    NSMutableString *equipments=[[NSMutableString alloc]init];
    for(id data in self.dataItemArray){
        NSString *index=[data objectForKey:KEYCELL];
        NSString *value=[data objectForKey:VALUECELL];
        NSDictionary *d1=[self.pv2.pickerArray objectAtIndex:[index intValue]];
        NSString *key=[d1 objectForKey:MVALUE];
//        NSLog(@"设备类型＝%@，，，，数量＝%@",key,value);
        [weights appendFormat:@"%@,",key];
        [equipments appendFormat:@"%@,",value];
    }
    NSRange deleteRange1 = {[weights length]-1,1};
    [weights deleteCharactersInRange:deleteRange1];
    NSRange deleteRange2 = {[equipments length]-1,1};
    [equipments deleteCharactersInRange:deleteRange2];
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]accessToken] forKey:@"access_token"];
    [params setObject:@"41" forKey:@"classId"];
    [params setObject:@"0" forKey:@"Id"];
    [params setObject:pvv1v forKey:@"xlValue"];
    [params setObject:title forKey:@"Name"];
    [params setObject:price forKey:@"price"];
    [params setObject:weights forKey:@"weight"];
    [params setObject:equipments forKey:@"equipment_Num"];
    [params setObject:phone forKey:@"contact_phone"];
    [params setObject:address forKey:@"address"];
    [params setObject:startTime forKey:@"startTiem"];
    [params setObject:endTime forKey:@"endTime"];
    [params setObject:remark forKey:@"notes"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:@"SaveForm" requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        [Common alert:@"发布成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)showPickerView:(NSInteger)tag
{
    [self.pv1 setHidden:tag==1?NO:YES];
    [self.pv2 setHidden:tag==2?NO:YES];
}

- (void)hideKeyBoard
{
    [tfTitle resignFirstResponder];
    [tfSBNumber resignFirstResponder];
    [tfAddress resignFirstResponder];
    [tfStartTime resignFirstResponder];
    [tfEndTime resignFirstResponder];
    [tfPrice resignFirstResponder];
    [tfPhone resignFirstResponder];
    [tvRemark resignFirstResponder];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SAMPLECell";
    SB1Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[SB1Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary *data=[self.dataItemArray objectAtIndex:indexPath.row];
    NSString *key=[data objectForKey:KEYCELL];
    NSDictionary *d=[self.pv2.pickerArray objectAtIndex:[key intValue]];
    [cell.lblType setText:[d objectForKey:MKEY]];
    [cell.lblNumber setText:[data objectForKey:VALUECELL]];
    return cell;
}

#pragma mark - UITextViewDelegate UITextFieldDelegate

//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    CGPoint origin = textField.frame.origin;
//    CGPoint point = [textField.superview convertPoint:origin toView:self.tableView];
//    float navBarHeight = self.navigationController.navigationBar.frame.size.height;
//    CGPoint offset = self.tableView.contentOffset;
//    offset.y = (point.y - navBarHeight-40);
//    [self.tableView setContentOffset:offset animated:YES];
//}
//
//- (void)textViewDidBeginEditing:(UITextView *)textView
//{
//    CGPoint origin = textView.frame.origin;
//    CGPoint point = [textView.superview convertPoint:origin toView:self.tableView];
//    float navBarHeight = self.navigationController.navigationBar.frame.size.height;
//    CGPoint offset = self.tableView.contentOffset;
//    offset.y = (point.y - navBarHeight-40);
//    [self.tableView setContentOffset:offset animated:YES];
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField*)textField
//{
//    [textField resignFirstResponder];
//    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
//    return YES;
//}

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

//要求委托方的编辑风格在表视图的一个特定的位置。
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //默认没有编辑风格
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;
    if ([tableView isEqual:self.tableView]) {
        //设置编辑风格为删除风格
        result = UITableViewCellEditingStyleDelete;
    }
    return result;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //请求数据源提交的插入或删除指定行接收者。
    if (editingStyle ==UITableViewCellEditingStyleDelete) {
        //如果编辑样式为删除样式
        if (indexPath.row<[self.dataItemArray count]) {
            //移除数据源的数据
            [self.dataItemArray removeObjectAtIndex:indexPath.row];
            //移除tableView中的数据
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
}

- (UIDatePicker*)createPicker:(UITextField*)textField doneAction:(SEL)dAction cancelAction:(SEL)cAction
{
    // 建立 UIDatePicker
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.locale = datelocale;
    datePicker.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    datePicker.datePickerMode = UIDatePickerModeDate;
    // 以下這行是重點 (螢光筆畫兩行) 將 UITextField 的 inputView 設定成 UIDatePicker
    // 則原本會跳出鍵盤的地方 就改成選日期了
    textField.inputView = datePicker;
    // 建立 UIToolbar
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    // 選取日期完成鈕 並給他一個 selector
//    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:dAction];
    // 選取日期完成鈕 並給他一個 selector
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:cAction];
    // 把按鈕加進 UIToolbar
    toolBar.items = [NSArray arrayWithObject:right];
    // 以下這行也是重點 (螢光筆畫兩行)
    // 原本應該是鍵盤上方附帶內容的區塊 改成一個 UIToolbar 並加上完成鈕
    textField.inputAccessoryView = toolBar;
    return datePicker;
}

- (void)showDateValue:(UITextField*)pickerField DatePicker:(UIDatePicker*)datePicker
{
    if ([self.view endEditing:NO]) {
        NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
        fmt.locale = datelocale;
        fmt.dateFormat = @"yyyy-MM-dd";
        pickerField.text = [fmt stringFromDate:datePicker.date];
    }
}

- (void)doneStartPicker
{
    [self showDateValue:tfStartTime DatePicker:startDatePicker];
}

- (void)doneEndPicker
{
    [self showDateValue:tfEndTime DatePicker:endDatePicker];
}

#define  __SCREEN_WIDTH 320
#define  __SCREEN_HEIGHT 600
#define  NAVIGATION_BAR_HEIGHT 40
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.tableView.contentSize = CGSizeMake1(__SCREEN_WIDTH,__SCREEN_HEIGHT+216);//原始滑动距离增加键盘高度
    CGPoint pt = [textField convertPoint:CGPointMake(0, 0) toView:self.tableView];//把当前的textField的坐标映射到scrollview上
    if(self.tableView.contentOffset.y-pt.y+NAVIGATION_BAR_HEIGHT<=0)//判断最上面不要去滚动
        [self.tableView setContentOffset:CGPointMake(0, pt.y-NAVIGATION_BAR_HEIGHT) animated:YES];//华东
}

- (BOOL)textFieldShouldReturn:(UITextField*)theTextField
{
    [theTextField resignFirstResponder];
    //开始动画
    [UIView beginAnimations:nil context:nil];
    //设定动画持续时间
    [UIView setAnimationDuration:0.3];
    self.tableView.contentSize = CGSizeMake1(__SCREEN_WIDTH,__SCREEN_HEIGHT);
    //动画结束
    [UIView commitAnimations];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.tableView.contentSize = CGSizeMake1(__SCREEN_WIDTH,__SCREEN_HEIGHT+216);//原始滑动距离增加键盘高度
    CGPoint pt = [textView convertPoint:CGPointMake(0, 0) toView:self.tableView];//把当前的textField的坐标映射到scrollview上
    if(self.tableView.contentOffset.y-pt.y+NAVIGATION_BAR_HEIGHT<=0)//判断最上面不要去滚动
        [self.tableView setContentOffset:CGPointMake(0, pt.y-NAVIGATION_BAR_HEIGHT) animated:YES];//华东
}

@end