//
//  STMyeViewController.m
//  ElectricianRun
//  我的e电工
//  Created by Start on 1/24/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STMyeViewController.h"
#import "STLoginViewController.h"
#import "STAlarmSetupViewController.h"
#import "STAboutUsViewController.h"
#import "FileUtils.h"
#define REQUESTCODE1 501
#define REQUESTCODE2 502

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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 3;
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
        }else{
            cell.textLabel.text=@"联系新能量";
        }
    }else if(section==1){
        cell.textLabel.text=@"报警阀值设置";
    }else if(section==2){
        cell.textLabel.text=@"关于e电工";
    }else if(section==3){
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
//            if([Account isLogin]){
//                UIActionSheet *sheet = [[UIActionSheet alloc]
//                                        initWithTitle:@""
//                                        delegate:self
//                                        cancelButtonTitle:@"取消"
//                                        destructiveButtonTitle:@"切换账户"
//                                        otherButtonTitles:@"退出账户",nil];
//                sheet.tag=3;
//                //UIActionSheet与UITabBarController结合使用不能使用[sheet showInView:self.view];
//                [sheet showInView:[UIApplication sharedApplication].keyWindow];
//            }else{
                STLoginViewController *loginViewController=[[STLoginViewController alloc]init];
                [self.navigationController pushViewController:loginViewController animated:YES];
//            }
        }else if(row==1){
            [Common share:self];
        }else{
            [Common actionSheet:self message:@"是否拨打新能量客服电话？" tag:1];
        }
    }else if(section==1){
        if(![Account isLogin]){
            [Common alert:@"你还未登录，请先登录!"];
            STLoginViewController *loginViewController=[[STLoginViewController alloc]init];
            [self.navigationController pushViewController:loginViewController animated:YES];
            return;
        }
        STAlarmSetupViewController *alarmSetupViewController=[[STAlarmSetupViewController alloc]init];
        [self.navigationController pushViewController:alarmSetupViewController animated:YES];
    }else if(section==2){
        STAboutUsViewController *aboutUsViewController=[[STAboutUsViewController alloc]init];
        [self.navigationController pushViewController:aboutUsViewController animated:YES];
    }else{
       [Common actionSheet:self message:@"确认要删除所有缓存数据吗？" tag:2];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(actionSheet.tag==1) {
        if(buttonIndex==0){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"tel://%@",@"4008263365"]]];
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
    }else if(actionSheet.tag==3){
        if(buttonIndex==0||buttonIndex==1){
            NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
            [p setObject:@"zhangyy" forKey:@"imei"];
            [p setObject:@"fdsaf" forKey:@"authentication"];
            [p setObject:@"2" forKey:@"type"];
            [p setObject:@"2" forKey:@"IsEncode"];
            if(buttonIndex==0){
                //切换账户
                self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:REQUESTCODE1];
            }else if(buttonIndex==1){
                //退出账户
                self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:REQUESTCODE2];
            }
            [self.hRequest setIsShowMessage:YES];
            [self.hRequest start:URLcheckMobileValid params:p];
        }
    }
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode
{
    NSString *result=[Common NSNullConvertEmptyString:[[response resultJSON] objectForKey:@"result"]];
    if([@"2" isEqualToString:result]){
        if(repCode==REQUESTCODE1){
            STLoginViewController *loginViewController=[[STLoginViewController alloc]init];
            [self.navigationController pushViewController:loginViewController animated:YES];
        }else if(repCode==REQUESTCODE2){
            [Account clear];
            [self.tableView reloadData];
        }
    }else{
        [Common alert:@"请求异常，请重试!"];
    }
}

@end
