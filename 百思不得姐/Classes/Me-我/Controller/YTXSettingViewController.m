//
//  YTXSettingViewController.m
//  百思不得姐
//
//  Created by 俞天 on 16/8/25.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXSettingViewController.h"
#import <SDImageCache.h>
#import "YTXClearCacheCell.h"


@interface YTXSettingViewController ()

@end

@implementation YTXSettingViewController

static NSString *const YTXClearCacheCellId = @"YTXClearCacheCell";
static NSString *const YTXSettingCellId = @"YTXSettingCell";


- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YTXCommonBgColor;
    self.navigationItem.title = @"设置";
    
    [self.tableView registerClass:[YTXClearCacheCell class] forCellReuseIdentifier:YTXClearCacheCellId];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:YTXSettingCellId];
    
//    [self getCacheSize];
}

- (void)getCacheSize
{
    //总大小
    unsigned long long size = 0;
    
    //获取缓存文件夹路径
    NSString *cachespath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *dirpath = [cachespath stringByAppendingPathComponent:@"default"];
//    YTXLog(@"%@",dirpath);
    
    //文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    //获得文件的大小 == 获得文件夹中所有文件的总大小
    //Enumerator:遍历器\迭代器
    NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:dirpath];
    for (NSString *subpath in enumerator) {
        //全路径
        NSString *fullSubpath = [dirpath stringByAppendingPathComponent:subpath];
        //累加文件大小
        size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
    }
    
    YTXLog(@"%zd",size);
}

- (void)getCacheSize2
{
    //总大小
    unsigned long long size = 0;
    
    //获得缓存文件夹路径
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *dirpath = [cachesPath stringByAppendingPathComponent:@"default"];
    
    //文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    //获得文件夹的大小 == 获得文件夹中所有文件的总大小
    NSArray *subpaths = [mgr subpathsAtPath:dirpath];
    for (NSString *subpath in subpaths) {
        //全路径
        NSString *fullSubpath = [dirpath stringByAppendingPathComponent:subpath];
        //累计文件大小
        size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
    }
    YTXLog(@"%zd",size);
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    if (section == 1) {
        return 5;
    }
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
//        YTXClearCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:YTXClearCacheCellId];
//        
//        UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)cell.accessoryView;
//        [loadingView startAnimating];
//        return cell;
        return [tableView dequeueReusableCellWithIdentifier:YTXClearCacheCellId];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YTXSettingCellId];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd - %zd",indexPath.section,indexPath.row];
    return cell;


}


#pragma mark
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[YTXSettingCellId class]]) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
