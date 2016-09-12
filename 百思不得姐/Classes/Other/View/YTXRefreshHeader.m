
//
//  YTXRefreshHeader.m
//  百思不得姐
//
//  Created by 俞天 on 16/9/5.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXRefreshHeader.h"

@interface YTXRefreshHeader ()
/** logo **/
@property (nonatomic, weak) UIImageView *logo;
@end

@implementation YTXRefreshHeader
/**
 *  初始化
 */
- (void)prepare
{
    [super prepare];
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
    self.stateLabel.textColor = [UIColor orangeColor];
    [self setTitle:@"赶紧下拉吧" forState:MJRefreshStateIdle];
    [self setTitle:@"赶紧松开吧" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载数据..." forState:MJRefreshStateRefreshing];
    
//    UIImageView *logo = [[UIImageView alloc] init];
//    logo.image = [UIImage imageNamed:@"imageBackground"];
//    [self addSubview:logo];
//    self.logo = logo;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    self.logo.ytx_width = self.ytx_width;
    self.logo.ytx_height = 50;
    self.logo.ytx_x = 0;
    self.logo.ytx_y = -50;
}

@end
