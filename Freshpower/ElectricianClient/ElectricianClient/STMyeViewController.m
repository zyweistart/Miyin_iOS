//
//  STMyeViewController.m
//  ElectricianRun
//  我的e电工
//  Created by Start on 1/24/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STMyeViewController.h"
#import "STLoginViewController.h"
#import "STAboutUsViewController.h"
#import "STFeedbackViewController.h"
#import "FileUtils.h"

@interface STMyeViewController ()

@end

@implementation STMyeViewController {
    NSString *cacheName;
}

- (id)init {
    self=[super init];
    if(self) {
        self.title=@"我的e电工";
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style: UITableViewStyleGrouped];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        cacheName=nil;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 5;
    }else{
        return 1;
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    static NSString *CellIdentifier=@"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSInteger row=[indexPath row];
    NSInteger section=[indexPath section];
    if(section==0){
        if(row==0){
            if([Account isLogin]){
                cell.textLabel.text=@"切换账户";
                cell.detailTextLabel.textColor=[UIColor redColor];
                cell.detailTextLabel.text=[Account getUserName];
            }else{
                cell.textLabel.text=@"登录账户";
                cell.detailTextLabel.text=@"";
            }
        }else if(row==1){
            cell.textLabel.text=@"推荐给好友";
        }else if(row==2){
            cell.textLabel.text=@"联系新能量";
        }else if(row==3){
            cell.textLabel.text=@"我要购买";
        }else{
            cell.textLabel.text=@"用户反馈";
        }
    }else if(section==1){
        cell.textLabel.text=@"关于e电工";
    }else if(section==2){
        if(cacheName!=nil){
            cell.textLabel.text=[NSString stringWithFormat:@"缓存大小:%@",cacheName];
        }else{
            cell.textLabel.text=@"正在计算...";
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
            dispatch_async(queue, ^{
                long long cachesize=[FileUtils getCacheSize];
                if(cachesize/1024/1024>1024){//GB
                    float totla=(float)cachesize/1024/1024;
                    cacheName=[NSString stringWithFormat:@"%.2fGB",totla/1024];
                }else if(cachesize/1024>1024){//MB
                    float totla=(float)cachesize/1024;
                    cacheName=[NSString stringWithFormat:@"%.2fMB",totla/1024];
                }else{//KB
                    cacheName=[NSString stringWithFormat:@"%lldKB",cachesize/1024];
                }
                dispatch_sync(dispatch_get_main_queue(), ^{
                    cell.textLabel.text=[NSString stringWithFormat:@"缓存大小:%@",cacheName];
                });
            });
        }
    }
    if(section!=3){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row=[indexPath row];
    NSInteger section=[indexPath section];
    if(section==0){
        if(row==0){
            STLoginViewController *loginViewController=[[STLoginViewController alloc]init];
            [self.navigationController pushViewController:loginViewController animated:YES];
        }else if(row==1){
            [Common share:self];
        }else if(row==2){
            [Common actionSheet:self message:@"是否拨打新能量客服电话？" tag:1];
        }else if(row==3){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:PAYURL]];
        }else{
            STFeedbackViewController *feedbackViewController=[[STFeedbackViewController alloc]init];
            [self.navigationController pushViewController:feedbackViewController animated:YES];
        }
    }else if(section==1){
        STAboutUsViewController *aboutUsViewController=[[STAboutUsViewController alloc]init];
        [self.navigationController pushViewController:aboutUsViewController animated:YES];
    }else if(section==2){
        [Common actionSheet:self message:@"确认要删除所有缓存数据吗？" tag:2];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(actionSheet.tag==1) {
        if(buttonIndex==0){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"tel://%@",CUSTOMERSERVICETEL]]];
        }
    }else if(actionSheet.tag==2){
        if(buttonIndex==0){
            //创建文件管理器
            NSFileManager* fileManager = [NSFileManager defaultManager];
            //获取Documents主目录
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            //得到相应的Documents的路径
            NSString* docDir = [paths objectAtIndex:0];
            //更改到待操作的目录下
            [fileManager changeCurrentDirectoryPath:[docDir stringByExpandingTildeInPath]];
            
            //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
            NSArray *fileList = [fileManager contentsOfDirectoryAtPath:docDir error:nil];
            for(NSString *file in fileList){
                NSString *path = [docDir stringByAppendingPathComponent:file];
                //如果图标文件已经存在则进行显示否则进行下载
                if([fileManager fileExistsAtPath:path]){
                    [fileManager removeItemAtPath:path error:nil];
                }
            }
            [Common alert:@"缓存清除成功"];
            cacheName=nil;
            [self.tableView reloadData];
        }
    }
}


@end
