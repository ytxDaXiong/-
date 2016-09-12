//
//  YTXRefreshFooter.m
//  百思不得姐
//
//  Created by 俞天 on 16/9/5.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXRefreshFooter.h"

@implementation YTXRefreshFooter

- (void)prepare
{
    [super prepare];
    
    self.stateLabel.textColor = [UIColor redColor];
//    [self addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
//    //刷新控件出现一半就会进入刷新状态
//    self.triggerAutomaticallyRefreshPercent = 0.5;
//    
//    //不要自动刷新
//    self.automaticallyRefresh = NO;
    
}

@end
