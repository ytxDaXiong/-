//
//  YTXMeViewController.m
//  百思不得姐
//
//  Created by 俞天 on 16/8/24.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXMeViewController.h"
#import "YTXSettingViewController.h"
#import "YTXMeCell.h"
#import "YTXMeFooterView.h"
@interface YTXMeViewController ()

@end

@implementation YTXMeViewController

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    
    [self setupNav];
    
    
}

- (void)setupTable
{
    self.view.backgroundColor = YTXCommonBgColor;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = YTXMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(YTXMargin - 35, 0, 0, 0);
    
    //设置footer
    self.tableView.tableFooterView = [[YTXMeFooterView alloc] init];
    
}

- (void)setupNav
{
    //标题
    self.navigationItem.title = @"我的";
    //右边-设置
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    //右边-月亮
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];

    
}

- (void)settingClick
{
    YTXSettingViewController *setting = [[YTXSettingViewController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}

- (void)moonClick
{
    YTXLogFunc
}


#pragma mark - 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.确定重用标识
    static NSString *ID = @"me";
    //2.从缓存池取
    YTXMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //3.如果空就手动创建
    if (!cell) {
        cell = [[YTXMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //4.设置数据
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    }else {
        cell.textLabel.text = @"离线下载";
        //只要有其他cell设置过imageView.image,其他不显示图片的cell都需要设置imageView.image = nil;
        cell.imageView.image = nil;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 200;
    }else{
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    YTXLog(@"%@",NSStringFromCGRect(cell.frame));
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
