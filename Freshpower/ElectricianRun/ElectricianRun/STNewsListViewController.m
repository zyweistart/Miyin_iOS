//
//  STNewsListViewController.m
//  ElectricianRun
//  新闻列表
//  Created by Start on 1/25/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STNewsListViewController.h"
#import "STNewsDetailViewController.h"
#import "SQLiteOperate.h"

@interface STNewsListViewController () {
    SQLiteOperate *db;
    NSMutableArray *titleArr;
}

@end

@implementation STNewsListViewController

- (id)init {
    self=[super init];
    if(self) {
        self.title=@"新闻列表";
        [self.view setBackgroundColor:[UIColor whiteColor]];
        db=[[SQLiteOperate alloc]init];
        if([db openDB]){
            NSString *sqlQuery = @"SELECT * FROM NEW ORDER BY ID DESC";
            NSMutableArray *indata=[db query:sqlQuery];
            if(indata!=nil&&[indata count]>0){
                titleArr=[[NSMutableArray alloc]initWithArray:indata];
            }
        }
        
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(back:)];
    }
    return self;
}

- (id)initWithData:(NSDictionary*)d
{
    self=[self init];
    if(self){
        [self performSelector:@selector(forward:) withObject:d afterDelay:0.5];
    }
    return self;
}

- (void)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [titleArr count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    static NSString *CellIdentifier=@"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSInteger row=[indexPath row];
    NSDictionary *data=[titleArr objectAtIndex:row];
    
    NSString *icon_name=[data objectForKey:@"icon_name"];
    //创建文件管理器
    NSFileManager* fileManager = [NSFileManager defaultManager];
    //获取Documents主目录
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //得到相应的Documents的路径
    NSString* docDir = [paths objectAtIndex:0];
    //更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[docDir stringByExpandingTildeInPath]];
    NSString *path = [docDir stringByAppendingPathComponent:icon_name];
    //如果图标文件已经存在则进行显示否则进行下载
    if([fileManager fileExistsAtPath:path]){
        [cell.imageView setImage:[UIImage imageWithContentsOfFile:path]];
    }
    cell.textLabel.font=[UIFont systemFontOfSize:12];
    cell.textLabel.text=[data objectForKey:@"name"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row=[indexPath row];
    NSDictionary *data=[titleArr objectAtIndex:row];
    [self forward:data];
}

- (void)forward:(NSDictionary*)data
{
    STNewsDetailViewController *newsDetailViewController=[[STNewsDetailViewController alloc]initWithData:data];
    [self.navigationController pushViewController:newsDetailViewController animated:YES];
}

@end