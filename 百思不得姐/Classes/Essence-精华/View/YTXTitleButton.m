//
//  YTXTitleButton.m
//  百思不得姐
//
//  Created by 俞天 on 16/9/1.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXTitleButton.h"

@implementation YTXTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置按钮颜色
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

@end
