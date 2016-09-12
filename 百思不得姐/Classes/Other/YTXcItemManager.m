//
//  YTXcItemManager.m
//  百思不得姐
//
//  Created by 俞天 on 16/8/25.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXcItemManager.h"

@implementation YTXcItemManager
+ (UIBarButtonItem *)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
@end
