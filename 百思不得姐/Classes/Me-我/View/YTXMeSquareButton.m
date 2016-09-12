//
//  YTXMeSquareButton.m
//  百思不得姐
//
//  Created by 俞天 on 16/8/30.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXMeSquareButton.h"
#import "YTXMeSquare.h"
#import <UIButton+WebCache.h>
@implementation YTXMeSquareButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.ytx_y = self.ytx_height * 0.1;
    self.imageView.ytx_height = self.ytx_height * 0.5;
    self.imageView.ytx_width = self.imageView.ytx_height;
    self.imageView.ytx_centerX = self.ytx_width *0.5;
    
    self.titleLabel.ytx_x = 0;
    self.titleLabel.ytx_y = self.imageView.ytx_bottom;
    self.titleLabel.ytx_width = self.ytx_width;
    self.titleLabel.ytx_height = self.ytx_height - self.titleLabel.ytx_y;
}

- (void)setSquare:(YTXMeSquare *)square
{
    _square = square;
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
}
@end
