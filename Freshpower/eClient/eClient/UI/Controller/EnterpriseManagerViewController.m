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

#define LINECOLOR [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1]

@interface EnterpriseManagerViewController ()

@end

@implementation EnterpriseManagerViewController{
    UITextField *eName,*ePhone;
    SVButton *bAdd1,*bAdd2,*bSort,*bSubmit;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"企业管理"];
        [self buildTableViewWithView:self.view];
        UIView *topFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 95)];
        [self.tableView setTableHeaderView:topFrame];
        
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
        UIView *bottomFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 50)];
        [self.tableView setTableFooterView:bottomFrame];
        bSubmit=[[SVButton alloc]initWithFrame:CGRectMake1(10, 5, 300, 40) Title:@"提交" Type:2];
        [bSubmit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        [bottomFrame addSubview:bSubmit];
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
        bAdd1=[[SVButton alloc]initWithFrame:CGRectMake1(210, 5, 50,30) Title:@"添加" Type:3];
        [bAdd1 addTarget:self action:@selector(add1:) forControlEvents:UIControlEventTouchUpInside];
        [[bAdd1 titleLabel]setFont:[UIFont systemFontOfSize:14]];
        [frame addSubview:bAdd1];
        bSort=[[SVButton alloc]initWithFrame:CGRectMake1(265, 5, 50,30) Title:@"排序" Type:3];
        [bSort addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
        [[bSort titleLabel]setFont:[UIFont systemFontOfSize:14]];
        [frame addSubview:bSort];
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
        [cell setTableView:self.tableView];
        [cell setDataItemArray:self.heightArray];
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
    NSString *cname=@"这是测试";
    NSMutableDictionary *data=[[NSMutableDictionary alloc]init];    
    //添加进线
    [data setObject:cname forKey:@"EQ_NAME"];
    [data setObject:@"55.00" forKey:@"EQ_MULTIPLY"];
    [data setObject:@"1" forKey:@"EQ_TYPE"];
    for(id d in self.heightArray){
        NSString *name=[d objectForKey:@"EQ_NAME"];
        if([cname isEqualToString:name]){
            [Common alert:[NSString stringWithFormat:@"%@已经存在，不能重复添加",cname]];
            return;
        }
    }
    [self.heightArray addObject:data];
    [self.tableView reloadData];
}

- (void)add2:(UIButton*)sender
{
    NSString *cname=@"这是测试";
    NSMutableDictionary *data=[[NSMutableDictionary alloc]init];
    [data setObject:cname forKey:@"EQ_NAME"];
    [data setObject:@"5" forKey:@"EQ_TYPE"];
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

- (void)sort:(UIButton*)sender
{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    if([self.tableView isEditing]){
        [sender setTitle:@"提交" forState:UIControlStateNormal];
    }else{
        [sender setTitle:@"排序" forState:UIControlStateNormal];
    }
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
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
        //确定
    }else{
        //取消
    }
}







//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSInteger section=[indexPath section];
//    NSInteger row=[indexPath row];
//    if(section==0){
//        NSDictionary *data=[self.heightArray objectAtIndex:row];
//        NSString *EQ_TYPE=[data objectForKey:@"EQ_TYPE"];
//        if([@"1" isEqualToString:EQ_TYPE]){
//            //子类
//            return YES;
//        }
//    }else{
//
//    }
//    return NO;
//}
//
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
//{
//}
@end
