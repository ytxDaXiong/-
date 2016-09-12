//
//  YTXTopicViewController.m
//  百思不得姐
//
//  Created by 俞天 on 16/9/8.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXTopicViewController.h"
#import "YTXTopic.h"
#import "YTXHTTPSessionManager.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "YTXRefreshHeader.h"
#import "YTXRefreshFooter.h"
#import "YTXTopicCell.h"
#import "YTXNewViewController.h"
@interface YTXTopicViewController ()
/** 所有的帖子数据 */
@property (nonatomic, strong) NSMutableArray<YTXTopic *> *topics;
/** 下拉刷新的提示文字 */
@property (nonatomic, weak) UILabel *label;
/** maxtime : 用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;
/** 任务管理者 */
@property (nonatomic, strong) YTXHTTPSessionManager *manager;

/** 声明这个方法的目的 : 为了能够使用点语法的智能提示 */
- (NSString *)aParam;
@end

@implementation YTXTopicViewController
#pragma mark - 仅仅是为了消除编译器发出的警告 : type方法没有实现
- (YTXTopicType)type
{
    return 0;
}
static NSString * const YTXTopicCellId = @"topic";
- (YTXHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [YTXHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    [self setupRefresh];
}

- (void)setupTable
{
    self.tableView.backgroundColor = YTXCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YTXTopicCell class]) bundle:nil] forCellReuseIdentifier:YTXTopicCellId];
    
    
}

- (void)setupRefresh
{
    self.tableView.mj_header = [YTXRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [YTXRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

- (NSString *)aParam
{
    if (self.parentViewController.class == [YTXNewViewController class]) {
        return @"newlist";
    }
    return @"list";
}

#pragma mark -数据加载
- (void)loadNewTopics
{
    //取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"type"] =@(self.type);
    
    //发送请求
    [self.manager GET:YTXCommonURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //存储maxtime(方便用来加载第一页数据)
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典数组 -> 模型数组
        self.topics = [YTXTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
        //        for (NSUInteger i = 0; i < self.topics.count; i++) {
        //            if (self.topics[i].top_cmt.count) {
        //                YTXLog(@"下拉刷新 - %zd", i);
        //            }
        //        }
        //刷新表格
        [self.tableView reloadData];
        
        //让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == NSURLErrorCancelled) {
            //取消了任务
        } else {
            //是其他错误
        }
        YTXLog(@"请求失败 - %@", error);
        
        //让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreTopics
{
    //取消所有的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"maxtime"] = self.maxtime;
    params[@"type"] = @(self.type);
    
    //发送请求
    [[AFHTTPSessionManager manager] GET:YTXCommonURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //存储这页对应的maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典数组 -> 模型数组
        NSArray<YTXTopic *>*moreTopics = [YTXTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        
        //        for (NSUInteger i = 0 ; i < moreTopics.count; i++) {
        //            if (moreTopics[i].top_cmt.count) {
        //                YTXLog(@"上拉刷新 - %zd", i);
        //            }
        //        }
        
        //刷新表格
        [self.tableView reloadData];
        
        //让[刷新控件]结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YTXLog(@"请求失败 - %@", error);
        
        //让[刷新控件]结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    //1.确定重用标示:
    //    static NSString *ID = @"cell";
    //    //2.从缓存池中取
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //    //3.如果空就手动创建
    //    if (!cell) {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    //        cell.backgroundColor = YTXRandomColor;
    //    }
    //    YTXTopic *topic = self.topics[indexPath.row];
    //    cell.textLabel.text = topic.name;
    //    cell.detailTextLabel.text = topic.text;
    //    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    YTXTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:YTXTopicCellId];
    cell.topic = self.topics[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
#pragma mark - 根据YTXTopic模型数据计算出cell具体的高度，并且返回
    return self.topics[indexPath.row].cellHeight;
    
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
