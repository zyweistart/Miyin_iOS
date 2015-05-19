//
//  PublishRentalViewController.m
//  DLS
//  发布出租
//  Created by Start on 3/12/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "PublishRentalViewController.h"
#import "ButtonView.h"
#import "SB1Cell.h"

#define KEYCELL @"KEY"
#define VALUECELL @"VALUE"

#define BGCOLOR [UIColor colorWithRed:(246/255.0) green:(246/255.0) blue:(246/255.0) alpha:1]
#define TITLECOLOR [UIColor colorWithRed:(127/255.0) green:(127/255.0) blue:(127/255.0) alpha:1]
#define LINEBGCOLOR [UIColor colorWithRed:(225/255.0) green:(225/255.0) blue:(225/255.0) alpha:1]

@interface PublishRentalViewController ()

@end

@implementation PublishRentalViewController{
    UIView *headView,*footView;
    NSInteger pvv1,pvv2,pvv3;
    UILabel *lblRentalType,*lblSBType,*lblArea;
    UITextView *tvRemark;
    UITextField *tfTitle,*tfSBNumber,*tfContact,*tfPhone,*tfAddress;
    UIButton *bAdd;
    UIImageView *image1,*image2,*image3,*image4,*image5;
    NSMutableArray *imageList;
    BOOL isFullScreen;
    UIImage *currentImage;
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
        footView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 660)];
        [footView setBackgroundColor:BGCOLOR];
        //
        lblRentalType=[self addFrameType:10 Title:@"选择类型" Name:@"请选择" Tag:1 Frame:headView];
        //
        tfTitle=[self addFrameTypeTextField:60 Title:@"标题" Frame:headView];
        //
