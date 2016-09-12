//
//  YTXRecommendTagViewController.m
//  百思不得姐
//
//  Created by 俞天 on 16/9/9.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXRecommendTagViewController.h"
#import "YTXHTTPSessionManager.h"
#import <MJExtension.h>
#import "YTXRecommendTag.h"
#import "YTXRecommendTagCell.h"
#import <SVProgressHUD.h>

@interface YTXRecommendTagViewController ()
/** 所有的标签数据(数组中存放的都是YTXRecommendTag模型)  */
@property (nonatomic, strong) NSArray<YTXRecommendTag *> *recommendTags;

/** 请求管理者 */
@property (nonatomic, weak) YTXHTTPSessionManager  *manager;
@end

@implementation YTXRecommendTagViewController

/**manager属性的懒加载 */
- (YTXHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [YTXHTTPSessionManager manager];
    }
    return _manager;
}

/** cell的重用标识 */
static NSString *const YTXRecommendTagCellId = @"recommendTag";

#pragma mark 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //基本设置
    self.navigationItem.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YTXRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:YTXRecommendTagCellId];
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = YTXCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //加载标签数据
    [self loadNewRecommandTags];
}

/**
 *  加载标签数据
 */
- (void)loadNewRecommandTags
{
    [SVProgressHUD show];
    __weak typeof(self) weakSelf = self;
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    //发送请求
    [self.manager GET:YTXCommonURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //数组字典 -> 模型数组
        weakSelf.recommendTags = [YTXRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        //刷新
        [weakSelf.tableView reloadData];
        
        //去除HUD
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //如果取消任务，就直接返回
        if (error.code == NSURLErrorCancelled) return;
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络繁忙, 请稍后再试"];
    }];
}

/**
 *  当控制器的view即将消失的时候调用
 */

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
    
    [self.manager invalidateSessionCancelingTasks:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.recommendTags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YTXRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:YTXRecommendTagCellId];
    
    cell.recommendTag = self.recommendTags[indexPath.row];

    return cell;
}




@end
