//
//  EnterpriseManagerViewController.m
//  eClient
//  企业信息编辑页面
//  Created by Start on 3/31/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "EnterpriseManagerViewController.h"
#import "EnterpriseHeightLowEditCell.h"
#import "SVTextField.h"
#import "SVButton.h"

#define INPUTBGCOLOR [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:0.5]
#define LINECOLOR [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1]

@interface EnterpriseManagerViewController ()

@end

@implementation EnterpriseManagerViewController{
    UITextField *eName,*ePhone;
    SVButton *bAdd1,*bAdd2,*bSort,*bSubmit;
    int tmpRow;
    
    UIView *inputView1,*inputView2,*inputView3;
    SVTextField *eLName1,*eLMul1,*elName;
    SVTextField *eLName2,*eLLevel,*eLMul2;
    NSDictionary *currentData;
    NSDictionary *parData;
    
}

- (id)initWithCompanyArray:(NSMutableArray*)array Data:(NSDictionary*)pd{
    self=[super init];
    if(self){
        parData=pd;
        [self setTitle:@"企业管理"];
        
        if(array){
            [self setCompanyArray:array];
        }else{
            self.companyArray=[[NSMutableArray alloc]init];
            self.heightArray=[[NSMutableArray alloc]init];
            self.lowArray=[[NSMutableArray alloc]init];
        }
        
        [self buildTableViewWithView:self.view];
        UIView *topFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 95)];
        [self.tableView setTableHeaderView:topFrame];
        //头部
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 5, 80, 40)];
        [lbl setText:@"企业名称"];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [lbl setTextColor:TITLECOLOR];
        [topFrame addSubview:lbl];
        eName=[[UITextField alloc]initWithFrame:CGRectMake1(90, 5, 200, 40)];
        [eName setDelegate:self];
        [topFrame addSubview:eName];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(10, 49, 300, 1)];
        [line setBackgroundColor:LINECOLOR];
        [topFrame addSubview:line];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 50, 80, 40)];
        [lbl setText:@"联系电话"];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [lbl setTextColor:TITLECOLOR];
        [topFrame addSubview:lbl];
        ePhone=[[UITextField alloc]initWithFrame:CGRectMake1(90, 50, 200, 40)];
        [ePhone setDelegate:self];
        [topFrame addSubview:ePhone];
        //如果为修改则
        if([self.companyArray count]>0){
            NSDictionary *data=[self.companyArray objectAtIndex:0];
            [eName setText:[data objectForKey:@"NAME"]];
            [ePhone setText:[data objectForKey:@"TEL"]];
        }
        //底部
        UIView *bottomFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 50)];
        [self.tableView setTableFooterView:bottomFrame];
        bSubmit=[[SVButton alloc]initWithFrame:CGRectMake1(10, 5, 300, 40) Title:@"提交" Type:2];
        [bSubmit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        [bottomFrame addSubview:bSubmit];
        
        [self addInputFrame1];
        [self addInputFrame2];
        [self addInputFrame3];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGHeight(40.0);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
    [frame setBackgroundColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1]];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 5, 140, 30)];
    if(section==0){
        [lbl setText:@"高压侧变压器信息"];
    }else{
        [lbl setText:@"低压侧变压器信息"];
    }
    [lbl setFont:[UIFont systemFontOfSize:15]];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [frame addSubview:lbl];
    if(section==0){
        bAdd1=[[SVButton alloc]initWithFrame:CGRectMake1(265, 5, 50,30) Title:@"添加" Type:3];
        [bAdd1 addTarget:self action:@selector(add1:) forControlEvents:UIControlEventTouchUpInside];
        [[bAdd1 titleLabel]setFont:[UIFont systemFontOfSize:14]];
        [frame addSubview:bAdd1];
        bSort=[[SVButton alloc]initWithFrame:CGRectMake1(265, 5, 50,30) Title:@"排序" Type:3];
        [bSort addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
        [[bSort titleLabel]setFont:[UIFont systemFontOfSize:14]];
//        [frame addSubview:bSort];
    }else if(section==1){
        bAdd2=[[SVButton alloc]initWithFrame:CGRectMake1(265, 5, 50,30) Title:@"添加" Type:3];
        [bAdd2 addTarget:self action:@selector(add2:) forControlEvents:UIControlEventTouchUpInside];
        [[bAdd2 titleLabel]setFont:[UIFont systemFontOfSize:14]];
        [frame addSubview:bAdd2];
    }
    return frame;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=[indexPath section];
    if(section==0){
        return CGHeight(60);
    }else{
        return CGHeight(60);
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
        return [self.heightArray count];
    }else{
        return [self.lowArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    static NSString *cellIdentifier = @"EnterpriseHeightLowCell";
    EnterpriseHeightLowEditCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[EnterpriseHeightLowEditCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    if(section==0){
        [cell setController:self];
        [cell setData:[self.heightArray objectAtIndex:row]];
    }else{
        [cell setData:[self.lowArray objectAtIndex:row]];
    }
    return cell;
}

//要求委托方的编辑风格在表视图的一个特定的位置。
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    if(section==0){
        return UITableViewCellEditingStyleDelete;
    }else if(section==1){
        NSDictionary *data=[self.lowArray objectAtIndex:row];
        NSString *EQ_TYPE=[data objectForKey:@"EQ_TYPE"];
        if([@"5" isEqualToString:EQ_TYPE]){
            return UITableViewCellEditingStyleDelete;
        }
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    if(section==0){
        //请求数据源提交的插入或删除指定行接收者。
        if(editingStyle ==UITableViewCellEditingStyleDelete){
            //如果编辑样式为删除样式
            if(row<[self.heightArray count]){
                tmpRow=row;
                NSDictionary *data=[self.heightArray objectAtIndex:row];
                NSString *EQ_TYPE=[data objectForKey:@"EQ_TYPE"];
                if([@"1" isEqualToString:EQ_TYPE]){
                    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                                  initWithTitle:@"删除进线会一同删除线下的变压器信息，确定要删除吗？"
                                                  delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  destructiveButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
                    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
                }else{
                    //移除数据源的数据
                    [self.heightArray removeObjectAtIndex:row];
                    //移除tableView中的数据
                    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                }
            }
        }
    }else if(section==1){
        //请求数据源提交的插入或删除指定行接收者。
        if(editingStyle ==UITableViewCellEditingStyleDelete){
            //如果编辑样式为删除样式
            if(row<[self.lowArray count]){
                //移除数据源的数据
                [self.lowArray removeObjectAtIndex:row];
                //移除tableView中的数据
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            }
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)add1:(UIButton*)sender
{
    [inputView1 setHidden:NO];
}

- (void)add2:(UIButton*)sender
{
//    UIAlertView *alert = [[UIAlertView alloc]
//                          initWithTitle:@""
//                          message:@"添加直流屏"
//                          delegate:self
//                          cancelButtonTitle:@"取消"
//                          otherButtonTitles:@"确定",nil];
//    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
//    [alert show];
    [inputView3 setHidden:NO];
}

- (void)sort:(UIButton*)sender
{
    NSLog(@"排序");
}

- (void)submit:(UIButton*)sender
{
    NSString *name=[eName text];
    if([@"" isEqualToString:name]){
        [Common alert:@"请输入企业名称"];
        return;
    }
    NSString *phone=[ePhone text];
    if([@"" isEqualToString:phone]){
        [Common alert:@"请输入联系电话"];
        return;
    }
    if([self.heightArray count]==0){
        [Common alert:@"高压侧进线和变压器信息不能为空"];
        return;
    }
    NSMutableString *deviceTypeBuf=[[NSMutableString alloc]init];
    NSMutableString *deviceNameBuf=[[NSMutableString alloc]init];
    NSMutableString *deviceLevelBuf=[[NSMutableString alloc]init];
    NSMutableString *deviceRateBuf=[[NSMutableString alloc]init];
    NSMutableString *deviceIdBuf=[[NSMutableString alloc]init];
    NSMutableString *deviceOrderBuf=[[NSMutableString alloc]init];
    for(id d in self.heightArray){
        [deviceNameBuf appendFormat:@"%@,",[d objectForKey:@"EQ_NAME"]];
        [deviceLevelBuf appendFormat:@"%@,",[d objectForKey:@"EQ_U_LEVEL"]];
        [deviceTypeBuf appendFormat:@"%@,",[d objectForKey:@"EQ_TYPE"]];
        [deviceRateBuf appendFormat:@"%@,",[d objectForKey:@"EQ_MULTIPLY"]];
        [deviceIdBuf appendFormat:@"%@,",[d objectForKey:@"EQ_NO"]];
        [deviceOrderBuf appendFormat:@"%@,",[d objectForKey:@"EQ_SORTNO"]];
    }
    for(id d in self.lowArray){
        [deviceNameBuf appendFormat:@"%@,",[d objectForKey:@"EQ_NAME"]];
        [deviceLevelBuf appendFormat:@"%@,",[d objectForKey:@"EQ_U_LEVEL"]];
        [deviceTypeBuf appendFormat:@"%@,",[d objectForKey:@"EQ_TYPE"]];
        [deviceRateBuf appendFormat:@"%@,",[d objectForKey:@"EQ_MULTIPLY"]];
        if([@"5" isEqualToString:[d objectForKey:@"EQ_TYPE"]]&&[@"" isEqualToString:[d objectForKey:@"EQ_NO"]]){
            NSDictionary *d1=[self.heightArray objectAtIndex:0];
            [d setObject:[d1 objectForKey:@"EQ_NO"] forKey:@"EQ_NO"];
        }
        [deviceIdBuf appendFormat:@"%@,",[d objectForKey:@"EQ_NO"]];
        [deviceOrderBuf appendFormat:@"%@,",[d objectForKey:@"EQ_SORTNO"]];
    }
    NSRange deleteRange1 = {[deviceNameBuf length]-1,1};
    [deviceNameBuf deleteCharactersInRange:deleteRange1];
    NSRange deleteRange2 = {[deviceLevelBuf length]-1,1};
    [deviceLevelBuf deleteCharactersInRange:deleteRange2];
    NSRange deleteRange3 = {[deviceTypeBuf length]-1,1};
    [deviceTypeBuf deleteCharactersInRange:deleteRange3];
    NSRange deleteRange4 = {[deviceRateBuf length]-1,1};
    [deviceRateBuf deleteCharactersInRange:deleteRange4];
    NSRange deleteRange5 = {[deviceIdBuf length]-1,1};
    [deviceIdBuf deleteCharactersInRange:deleteRange5];
    NSRange deleteRange6 = {[deviceOrderBuf length]-1,1};
    [deviceOrderBuf deleteCharactersInRange:deleteRange6];
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:[[User Instance]getPassword] forKey:@"authentication"];
    [params setObject:@"EQ02" forKey:@"GNID"];
    
    if(parData){
        [params setObject:[parData objectForKey:@"CP_ID"] forKey:@"QTCP"];
    }else{
        [params setObject:@"" forKey:@"QTCP"];
    }
    [params setObject:name forKey:@"QTKEY"];
    [params setObject:phone forKey:@"QTVAL"];
    [params setObject:deviceTypeBuf forKey:@"QTEQTYPE"];
    [params setObject:deviceNameBuf forKey:@"QTKEY1"];
    [params setObject:deviceLevelBuf forKey:@"QTVAL1"];
    [params setObject:deviceIdBuf forKey:@"QTVAL2"];
    [params setObject:deviceRateBuf forKey:@"QTKEY2"];
    [params setObject:deviceOrderBuf forKey:@"QTSORT"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:501];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:URL_appTaskingFps requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        [Common alert:[response msg]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)addLine:(NSDictionary*)data
{
    currentData=data;
    [inputView2 setHidden:NO];
}

- (void)save:(UIButton*)sender
{
    if(sender.tag==1){
        NSString *name=[eLName1.tf text];
        NSString *mul=[eLMul1.tf text];
        if([@"" isEqualToString:name]){
            [Common alert:@"名称不能为空"];
            return;
        }
        if([@"" isEqualToString:mul]){
            [Common alert:@"倍率不能为空"];
            return;
        }
        NSMutableDictionary *data=[[NSMutableDictionary alloc]init];
        //添加进线
        [data setObject:name forKey:@"EQ_NAME"];
        [data setObject:mul forKey:@"EQ_MULTIPLY"];
        [data setObject:@"1" forKey:@"EQ_TYPE"];
        [data setObject:@"" forKey:@"EQ_U_LEVEL"];
        if([self.heightArray count]>0){
            //获取最后一个ID的值并加1
            NSDictionary *d=[self.heightArray objectAtIndex:[self.heightArray count]-1];
            int parentId=[[d objectForKey:@"EQ_NO"] intValue];
            [data setObject:[NSString stringWithFormat:@"%d",parentId+1] forKey:@"EQ_NO"];
        }else{
           [data setObject:@"1" forKey:@"EQ_NO"];
        }
        [data setObject:@"-1" forKey:@"EQ_SORTNO"];
        for(id d in self.heightArray){
            NSString *n=[d objectForKey:@"EQ_NAME"];
            if([name isEqualToString:n]){
                [Common alert:[NSString stringWithFormat:@"%@已经存在，不能重复添加",name]];
                return;
            }
        }
        [self.heightArray addObject:data];
        [self.tableView reloadData];
        [eLName1.tf setText:@""];
        [eLMul1.tf setText:@""];
        [eLName1 resignFirstResponder];
        [eLMul1 resignFirstResponder];
        [inputView1 setHidden:YES];
    }else if(sender.tag==2){
        NSString *name=[eLName2.tf text];
        NSString *level=[eLLevel.tf text];
        NSString *mul=[eLMul2.tf text];
        if([@"" isEqualToString:name]){
            [Common alert:@"名称不能为空"];
            return;
        }
        if([@"" isEqualToString:level]){
            [Common alert:@"等级不能为空"];
            return;
        }
        if([@"" isEqualToString:mul]){
            [Common alert:@"倍率不能为空"];
            return;
        }
        NSMutableDictionary *data=[[NSMutableDictionary alloc]init];
        //添加变压器
        [data setObject:name forKey:@"EQ_NAME"];
        [data setObject:level forKey:@"EQ_U_LEVEL"];
        [data setObject:mul forKey:@"EQ_MULTIPLY"];
        [data setObject:@"3" forKey:@"EQ_TYPE"];
        int parentId=[[currentData objectForKey:@"EQ_NO"] intValue];
        [data setObject:[NSString stringWithFormat:@"%d",parentId] forKey:@"EQ_NO"];
        [data setObject:[NSString stringWithFormat:@"%d",[self.heightArray count]+1] forKey:@"EQ_SORTNO"];
        for(id d in self.heightArray){
            NSString *n=[d objectForKey:@"EQ_NAME"];
            if([name isEqualToString:n]){
                [Common alert:[NSString stringWithFormat:@"%@已经存在，不能重复添加",name]];
                return;
            }
        }
        NSString *n=[currentData objectForKey:@"EQ_NAME"];
        NSMutableArray *tmpArray=[[NSMutableArray alloc]init];
        for(id d in self.heightArray){
            [tmpArray addObject:d];
            NSString *tmpName=[d objectForKey:@"EQ_NAME"];
            if([n isEqualToString:tmpName]){
                [tmpArray addObject:data];
            }
        }
        [self.heightArray removeAllObjects];
        [self.heightArray addObjectsFromArray:tmpArray];
        [self.tableView reloadData];
        [eLName2.tf setText:@""];
        [eLLevel.tf setText:@""];
        [eLMul2.tf setText:@""];
        [eLName2.tf resignFirstResponder];
        [eLLevel.tf resignFirstResponder];
        [eLMul2.tf resignFirstResponder];
        [inputView2 setHidden:YES];
    }else{
        NSString *cname=[elName.tf text];
        NSMutableDictionary *data=[[NSMutableDictionary alloc]init];
        [data setObject:cname forKey:@"EQ_NAME"];
        [data setObject:@"" forKey:@"EQ_U_LEVEL"];
        [data setObject:@"5" forKey:@"EQ_TYPE"];
        [data setObject:@"" forKey:@"EQ_NO"];
        [data setObject:@"" forKey:@"EQ_MULTIPLY"];
        [data setObject:@"0" forKey:@"EQ_SORTNO"];
        for(id d in self.lowArray){
            NSString *name=[d objectForKey:@"EQ_NAME"];
            if([cname isEqualToString:name]){
                [Common alert:[NSString stringWithFormat:@"%@已经存在，不能重复添加",cname]];
                return;
            }
        }
        [self.lowArray addObject:data];
        [self.tableView reloadData];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
        //确定
        NSMutableArray *delelist=[[NSMutableArray alloc]init];
        [delelist addObject:[self.heightArray objectAtIndex:tmpRow]];
        if(tmpRow>=0){
            if(tmpRow<self.heightArray.count-1){
                for(int i=tmpRow+1;i<self.heightArray.count;i++){
                    NSDictionary *data=[self.heightArray objectAtIndex:i];
                    NSString *EQ_TYPE=[data objectForKey:@"EQ_TYPE"];
                    if([@"1" isEqualToString:EQ_TYPE]){
                        break;
                    }else if([@"3" isEqualToString:EQ_TYPE]){
                        [delelist addObject:[self.heightArray objectAtIndex:i]];
                    }
                }
            }
            for(id d in delelist){
                [self.heightArray removeObject:d];
            }
            [self.tableView reloadData];
            tmpRow=0;
        }
    }else{
        //取消
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1){
        NSString *cname=[[alertView textFieldAtIndex:0]text];
        NSMutableDictionary *data=[[NSMutableDictionary alloc]init];
        [data setObject:cname forKey:@"EQ_NAME"];
        [data setObject:@"" forKey:@"EQ_U_LEVEL"];
        [data setObject:@"5" forKey:@"EQ_TYPE"];
        [data setObject:@"" forKey:@"EQ_NO"];
        [data setObject:@"" forKey:@"EQ_MULTIPLY"];
        [data setObject:@"0" forKey:@"EQ_SORTNO"];
        for(id d in self.lowArray){
            NSString *name=[d objectForKey:@"EQ_NAME"];
            if([cname isEqualToString:name]){
                [Common alert:[NSString stringWithFormat:@"%@已经存在，不能重复添加",cname]];
                return;
            }
        }
        [self.lowArray addObject:data];
        [self.tableView reloadData];
    }
}

- (void)goHiden:(id)sender
{
    [inputView1 setHidden:YES];
    [inputView2 setHidden:YES];
    [inputView3 setHidden:YES];
}

- (void)addInputFrame1
{
    inputView1=[[UIView alloc]initWithFrame:self.view.bounds];
    [inputView1 setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [inputView1 setBackgroundColor:INPUTBGCOLOR];
    [inputView1 setUserInteractionEnabled:YES];
    [inputView1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goHiden:)]];
    [self.view addSubview:inputView1];
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(10, 10, 300, 200)];
    [frame setBackgroundColor:[UIColor whiteColor]];
    [inputView1 addSubview:frame];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 10, 300, 30)];
    [lbl setText:@"添加进线"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setFont:[UIFont systemFontOfSize:15]];
    [frame addSubview:lbl];
    eLName1=[[SVTextField alloc]initWithFrame:CGRectMake1(20, 50, 260, 40) Title:@"名称"];
    [eLName1.tf setPlaceholder:@"如：基线9500线"];
    [frame addSubview:eLName1];
    eLMul1=[[SVTextField alloc]initWithFrame:CGRectMake1(20, 100, 260, 40) Title:@"倍率"];
    [eLMul1.tf setPlaceholder:@"如：100000"];
    [frame addSubview:eLMul1];
    SVButton *bSave=[[SVButton alloc]initWithFrame:CGRectMake1(10, 150, 280, 40) Title:@"提交" Type:2];
    bSave.tag=1;
    [bSave addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [frame addSubview:bSave];
    [inputView1 setHidden:YES];
}

- (void)addInputFrame2
{
    inputView2=[[UIView alloc]initWithFrame:self.view.bounds];
    [inputView2 setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [inputView2 setBackgroundColor:INPUTBGCOLOR];
    [inputView2 setUserInteractionEnabled:YES];
    [inputView2 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goHiden:)]];
    [self.view addSubview:inputView2];
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(10, 10, 300, 250)];
    [frame setBackgroundColor:[UIColor whiteColor]];
    [inputView2 addSubview:frame];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 10, 300, 30)];
    [lbl setText:@"添加变压器"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setFont:[UIFont systemFontOfSize:15]];
    [frame addSubview:lbl];
    eLName2=[[SVTextField alloc]initWithFrame:CGRectMake1(20, 50, 260, 40) Title:@"名称"];
    [eLName2.tf setPlaceholder:@"如：1号主变"];
    [frame addSubview:eLName2];
    eLLevel=[[SVTextField alloc]initWithFrame:CGRectMake1(20, 100, 260, 40) Title:@"电压等级"];
    [eLLevel.tf setPlaceholder:@"如：10Kv"];
    [frame addSubview:eLLevel];
    eLMul2=[[SVTextField alloc]initWithFrame:CGRectMake1(20, 150, 260, 40) Title:@"倍率"];
    [eLMul2.tf setPlaceholder:@"如：100000"];
    [frame addSubview:eLMul2];
    SVButton *bSave=[[SVButton alloc]initWithFrame:CGRectMake1(10, 200, 280, 40) Title:@"提交" Type:2];
    bSave.tag=2;
    [bSave addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [frame addSubview:bSave];
    [inputView2 setHidden:YES];
}

