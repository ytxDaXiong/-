//
//  UIView+YTXExtension.m
//  百思不得姐
//
//  Created by 俞天 on 16/8/24.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "UIView+YTXExtension.h"

@implementation UIView (YTXExtension)

- (CGSize)ytx_size
{
    return self.frame.size;
}

- (void)setYtx_size:(CGSize)ytx_size
{
    CGRect frame = self.frame;
    frame.size = ytx_size;
    self.frame = frame;
}

- (CGFloat)ytx_width
{
    return self.frame.size.width;
}

- (CGFloat)ytx_height
{
    return self.frame.size.height;
}

- (void)setYtx_width:(CGFloat)ytx_width
{
    CGRect frame = self.frame;
    frame.size.width = ytx_width;
    self.frame = frame;
}

- (void)setYtx_height:(CGFloat)ytx_height
{
    CGRect frame = self.frame;
    frame.size.height = ytx_height;
    self.frame = frame;
    
}

- (CGFloat)ytx_x
{
    return self.frame.origin.x;
}

- (void)setYtx_x:(CGFloat)ytx_x
{
    CGRect frame = self.frame;
    frame.origin.x = ytx_x;
    self.frame = frame;
}

- (CGFloat)ytx_y
{
    return self.frame.origin.y;
}

- (void)setYtx_y:(CGFloat)ytx_y
{
    CGRect frame = self.frame;
    frame.origin.y = ytx_y;
    self.frame = frame;
}

- (CGFloat)ytx_centerX
{
    return self.center.x;
}

- (void)setYtx_centerX:(CGFloat)ytx_centerX
{
    CGPoint center = self.center;
    center.x = ytx_centerX;
    self.center = center;
}

- (CGFloat)ytx_centerY
{
    return self.center.y;
}

- (void)setYtx_centerY:(CGFloat)ytx_centerY
{
    CGPoint center = self.center;
    center.y = ytx_centerY;
    self.center = center;
}

- (CGFloat)ytx_right
{
    //    return self.ytx_x + self.ytx_width;
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)ytx_bottom
{
    //    return self.ytx_y + self.ytx_height;
    return CGRectGetMaxY(self.frame);
}

- (void)setYtx_right:(CGFloat)ytx_right
{
    self.ytx_x = ytx_right - self.ytx_width;
}

- (void)setYtx_bottom:(CGFloat)ytx_bottom
{
    self.ytx_y = ytx_bottom - self.ytx_height;
}

+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

@end
