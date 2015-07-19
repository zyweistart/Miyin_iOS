#import "MainAppViewController.h"

#import "NewsDetailViewController.h"

#import "BannerCell.h"
#import "AdvertCell.h"
#import "NewsItemCell.h"

@interface MainAppViewController ()

@end

@implementation MainAppViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"照明产业"];
        self.isFirstRefresh=YES;
        self.hDownload=[[HttpDownload alloc]initWithDelegate:self];
        UIButton *bScreening = [[UIButton alloc]init];
        [bScreening setFrame:CGRectMake1(0, 0, 30, 30)];
        [bScreening setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
        [bScreening addTarget:self action:@selector(goCategory:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                target:nil action:nil];
        negativeSpacerRight.width = -10;
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacerRight, [[UIBarButtonItem alloc] initWithCustomView:bScreening], nil];
        
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        NSInteger row=[indexPath row];
        NSDictionary *data=[self.dataItemArray objectAtIndex:row];
        NSString *key=[data objectForKey:@"key"];
        if([@"banner" isEqualToString:key]){
            return CGHeight(100);
        }else if([@"advert" isEqualToString:key]){
            return CGHeight(100);
        }else{
            return CGHeight(80);
        }
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        NSInteger row=[indexPath row];
        NSDictionary *data=[self.dataItemArray objectAtIndex:row];
        NSString *key=[data objectForKey:@"key"];
        if([@"banner" isEqualToString:key]){
            //一般每个页面只会调用一次
            NSArray *d=[data objectForKey:@"Data"];
            BannerCell *cell = [[BannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BannerCell" Data:d];
            [cell setCurrentController:self];
            return cell;
        }else if([@"advert" isEqualToString:key]){
            //广告位
            static NSString *cellIdentifier = @"AdvertCell";
            AdvertCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(!cell) {
                cell = [[AdvertCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            return cell;
        }else{
            //新闻项
            static NSString *cellIdentifier = @"NewsItemCell";
            NewsItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(!cell) {
                cell = [[NewsItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            NSString *url=[data objectForKey:@"images"];
            NSString *imageUrl=[NSString stringWithFormat:@"%@%@",HTTP_URL,url];
            [self.hDownload AsynchronousDownloadWithUrl:imageUrl RequestCode:500 Object:cell.image];
            [cell.lblTitle setText:[data objectForKey:@"title"]];
            [cell.lblContent setText:[data objectForKey:@"content"]];
            return cell;
        }
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        NSInteger row=[indexPath row];
        NSDictionary *data=[self.dataItemArray objectAtIndex:row];
        NSString *key=[data objectForKey:@"key"];
        if([@"banner" isEqualToString:key]){
        }else if([@"advert" isEqualToString:key]){
        }else{
            [self.navigationController pushViewController:[[NewsDetailViewController alloc]initWithData:data] animated:YES];
        }
    }
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"3" forKey:@"Id"];
    [params setObject:[NSString stringWithFormat:@"%ld",[self currentPage]] forKey:@"index"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setRequestCode:500];
    [self.hRequest handle:@"GetListALL" requestParams:params];
}

- (void)requestFinishedByRequestCode:(NSInteger)reqCode Path:(NSString*)path Object:(id)sender
{
    if(reqCode==500){
        UIImageView *imageView=(UIImageView*)sender;
        if(imageView){
            UIImage *image=[[UIImage alloc] initWithContentsOfFile:path];
            if(image){
                [imageView setImage:image];
            }
        }
    }
}

- (void)goCategory:(id)sender
{
    
}

@end