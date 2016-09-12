//
//  YTXQuickLoginButton.m
//  百思不得姐
//
//  Created by 俞天 on 16/8/26.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXQuickLoginButton.h"

@implementation YTXQuickLoginButton
- (void)awakeFromNib
{
//    self.backgroundColor = [UIColor blueColor];
//    self.imageView.backgroundColor = [UIColor redColor];
//    self.titleLabel.backgroundColor = [UIColor greenColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.ytx_y = 0;
    self.imageView.ytx_centerX = self.ytx_width * 0.5;
    self.titleLabel.ytx_x = 0;
    self.titleLabel.ytx_y = self.imageView.ytx_bottom;
    self.titleLabel.ytx_height = self.ytx_height - self.titleLabel.ytx_y;
    self.titleLabel.ytx_width = self.ytx_width;
    
    
}
@end
