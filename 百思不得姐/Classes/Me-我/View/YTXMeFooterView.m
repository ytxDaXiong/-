//
//  YTXMeFooterView.m
//  百思不得姐
//
//  Created by 俞天 on 16/8/30.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXMeFooterView.h"
#import "YTXMeSquare.h"
#import "YTXHTTPSessionManager.h"
#import <MJExtension.h>
#import "YTXMeSquareButton.h"
#import "YTXWebViewController.h"
@implementation YTXMeFooterView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        //请求
        [[YTXHTTPSessionManager manager]GET:YTXCommonURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [responseObject writeToFile:@"/Users/yutian/Desktop/me.plist" atomically:YES];
            
            NSArray *squares = [YTXMeSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            [self createSquares:squares];
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            YTXLog(@"请求失败 - %@",error);
        }];
        
    }
    return self;
}

/**
 *  根据模型数据创建对应的控件
 */

- (void)createSquares:(NSArray *)squares
{
    //方块个数
    NSUInteger count = squares.count;
    
    //方块尺寸
    int maxColsCount = 4;
    CGFloat buttonW = self.ytx_width / maxColsCount;
    CGFloat buttonH = buttonW;
    
    //创建所有的方块
    for (NSUInteger i = 0; i < count; i++) {
        // i设置对应的数据模型
        YTXMeSquare *square = squares[i];
        //创建按钮
        YTXMeSquareButton *button =[YTXMeSquareButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        //设置frame
        button.ytx_x = (i % maxColsCount) * buttonW;
        button.ytx_y = (i / maxColsCount) * buttonH;
        button.ytx_width = buttonW;
        button.ytx_height = buttonH;
        //设置数据
        button.square = square;
        
        
        //设置footer的高度 == 最后一个按钮的bottom(最大Y值)
        self.ytx_height = self.subviews.lastObject.ytx_bottom;
        
        //设置tableView的contentSize
        UITableView *tableView = (UITableView *)self.superview;
        tableView.tableFooterView = self;
        [tableView reloadData];//重新刷新数据（其实也会重新计算contentsize）
     

    }
}

- (void)buttonClick:(YTXMeSquareButton *)button
{
    NSString *url = button.square.url;
    YTXMeSquare *square = button.square;
    if ([square.url hasPrefix:@"http"]) {
        
        UITabBarController *tabBarVc = (UITabBarController *)self.window.rootViewController;
        UINavigationController *nav = tabBarVc.selectedViewController;
        
        
        YTXWebViewController *webView= [[YTXWebViewController alloc] init];
        webView.url = url;
        webView.navigationItem.title = button.currentTitle;
        [nav pushViewController:webView animated:YES];
        
        
        
        
        
        
        
        
        
        
        
    }else if ([square.url hasPrefix:@"mod"]){
        if ([square.url hasSuffix:@"BDJ_To_Check"]) {
            YTXLog(@"跳转到[审帖]界面");
        }else if ([square.url hasSuffix:@"BDJ_To_RecentHot"]){
            YTXLog(@"跳转到每日排行界面");
        }else{
            YTXLog(@"跳转到其他界面");
        }
    
    } else {
        YTXLog(@"不是http或者mod协议的");
    }
}
@end