- (void)addInputFrame3
{
    inputView3=[[UIView alloc]initWithFrame:self.view.bounds];
    [inputView3 setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [inputView3 setBackgroundColor:INPUTBGCOLOR];
    [inputView3 setUserInteractionEnabled:YES];
    [inputView3 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goHiden:)]];
    [self.view addSubview:inputView3];
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(10, 10, 300, 150)];
    [frame setBackgroundColor:[UIColor whiteColor]];
    [inputView3 addSubview:frame];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 10, 300, 30)];
    [lbl setText:@"添加直流屏"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setFont:[UIFont systemFontOfSize:15]];
    [frame addSubview:lbl];
    elName=[[SVTextField alloc]initWithFrame:CGRectMake1(20, 50, 260, 40) Title:@"名称"];
    [elName.tf setPlaceholder:@"直流屏名称"];
    [frame addSubview:elName];
    SVButton *bSave=[[SVButton alloc]initWithFrame:CGRectMake1(10, 100, 280, 40) Title:@"提交" Type:2];
    bSave.tag=3;
    [bSave addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [frame addSubview:bSave];
    [inputView3 setHidden:YES];
}

//重新加载列表数据
- (void)reloadTableData
{
    NSMutableArray *tmpArrayMain=[[NSMutableArray alloc]init];
    NSMutableArray *tmpArrayChild=[[NSMutableArray alloc]init];
    for(id d in self.heightArray){
        if(![@"1" isEqualToString:[d objectForKey:@"EQ_TYPE"]]){
            [tmpArrayMain addObject:d];
        }else if(![@"3" isEqualToString:[d objectForKey:@"EQ_TYPE"]]){
            [tmpArrayChild addObject:d];
        }
    }
}


@end
