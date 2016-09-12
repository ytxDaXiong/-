//
//  UIView+YTXExtension.h
//  百思不得姐
//
//  Created by 俞天 on 16/8/24.
//  Copyright © 2016年 sju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YTXExtension)

@property (nonatomic, assign) CGSize ytx_size;
@property (nonatomic, assign) CGFloat ytx_width;
@property (nonatomic, assign) CGFloat ytx_height;
@property (nonatomic, assign) CGFloat ytx_x;
@property (nonatomic, assign) CGFloat ytx_y;
@property (nonatomic, assign) CGFloat ytx_centerX;
@property (nonatomic, assign) CGFloat ytx_centerY;

@property (nonatomic, assign) CGFloat ytx_right;
@property (nonatomic, assign) CGFloat ytx_bottom;
+ (instancetype)viewFromXib;
@end
