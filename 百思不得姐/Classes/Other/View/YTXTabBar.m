//
//  YTXTabBar.m
//  百思不得姐
//
//  Created by 俞天 on 16/8/24.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXTabBar.h"

@interface YTXTabBar()
/**中间的发布按钮**/
@property (nonatomic, weak) UIButton *publishButton;
@end


@implementation YTXTabBar

#pragma mark -懒加载
/**发布按钮**/
- (UIButton *)publishButton
{
    if (!_publishButton) {
        UIButton *publisherButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publisherButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publisherButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publisherButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publisherButton];
        _publishButton = publisherButton;
    }
    return _publishButton;
}


#pragma mark -初始化
/*
    布局子控件
 */

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //NSClassFromString(@"UITabBarButton") == [UITabBarButton class];
    //nscLASSFormString(@"UIButton") == [UIButton class];
    
    //按钮的尺寸
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    
    //按钮索引
    int buttonIndex = 0;
    
    for (UIView *subView in self.subviews) {
        if (subView.class != NSClassFromString(@"UITabBarButton")) continue;
        //设置frame
        
        CGFloat buttonX = buttonIndex * buttonW;
        if (buttonIndex >= 2) {
            buttonX += buttonW;
        }
        subView.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //增加索引
        buttonIndex++;
    }
    /*****设置中间的发布按钮的frame*****/
    self.publishButton.frame = CGRectMake(0, 0, buttonW, buttonH);
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
}

- (void)publishClick
{
    YTXLogFunc
}
@end