//        lblSBType=[self addFrameType:10 Title:@"设备类型" Name:@"请选择" Tag:2 Frame:footView];
        
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
        lblArea=[self addFrameType:310 Title:@"使用范围" Name:@"请选择" Tag:3 Frame:footView];
        tfContact=[self addFrameTypeTextField:360 Title:@"联系人" Frame:footView];
        //
        tfPhone=[self addFrameTypeTextField:410 Title:@"电话" Frame:footView];
        [tfPhone setKeyboardType:UIKeyboardTypePhonePad];
        //备注
        frame=[[UIView alloc]initWithFrame:CGRectMake1(0,460,320,140)];
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
        ButtonView *button=[[ButtonView alloc]initWithFrame:CGRectMake1(10, 610, 300, 40) Name:@"发布"];
        [button addTarget:self action:@selector(publish:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:button];
        
        [self buildTableViewWithView:self.view];
        [self.tableView setTableHeaderView:headView];
        [self.tableView setTableFooterView:footView];
        
        self.pv1=[[SinglePickerView alloc]initWithFrame:CGRectMake1(0, self.view.bounds.size.height-260, 320, 260) WithArray:[CommonData getType2]];
        [self.pv1 setCode:1];
        [self.pv1 setDelegate:self];
        [self.view addSubview:self.pv1];
        
        self.pv2=[[SinglePickerView alloc]initWithFrame:CGRectMake1(0, self.view.bounds.size.height-260, 320, 260) WithArray:[CommonData getSearchTon2]];
        [self.pv2 setCode:2];
        [self.pv2 setDelegate:self];
        [self.view addSubview:self.pv2];
        
        self.pv3=[[SinglePickerView alloc]initWithFrame:CGRectMake1(0, self.view.bounds.size.height-260, 320, 260) WithArray:[CommonData getRegion]];
        [self.pv3 setCode:3];
        [self.pv3 setDelegate:self];
        [self.view addSubview:self.pv3];
        
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
    }else if(code==3){
        pvv3=[self.pv3.picker selectedRowInComponent:0];
        NSDictionary *d=[self.pv3.pickerArray objectAtIndex:pvv3];
        [lblArea setText:[d objectForKey:MKEY]];
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
//    [self hideKeyBoard];
//    if(pvv2==-1){
//        [Common alert:@"请选择设备类型"];
//        return;
//    }
//    [self.dataItemArray addObject:[NSString stringWithFormat:@"%d",pvv2]];
//    [self.tableView reloadData];
//    pvv2=-1;
//    [lblSBType setText:@"请选择"];
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
    NSString *contact=[tfContact text];
    NSString *phone=[tfPhone text];
    NSString *remark=[tvRemark text];
    if(pvv1==-1){
        [Common alert:@"请选择类型"];
        return;
    }
    if(pvv3==-1){
        [Common alert:@"请选择使用范围"];
        return;
    }
    if([self.dataItemArray count]==0){
        [Common alert:@"请先添加设备"];
        return;
    }
    NSDictionary *d=[self.pv1.pickerArray objectAtIndex:pvv1];
    NSString *pvv1v=[d objectForKey:MVALUE];
    NSDictionary *d3=[self.pv3.pickerArray objectAtIndex:pvv3];
    NSString *pvv3v=[d3 objectForKey:MVALUE];
    
//    NSMutableString *weights=[[NSMutableString alloc]init];
//    for(id data in self.dataItemArray){
//        NSDictionary *d1=[self.pv2.pickerArray objectAtIndex:[data intValue]];
//        NSString *key=[d1 objectForKey:MVALUE];
//        [weights appendFormat:@"%@,",key];
//    }
//    NSRange deleteRange = {[weights length]-1,1};
//    [weights deleteCharactersInRange:deleteRange];
    
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
    
    NSMutableString *urls=[[NSMutableString alloc]init];
    if([imageList count]>0){
        for(id url in imageList){
            [urls appendFormat:@"%@{-}1{-}#,",url];
        }
        NSRange urlRange1 = {[urls length]-9,9};
        [urls deleteCharactersInRange:urlRange1];
    }
    
//    NSLog(@"选择类型=%@\n标题=%@\n设备地址=%@\n联系人=%@\n电话=%@\n备注=%@\n纯位＝%@\n数量=%@",pvv1v,title,address,contact,phone,remark,weights,equipments);
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]accessToken] forKey:@"access_token"];
    [params setObject:@"0" forKey:@"Id"];
    [params setObject:@"42" forKey:@"classId"];
    [params setObject:title forKey:@"Name"];
    [params setObject:pvv1v forKey:@"xlValue"];
    [params setObject:address forKey:@"address"];
    [params setObject:contact forKey:@"contact"];
    [params setObject:phone forKey:@"contact_phone"];
    [params setObject:urls forKey:@"imageList"];
    [params setObject:remark forKey:@"notes"];
    [params setObject:weights forKey:@"weight"];
    [params setObject:equipments forKey:@"equipment_Num"];
    [params setObject:pvv3v forKey:@"region"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:@"SaveForm" requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if(reqCode==501){
        if([response successFlag]){
            
            NSString *url=[NSString stringWithFormat:@"%@",[[response resultJSON]objectForKey:@"Data"]];
            [imageList addObject:url];
            //成功后执行
            [self showImage:currentImage];
        }
    }else{
        if([response successFlag]){
            [Common alert:@"发布成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)showPickerView:(NSInteger)tag
{
    [self.pv1 setHidden:tag==1?NO:YES];
    [self.pv2 setHidden:tag==2?NO:YES];
    [self.pv3 setHidden:tag==3?NO:YES];
}

- (void)hideKeyBoard
{
    [tfTitle resignFirstResponder];
    [tfPhone resignFirstResponder];
    [tfSBNumber resignFirstResponder];
    [tfContact resignFirstResponder];
    [tfAddress resignFirstResponder];
    [tvRemark resignFirstResponder];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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

- (void)addImage:(UIButton*)sender
{
//    [imageList addObject:@"1"];
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    } else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    sheet.tag = 255;
    [sheet showInView:self.view];
}

#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = 0;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                default:
                    return;
            }
        } else {
            if (buttonIndex == 0) {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            } else {
                return;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)ci withName:(NSString *)imageName
{
    NSData *imageData = UIImagePNGRepresentation(ci);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self saveImage:image withName:@"currentImage.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    isFullScreen = NO;
    [self uploadImage:savedImage];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)uploadImage:(UIImage*)image
{
    currentImage=image;
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]accessToken] forKey:@"access_token"];
    [params setObject:UIImageJPEGRepresentation(image,0.00001) forKey:@"imgFile"];
//    [params setObject:UIImagePNGRepresentation(image) forKey:@"imgFile"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:501];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest setIsMultipartFormDataSubmit:YES];
    [self.hRequest handle:@"Upload" requestParams:params];
}

//上传成功之后调用
- (void)showImage:(UIImage*)image
{
    NSUInteger count=[imageList count];
    if(count==5){
        [image5 setHidden:NO];
        [bAdd setHidden:YES];
        [image5 setImage:image];
    }else if(count==1){
        [image1 setHidden:NO];
        [bAdd setFrame:image2.frame];
        [image1 setImage:image];
    }else if(count==2){
        [image2 setHidden:NO];
        [bAdd setFrame:image3.frame];
        [image2 setImage:image];
    }else if(count==3){
        [image3 setHidden:NO];
        [bAdd setFrame:image4.frame];
        [image3 setImage:image];
    }else if(count==4){
        [image4 setHidden:NO];
        [bAdd setFrame:image5.frame];
        [image4 setImage:image];
    }
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